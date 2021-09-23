// win_main.c

#include "../client.h"
#include "../../qcommon/qcommon.h"
#include "../../qcommon/win32/win_local.h"
#include "../../qcommon/win32/resource.h"
#include <errno.h>
#include <float.h>
#include <fcntl.h>
#include <stdio.h>
#include <direct.h>
#include <io.h>
#include <conio.h>

#define MEM_THRESHOLD 96*1024*1024

static char		sys_cmdline[MAX_STRING_CHARS];

qboolean Sys_LowPhysicalMemory() {
	MEMORYSTATUS stat;
	GlobalMemoryStatus(&stat);
	return (stat.dwTotalPhys <= MEM_THRESHOLD) ? 1 : 0;
}


void QDECL Sys_Error(const char *error, ...) {
	va_list		argptr;
	char		text[4096];
	MSG        msg;

	va_start(argptr, error);
	vsprintf(text, error, argptr);
	va_end(argptr);

	Conbuf_AppendText(text);
	Conbuf_AppendText("\n");

	Sys_SetErrorText(text);
	Sys_ShowConsole(1, 1);

	timeEndPeriod(1);

	IN_Shutdown();

	// wait for the user to quit
	while (1) {
		if (!GetMessage(&msg, NULL, 0, 0))
			Com_Quit_f();
		TranslateMessage(&msg);
		DispatchMessage(&msg);
	}

	Sys_DestroyConsole();

	exit(1);
}


void Sys_Quit(void) {
	timeEndPeriod(1);
	IN_Shutdown();
	Sys_DestroyConsole();

	exit(0);
}


void Sys_Print(const char *msg) {
	Conbuf_AppendText(msg);
}


void Sys_Mkdir(const char *path) {
	_mkdir(path);
}


char *Sys_Cwd(void) {
	static char cwd[MAX_OSPATH];

	_getcwd(cwd, sizeof(cwd)-1);
	cwd[MAX_OSPATH - 1] = 0;

	return cwd;
}


char *Sys_DefaultBasePath(void) {
	return Sys_Cwd();
}

/*
==============================================================

DIRECTORY SCANNING

==============================================================
*/

#define	MAX_FOUND_FILES	0x1000

void Sys_ListFilteredFiles(const char *basedir, char *subdirs, char *filter, char **list, int *numfiles) {
	char		search[MAX_OSPATH], newsubdirs[MAX_OSPATH];
	char		filename[MAX_OSPATH];
	int			findhandle;
	struct _finddata_t findinfo;

	if (*numfiles >= MAX_FOUND_FILES - 1) {
		return;
	}

	if (strlen(subdirs)) {
		Com_sprintf(search, sizeof(search), "%s\\%s\\*", basedir, subdirs);
	}
	else {
		Com_sprintf(search, sizeof(search), "%s\\*", basedir);
	}

	findhandle = _findfirst(search, &findinfo);
	if (findhandle == -1) {
		return;
	}

	do {
		if (findinfo.attrib & _A_SUBDIR) {
			if (Q_stricmp(findinfo.name, ".") && Q_stricmp(findinfo.name, "..")) {
				if (strlen(subdirs)) {
					Com_sprintf(newsubdirs, sizeof(newsubdirs), "%s\\%s", subdirs, findinfo.name);
				}
				else {
					Com_sprintf(newsubdirs, sizeof(newsubdirs), "%s", findinfo.name);
				}
				Sys_ListFilteredFiles(basedir, newsubdirs, filter, list, numfiles);
			}
		}
		if (*numfiles >= MAX_FOUND_FILES - 1) {
			break;
		}
		Com_sprintf(filename, sizeof(filename), "%s\\%s", subdirs, findinfo.name);
		if (!Com_FilterPath(filter, filename, 0))
			continue;
		list[*numfiles] = CopyString(filename);
		(*numfiles)++;
	} while (_findnext(findhandle, &findinfo) != -1);

	_findclose(findhandle);
}


static qboolean strgtr(const char *s0, const char *s1) {
	int l0, l1, i;

	l0 = strlen(s0);
	l1 = strlen(s1);

	if (l1 < l0) {
		l0 = l1;
	}

	for (i = 0; i<l0; i++) {
		if (s1[i] > s0[i]) {
			return 1;
		}
		if (s1[i] < s0[i]) {
			return 0;
		}
	}
	return 0;
}


