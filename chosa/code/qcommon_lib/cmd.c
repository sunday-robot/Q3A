// cmd.c -- Quake script command processing module

#include "../qcommon/q_shared.h"
#include "../qcommon/qcommon.h"

#define	MAX_CMD_BUFFER	16384
#define	MAX_CMD_LINE	1024

typedef struct {
	byte	*data;
	int		maxsize;
	int		cursize;
} cmd_t;

int			cmd_wait;
cmd_t		cmd_text;
byte		cmd_text_buf[MAX_CMD_BUFFER];


//=============================================================================

/*
Causes execution of the remainder of the command buffer to be delayed until
next frame.  This allows commands like:
bind g "cmd use rocket ; +attack ; wait ; -attack ; cmd use blaster"
*/
void Cmd_Wait_f(void) {
	if (Cmd_Argc() == 2) {
		cmd_wait = atoi(Cmd_Argv(1));
	} else {
		cmd_wait = 1;
	}
}

void Cbuf_Init() {
	cmd_text.data = cmd_text_buf;
	cmd_text.maxsize = MAX_CMD_BUFFER;
	cmd_text.cursize = 0;
}

/*
Adds command text at the end of the buffer, does NOT add a final \n
*/
void Cbuf_AddText(const char *text) {
	int		l;

	l = strlen(text);

	if (cmd_text.cursize + l >= cmd_text.maxsize) {
		Com_Printf("Cbuf_AddText: overflow\n");
		return;
	}
	Com_Memcpy(&cmd_text.data[cmd_text.cursize], text, l);
	cmd_text.cursize += l;
}


/*
Adds command text immediately after the current command
Adds a \n to the text
*/
void Cbuf_InsertText(const char *text) {
	int		len;
	int		i;

	len = strlen(text) + 1;
	if (len + cmd_text.cursize > cmd_text.maxsize) {
		Com_Printf("Cbuf_InsertText overflowed\n");
		return;
	}

	// move the existing command text
	for (i = cmd_text.cursize - 1; i >= 0; i--) {
		cmd_text.data[i + len] = cmd_text.data[i];
	}

	// copy the new text in
	Com_Memcpy(cmd_text.data, text, len - 1);

	// add a \n
	cmd_text.data[len - 1] = '\n';

	cmd_text.cursize += len;
}


void Cbuf_ExecuteText(int exec_when, const char *text) {
	switch (exec_when) {
	case EXEC_NOW:
		if (text && strlen(text) > 0) {
			Cmd_ExecuteString(text);
		} else {
			Cbuf_Execute();
		}
		break;
	case EXEC_INSERT:
		Cbuf_InsertText(text);
		break;
	case EXEC_APPEND:
		Cbuf_AddText(text);
		break;
	default:
		Com_Error(ERR_FATAL, "Cbuf_ExecuteText: bad exec_when");
	}
}


void Cbuf_Execute(void) {
	int		i;
	char	*text;
	char	line[MAX_CMD_LINE];
	int		quotes;

	while (cmd_text.cursize) {
		if (cmd_wait) {
			// skip out while text still remains in buffer, leaving it
			// for next frame
			cmd_wait--;
			break;
		}

		// find a \n or ; line break
		text = (char *) cmd_text.data;

		quotes = 0;
		for (i = 0; i < cmd_text.cursize; i++) {
			if (text[i] == '"')
				quotes++;
			if (!(quotes & 1) && text[i] == ';')
				break;	// don't break if inside a quoted string
			if (text[i] == '\n' || text[i] == '\r')
				break;
		}

		if (i >= (MAX_CMD_LINE - 1)) {
			i = MAX_CMD_LINE - 1;
		}

		Com_Memcpy(line, text, i);
		line[i] = 0;

		// delete the text from the command buffer and move remaining commands down
		// this is necessary because commands (exec) can insert data at the
		// beginning of the text buffer

		if (i == cmd_text.cursize)
			cmd_text.cursize = 0;
		else {
			i++;
			cmd_text.cursize -= i;
			memmove(text, text + i, cmd_text.cursize);
		}

		// execute the command line
		Cmd_ExecuteString(line);
	}
}


/*
==============================================================================

SCRIPT COMMANDS

==============================================================================
*/

void Cmd_Exec_f(void) {
	char	*f;
	int		len;
	char	filename[MAX_QPATH];

	if (Cmd_Argc() != 2) {
		Com_Printf("exec <filename> : execute a script file\n");
		return;
	}

	Q_strncpyz(filename, Cmd_Argv(1), sizeof(filename));
	COM_DefaultExtension(filename, sizeof(filename), ".cfg");
	len = FS_ReadFile(filename, (void **) &f);
	if (!f) {
		Com_Printf("couldn't exec %s\n", Cmd_Argv(1));
		return;
	}
	Com_Printf("execing %s\n", Cmd_Argv(1));

	Cbuf_InsertText(f);

	FS_FreeFile(f);
}