char **Sys_ListFiles(const char *directory, const char *extension, char *filter, int *numfiles, qboolean wantsubs) {
	char		search[MAX_OSPATH];
	int			nfiles;
	char		**listCopy;
	char		*list[MAX_FOUND_FILES];
	struct _finddata_t findinfo;
	int			findhandle;
	int			flag;
	int			i;

	if (filter) {

		nfiles = 0;
		Sys_ListFilteredFiles(directory, "", filter, list, &nfiles);

		list[nfiles] = 0;
		*numfiles = nfiles;

		if (!nfiles)
			return NULL;

		listCopy = (char **)Z_Malloc((nfiles + 1) * sizeof(*listCopy));
		for (i = 0; i < nfiles; i++) {
			listCopy[i] = list[i];
		}
		listCopy[i] = NULL;

		return listCopy;
	}

	if (!extension) {
		extension = "";
	}

	// passing a slash as extension will find directories
	if (extension[0] == '/' && extension[1] == 0) {
		extension = "";
		flag = 0;
	}
	else {
		flag = _A_SUBDIR;
	}

	Com_sprintf(search, sizeof(search), "%s\\*%s", directory, extension);

	// search
	nfiles = 0;

	findhandle = _findfirst(search, &findinfo);
	if (findhandle == -1) {
		*numfiles = 0;
		return NULL;
	}

	do {
		if ((!wantsubs && flag ^ (findinfo.attrib & _A_SUBDIR)) || (wantsubs && findinfo.attrib & _A_SUBDIR)) {
			if (nfiles == MAX_FOUND_FILES - 1) {
				break;
			}
			list[nfiles] = CopyString(findinfo.name);
			nfiles++;
		}
	} while (_findnext(findhandle, &findinfo) != -1);

	list[nfiles] = 0;

	_findclose(findhandle);

	// return a copy of the list
	*numfiles = nfiles;

	if (!nfiles) {
		return NULL;
	}

	listCopy = (char **)Z_Malloc((nfiles + 1) * sizeof(*listCopy));
	for (i = 0; i < nfiles; i++) {
		listCopy[i] = list[i];
	}
	listCopy[i] = NULL;

	do {
		flag = 0;
		for (i = 1; i < nfiles; i++) {
			if (strgtr(listCopy[i - 1], listCopy[i])) {
				char *temp = listCopy[i];
				listCopy[i] = listCopy[i - 1];
				listCopy[i - 1] = temp;
				flag = 1;
			}
		}
	} while (flag);

	return listCopy;
}


void	Sys_FreeFileList(char **list) {
	int		i;

	if (!list) {
		return;
	}

	for (i = 0; list[i]; i++) {
		Z_Free(list[i]);
	}

	Z_Free(list);
}


char *Sys_GetClipboardData(void) {
	char *data = NULL;
	char *cliptext;

	if (OpenClipboard(NULL) != 0) {
		HANDLE hClipboardData;

		if ((hClipboardData = GetClipboardData(CF_TEXT)) != 0) {
			if ((cliptext = (char *)GlobalLock(hClipboardData)) != 0) {
				data = (char *)Z_Malloc(GlobalSize(hClipboardData) + 1);
				Q_strncpyz(data, cliptext, GlobalSize(hClipboardData));
				GlobalUnlock(hClipboardData);

				strtok(data, "\n\r\b");
			}
		}
		CloseClipboard();
	}
	return data;
}


/*
========================================================================

LOAD/UNLOAD DLL

========================================================================
*/

void Sys_UnloadDll(void *dllHandle) {
	if (!dllHandle) {
		return;
	}
	if (!FreeLibrary((HMODULE)dllHandle)) {
		Com_Error(ERR_FATAL, "Sys_UnloadDll FreeLibrary failed");
	}
}

/*
Used to load a development dll instead of a virtual machine

TTimo: added some verbosity in debug
*/
extern const char *FS_BuildOSPath(const char *base, const char *game, const char *qpath);

// fqpath param added 7/20/02 by T.Ray - Sys_LoadDll is only called in vm.c at this time
// fqpath will be empty if dll not loaded, otherwise will hold fully qualified path of dll module loaded
// fqpath buffersize must be at least MAX_QPATH+1 bytes long
void * QDECL Sys_LoadDll(const char *name, char *fqpath, int (QDECL **entryPoint)(int, ...),
	int (QDECL *systemcalls)(int, ...)) {
	static int	lastWarning = 0;
	HINSTANCE	libHandle;
	void	(QDECL *dllEntry)(int (QDECL *syscallptr)(int, ...));
	char	*basepath;
	char	*cdpath;
	char	*gamedir;
	const char	*fn;
#ifdef NDEBUG
	int		timestamp;
	int   ret;
#endif
	char	filename[MAX_QPATH];

	*fqpath = 0;		// added 7/20/02 by T.Ray

	Com_sprintf(filename, sizeof(filename), "%sx86.dll", name);

#ifdef NDEBUG
	timestamp = Sys_Milliseconds();
	if( ((timestamp - lastWarning) > (5 * 60000)) && !Cvar_VariableIntegerValue( "dedicated" )
		&& !Cvar_VariableIntegerValue( "com_blindlyLoadDLLs" ) ) {
		if (FS_FileExists(filename)) {
			lastWarning = timestamp;
			ret = MessageBoxEx( NULL, "You are about to load a .DLL executable that\n"
				"has not been verified for use with Quake III Arena.\n"
				"This type of file can compromise the security of\n"
				"your computer.\n\n"
				"Select 'OK' if you choose to load it anyway.",
				"Security Warning", MB_OKCANCEL | MB_ICONEXCLAMATION | MB_DEFBUTTON2 | MB_TOPMOST | MB_SETFOREGROUND,
				MAKELANGID( LANG_NEUTRAL, SUBLANG_DEFAULT ) );
			if( ret != IDOK ) {
				return NULL;
			}
		}
	}
#endif

#ifndef NDEBUG
	libHandle = LoadLibrary(filename);
	if (libHandle)
		Com_Printf("LoadLibrary '%s' ok\n", filename);
	else
		Com_Printf("LoadLibrary '%s' failed\n", filename);
	if (!libHandle) {
#endif
		basepath = Cvar_VariableString("fs_basepath");
		cdpath = Cvar_VariableString("fs_cdpath");
		gamedir = Cvar_VariableString("fs_game");

		fn = FS_BuildOSPath(basepath, gamedir, filename);
		libHandle = LoadLibrary(fn);
#ifndef NDEBUG
		if (libHandle)
			Com_Printf("LoadLibrary '%s' ok\n", fn);
		else
			Com_Printf("LoadLibrary '%s' failed\n", fn);
#endif

		if (!libHandle) {
			if (cdpath[0]) {
				fn = FS_BuildOSPath(cdpath, gamedir, filename);
				libHandle = LoadLibrary(fn);
#ifndef NDEBUG
				if (libHandle)
					Com_Printf("LoadLibrary '%s' ok\n", fn);
				else
					Com_Printf("LoadLibrary '%s' failed\n", fn);
#endif
			}

			if (!libHandle) {
				return NULL;
			}
		}
#ifndef NDEBUG
	}
#endif

	dllEntry = (void (QDECL *)(int (QDECL *)(int, ...)))GetProcAddress(libHandle, "dllEntry");
	*entryPoint = (int (QDECL *)(int, ...))GetProcAddress(libHandle, "vmMain");
	if (!*entryPoint || !dllEntry) {
		FreeLibrary(libHandle);
		return NULL;
	}
	dllEntry(systemcalls);

	if (libHandle) Q_strncpyz(fqpath, filename, MAX_QPATH);		// added 7/20/02 by T.Ray
	return libHandle;
}


/*
Restart the input subsystem
*/
static void sys_In_Restart_f(void) {
	IN_Shutdown();
	IN_Init();
}


/*
Restart the network subsystem
*/
static void sys_Net_Restart_f(void) {
	NET_Restart();
}


/*
Called after the common systems (cvars, files, etc)
are initialized
*/
#define OSR2_BUILD_NUMBER 1111
#define WIN98_BUILD_NUMBER 1998