/*
Inserts the current value of a variable as command text
*/
void Cmd_Vstr_f(void) {
	char	*v;

	if (Cmd_Argc() != 2) {
		Com_Printf("vstr <variablename> : execute a variable command\n");
		return;
	}

	v = Cvar_VariableString(Cmd_Argv(1));
	Cbuf_InsertText(va("%s\n", v));
}


/*
Just prints the rest of the line to the console
*/
void Cmd_Echo_f(void) {
	int		i;

	for (i = 1; i < Cmd_Argc(); i++)
		Com_Printf("%s ", Cmd_Argv(i));
	Com_Printf("\n");
}


/*
=============================================================================

COMMAND EXECUTION

=============================================================================
*/

typedef struct cmd_function_s {
	struct cmd_function_s *next;
	const char *name;
	xcommand_t function;
} cmd_function_t;


static	int			cmd_argc;
static	char		*cmd_argv[MAX_STRING_TOKENS];		// points into cmd_tokenized
static	char		cmd_tokenized[BIG_INFO_STRING + MAX_STRING_TOKENS];	// will have 0 bytes inserted
static	char		cmd_cmd[BIG_INFO_STRING]; // the original command we received (no token processing)

// コマンド表
static	cmd_function_t	*cmd_functions;		// possible commands to execute


int Cmd_Argc(void) {
	return cmd_argc;
}

char *Cmd_Argv(int arg) {
	if ((unsigned) arg >= cmd_argc) {
		return "";
	}
	return cmd_argv[arg];
}


/*
The interpreted versions use this because
they can't have pointers returned to them
*/
void	Cmd_ArgvBuffer(int arg, char *buffer, int bufferLength) {
	Q_strncpyz(buffer, Cmd_Argv(arg), bufferLength);
}


/*
Returns a single string containing argv(1) to argv(argc()-1)
*/
char	*Cmd_Args(void) {
	static	char		cmd_args[MAX_STRING_CHARS];
	int		i;

	cmd_args[0] = 0;
	for (i = 1; i < cmd_argc; i++) {
		strcat(cmd_args, cmd_argv[i]);
		if (i != cmd_argc - 1) {
			strcat(cmd_args, " ");
		}
	}

	return cmd_args;
}


/*
Returns a single string containing argv(arg) to argv(argc()-1)
*/
char *Cmd_ArgsFrom(int arg) {
	static	char		cmd_args[BIG_INFO_STRING];
	int		i;

	cmd_args[0] = 0;
	if (arg < 0)
		arg = 0;
	for (i = arg; i < cmd_argc; i++) {
		strcat(cmd_args, cmd_argv[i]);
		if (i != cmd_argc - 1) {
			strcat(cmd_args, " ");
		}
	}

	return cmd_args;
}


/*
The interpreted versions use this because
they can't have pointers returned to them
*/
void	Cmd_ArgsBuffer(char *buffer, int bufferLength) {
	Q_strncpyz(buffer, Cmd_Args(), bufferLength);
}


/*
Retrieve the unmodified command string
For rcon use when you want to transmit without altering quoting
https://zerowing.idsoftware.com/bugzilla/show_bug.cgi?id=543
*/
char *Cmd_Cmd() {
	return cmd_cmd;
}

// 空白文字や、"/* */"、"//"形式のコメントをスキップし、トークンの開始位置を返す
static const char *findToken(const char *s) {
	for (;;) {
		// 空白文字は読み飛ばす
		for (;; s++) {
			if (*s == '\0')
				return NULL;
			if (*s > ' ')
				break;
		}

		// "//"コメントの場合、トークンはないのでNULLを返す
		if (s[0] == '/' && s[1] == '/')
			return NULL;			// all tokens parsed

		// "/* */"コメントは読み飛ばす。
		if (s[0] == '/' && s[1] == '*') {
			s += 2;
			for (;; s++) {
				if (*s == '\0')
					return NULL;	// コメント終了が見つからないまま文字列終端に達した場合はトークンなしとみなす
				if ((s[0] == '*') && (s[1] == '/')) {
					s += 2;
					break;
				}
			}
		} else {
			return s;	// 空白文字でも、コメント文字列でもないものがトークンである。
		}
	}
}