void Sys_Init(void) {
	int cpuid;

	// make sure the timer is high precision, otherwise
	// NT gets 18ms resolution
	timeBeginPeriod(1);

	Cmd_AddCommand("in_restart", sys_In_Restart_f);
	Cmd_AddCommand("net_restart", sys_Net_Restart_f);

	g_wv.osversion.dwOSVersionInfoSize = sizeof(g_wv.osversion);

	if (!GetVersionEx(&g_wv.osversion))
		Sys_Error("Couldn't get OS info");

	if (g_wv.osversion.dwMajorVersion < 4)
		Sys_Error("Quake3 requires Windows version 4 or greater");
	if (g_wv.osversion.dwPlatformId == VER_PLATFORM_WIN32s)
		Sys_Error("Quake3 doesn't run on Win32s");

	if (g_wv.osversion.dwPlatformId == VER_PLATFORM_WIN32_NT)
	{
		Cvar_Set("arch", "winnt");
	}
	else if (g_wv.osversion.dwPlatformId == VER_PLATFORM_WIN32_WINDOWS)
	{
		if (LOWORD(g_wv.osversion.dwBuildNumber) >= WIN98_BUILD_NUMBER)
		{
			Cvar_Set("arch", "win98");
		}
		else if (LOWORD(g_wv.osversion.dwBuildNumber) >= OSR2_BUILD_NUMBER)
		{
			Cvar_Set("arch", "win95 osr2.x");
		}
		else
		{
			Cvar_Set("arch", "win95");
		}
	}
	else
	{
		Cvar_Set("arch", "unknown Windows variant");
	}

	// save out a couple things in rom cvars for the renderer to access
	Cvar_Get("win_hinstance", va("%i", (int)g_wv.hInstance), CVAR_ROM);
	Cvar_Get("win_wndproc", va("%i", (int)MainWndProc), CVAR_ROM);

	//
	// figure out our CPU
	//
	Cvar_Get("sys_cpustring", "detect", 0);
	if (!Q_stricmp(Cvar_VariableString("sys_cpustring"), "detect"))
	{
		Com_Printf("...detecting CPU, found ");

		cpuid = Sys_GetProcessorId();

		switch (cpuid)
		{
		case CPUID_GENERIC:
			Cvar_Set("sys_cpustring", "generic");
			break;
		case CPUID_INTEL_UNSUPPORTED:
			Cvar_Set("sys_cpustring", "x86 (pre-Pentium)");
			break;
		case CPUID_INTEL_PENTIUM:
			Cvar_Set("sys_cpustring", "x86 (P5/PPro, non-MMX)");
			break;
		case CPUID_INTEL_MMX:
			Cvar_Set("sys_cpustring", "x86 (P5/Pentium2, MMX)");
			break;
		case CPUID_INTEL_KATMAI:
			Cvar_Set("sys_cpustring", "Intel Pentium III");
			break;
		case CPUID_AMD_3DNOW:
			Cvar_Set("sys_cpustring", "AMD w/ 3DNow!");
			break;
		case CPUID_AXP:
			Cvar_Set("sys_cpustring", "Alpha AXP");
			break;
		default:
			Com_Error(ERR_FATAL, "Unknown cpu type %d\n", cpuid);
			break;
		}
	}
	else
	{
		Com_Printf("...forcing CPU type to ");
		if (!Q_stricmp(Cvar_VariableString("sys_cpustring"), "generic"))
			cpuid = CPUID_GENERIC;
		else if (!Q_stricmp(Cvar_VariableString("sys_cpustring"), "x87"))
			cpuid = CPUID_INTEL_PENTIUM;
		else if (!Q_stricmp(Cvar_VariableString("sys_cpustring"), "mmx"))
			cpuid = CPUID_INTEL_MMX;
		else if (!Q_stricmp(Cvar_VariableString("sys_cpustring"), "3dnow"))
			cpuid = CPUID_AMD_3DNOW;
		else if (!Q_stricmp(Cvar_VariableString("sys_cpustring"), "PentiumIII"))
			cpuid = CPUID_INTEL_KATMAI;
		else if (!Q_stricmp(Cvar_VariableString("sys_cpustring"), "axp"))
			cpuid = CPUID_AXP;
		else
		{
			Com_Printf("WARNING: unknown sys_cpustring '%s'\n", Cvar_VariableString("sys_cpustring"));
			cpuid = CPUID_GENERIC;
		}
	}
	Cvar_SetValue("sys_cpuid", cpuid);
	Com_Printf("%s\n", Cvar_VariableString("sys_cpustring"));

	Cvar_Set("username", Sys_GetCurrentUser());

	IN_Init();		// FIXME: not in dedicated?
}

//=======================================================================
int WINAPI WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int nCmdShow) {
	// should never get a previous instance in Win32
	if (hPrevInstance)
		return 0;

	g_wv.hInstance = hInstance;
	Q_strncpyz(sys_cmdline, lpCmdLine, sizeof(sys_cmdline));

	// done before Com/Sys_Init since we need this for error output
	Sys_CreateConsole();

	// no abort/retry/fail errors
	SetErrorMode(SEM_FAILCRITICALERRORS);

	Sys_Milliseconds();	// ゲーム起動からの経過時間を取得するための関数を初期化する。

	Com_Init(sys_cmdline);

	NET_Init();

	{
		char cwd[MAX_OSPATH];
		_getcwd(cwd, sizeof(cwd));
		Com_Printf("Working directory: %s\n", cwd);
	}

	// hide the early console since we've reached the point where we
	// have a working graphics subsystems
	if (!com_dedicated->integer && !com_viewlog->integer) {
		Sys_ShowConsole(0/*=hide*/, 0);
	}

	// main game loop(このメインループではフレームレートの制御をしていない???)
	for (;;) {
		// if not running as a game client, sleep a bit
		if (g_wv.isMinimized || (com_dedicated && com_dedicated->integer))
			Sleep(5);

		// make sure mouse and joystick are only called once a frame
		IN_Frame();

		// run the game
		Com_Frame();
	}
}