/*
Parses the given string into command line tokens.
The text is copied to a seperate buffer and 0 characters
are inserted in the apropriate place, The argv array
will point into this temporary buffer.

与えられた文字列text_inをパースし、コマンドライントークンのリストを作る。
テキストは個別の(?)バッファにコピーされ、0(文字列ターミネータ)が適切な場所に挿入される。
argv配列は、この一時バッファを指す。
*/
// NOTE TTimo define that to track tokenization issues
//#define TKN_DBG
void Cmd_TokenizeString(const char *text_in) {
#ifdef TKN_DBG
	// FIXME TTimo blunt hook to try to find the tokenization of userinfo
	Com_DPrintf("Cmd_TokenizeString: %s\n", text_in);
#endif

	// clear previous args
	cmd_argc = 0;

	if (text_in == NULL)
		return;

	Q_strncpyz(cmd_cmd, text_in, sizeof(cmd_cmd));	// (秋山)トークン分割されていない生データのコピーを行っているが、目的がわからない。

	const char *text = text_in;
	char *textOut = cmd_tokenized;

	for (;;) {
		if (cmd_argc == MAX_STRING_TOKENS)
			return;			// this is usually something malicious

		// トークンの開始位置まで、ポインタ(text)を進める。(空白文字、"//"コメント、"/*"～"*/"コメントの読み飛ばしを行う。)
		text = findToken(text);
		if (text == NULL)
			return;

		cmd_argv[cmd_argc] = textOut;
		cmd_argc++;

		if (*text == '"') {
			// 二重引用符で囲まれた文字列トークンの処理。
			// エスケープ文字("\")処理はできない。
			text++;
			while (*text && *text != '"')
				*textOut++ = *text++;
			text++;
		} else {
			// 文字列トークンではない、普通のトークンの処理。
			// skip until whitespace, quote, or command
			while (*text > ' ') {
				if (text[0] == '"')
					break;
				if (text[0] == '/' && text[1] == '/')
					break;
				if (text[0] == '/' && text[1] == '*')
					break;
				*textOut++ = *text++;
			}
		}
		*textOut++ = 0;
	}
}

void Cmd_AddCommand(const char *name, xcommand_t function) {
	// コマンド表(cmd_functions)に新たなコマンドを登録する。(登録位置は、表の末尾ではなく、先頭。)
	cmd_function_t *cmd;

	// fail if the command already exists
	// すでに同名のコマンドが登録されている場合は失敗にする。
	for (cmd = cmd_functions; cmd != NULL; cmd = cmd->next) {
		if (strcmp(name, cmd->name) == 0) {
			// allow completion-only commands to be silently doubled
			if (function != NULL) {
				Com_Printf("Cmd_AddCommand: %s already defined\n", name);
			}
			return;
		}
	}

	// use a small malloc to avoid zone fragmentation
	cmd = S_Malloc(sizeof(cmd_function_t));
	cmd->name = CopyString(name);
	cmd->function = function;
	cmd->next = cmd_functions;
	cmd_functions = cmd;
}

void	Cmd_RemoveCommand(const char *cmd_name) {
	cmd_function_t	*cmd, **back;

	back = &cmd_functions;
	while (1) {
		cmd = *back;
		if (!cmd) {
			// command wasn't active
			return;
		}
		if (!strcmp(cmd_name, cmd->name)) {
			*back = cmd->next;
			if (cmd->name) {
				Z_Free(cmd->name);
			}
			Z_Free(cmd);
			return;
		}
		back = &cmd->next;
	}
}


void	Cmd_CommandCompletion(void(*callback)(const char *s)) {
	cmd_function_t	*cmd;

	for (cmd = cmd_functions; cmd; cmd = cmd->next) {
		callback(cmd->name);
	}
}


/*
A complete command line has been parsed, so try to execute it
*/
void	Cmd_ExecuteString(const char *text) {
	cmd_function_t	*cmd, **prev;

	// execute the command line
	Cmd_TokenizeString(text);
	if (!Cmd_Argc()) {
		return;		// no tokens
	}

	// check registered command functions	
	for (prev = &cmd_functions; *prev; prev = &cmd->next) {
		cmd = *prev;
		if (!Q_stricmp(cmd_argv[0], cmd->name)) {
			// rearrange the links so that the command will be
			// near the head of the list next time it is used
			*prev = cmd->next;
			cmd->next = cmd_functions;
			cmd_functions = cmd;

			// perform the action
			if (!cmd->function) {
				// let the cgame or game handle it
				break;
			} else {
				cmd->function();
			}
			return;
		}
	}

	// check cvars
	if (Cvar_Command()) {
		return;
	}

	// check client game commands
	if (com_cl_running && com_cl_running->integer && CL_GameCommand()) {
		return;
	}

	// check server game commands
	if (com_sv_running && com_sv_running->integer && SV_GameCommand()) {
		return;
	}

	// check ui commands
	if (com_cl_running && com_cl_running->integer && UI_GameCommand()) {
		return;
	}

	// send it as a server command if we are connected
	// this will usually result in a chat message
	CL_ForwardCommandToServer(text);
}


void Cmd_List_f(void) {
	cmd_function_t	*cmd;
	int				i;
	char			*match;

	if (Cmd_Argc() > 1) {
		match = Cmd_Argv(1);
	} else {
		match = NULL;
	}

	i = 0;
	for (cmd = cmd_functions; cmd; cmd = cmd->next) {
		if (match && !Com_Filter(match, cmd->name, 0))
			continue;

		Com_Printf("%s\n", cmd->name);
		i++;
	}
	Com_Printf("%i commands\n", i);
}


void Cmd_Init(void) {
	Cmd_AddCommand("cmdlist", Cmd_List_f);
	Cmd_AddCommand("exec", Cmd_Exec_f);
	Cmd_AddCommand("vstr", Cmd_Vstr_f);
	Cmd_AddCommand("echo", Cmd_Echo_f);
	Cmd_AddCommand("wait", Cmd_Wait_f);
}
