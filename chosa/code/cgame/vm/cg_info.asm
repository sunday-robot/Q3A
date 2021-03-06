code
proc CG_DrawLoadingIcons 16 20
file "../cg_info.c"
line 14
;1:// cg_info.c -- display information while data is being loading
;2:
;3:#include "cg_local.h"
;4:
;5:#define MAX_LOADING_PLAYER_ICONS	16
;6:#define MAX_LOADING_ITEM_ICONS		26
;7:
;8:static int			loadingPlayerIconCount;
;9:static int			loadingItemIconCount;
;10:static qhandle_t	loadingPlayerIcons[MAX_LOADING_PLAYER_ICONS];
;11:static qhandle_t	loadingItemIcons[MAX_LOADING_ITEM_ICONS];
;12:
;13:
;14:static void CG_DrawLoadingIcons( void ) {
line 18
;15:	int		n;
;16:	int		x, y;
;17:
;18:	for( n = 0; n < loadingPlayerIconCount; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $74
JUMPV
LABELV $71
line 19
;19:		x = 16 + n * 78;
ADDRLP4 8
CNSTI4 78
ADDRLP4 0
INDIRI4
MULI4
CNSTI4 16
ADDI4
ASGNI4
line 20
;20:		y = 324-40;
ADDRLP4 4
CNSTI4 284
ASGNI4
line 21
;21:		CG_DrawPic( x, y, 64, 64, loadingPlayerIcons[n] );
ADDRLP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 12
CNSTF4 1115684864
ASGNF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 loadingPlayerIcons
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 22
;22:	}
LABELV $72
line 18
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $74
ADDRLP4 0
INDIRI4
ADDRGP4 loadingPlayerIconCount
INDIRI4
LTI4 $71
line 24
;23:
;24:	for( n = 0; n < loadingItemIconCount; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $78
JUMPV
LABELV $75
line 25
;25:		y = 400-40;
ADDRLP4 4
CNSTI4 360
ASGNI4
line 26
;26:		if( n >= 13 ) {
ADDRLP4 0
INDIRI4
CNSTI4 13
LTI4 $79
line 27
;27:			y += 40;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 40
ADDI4
ASGNI4
line 28
;28:		}
LABELV $79
line 29
;29:		x = 16 + n % 13 * 48;
ADDRLP4 8
CNSTI4 48
ADDRLP4 0
INDIRI4
CNSTI4 13
MODI4
MULI4
CNSTI4 16
ADDI4
ASGNI4
line 30
;30:		CG_DrawPic( x, y, 32, 32, loadingItemIcons[n] );
ADDRLP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 12
CNSTF4 1107296256
ASGNF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 loadingItemIcons
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 31
;31:	}
LABELV $76
line 24
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $78
ADDRLP4 0
INDIRI4
ADDRGP4 loadingItemIconCount
INDIRI4
LTI4 $75
line 32
;32:}
LABELV $70
endproc CG_DrawLoadingIcons 16 20
export CG_LoadingString
proc CG_LoadingString 0 12
line 35
;33:
;34:
;35:void CG_LoadingString( const char *s ) {
line 36
;36:	Q_strncpyz( cg.infoScreenText, s, sizeof( cg.infoScreenText ) );
ADDRGP4 cg+109436
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 38
;37:
;38:	trap_UpdateScreen();
ADDRGP4 trap_UpdateScreen
CALLV
pop
line 39
;39:}
LABELV $81
endproc CG_LoadingString 0 12
export CG_LoadingItem
proc CG_LoadingItem 16 4
line 42
;40:
;41:
;42:void CG_LoadingItem( int itemNum ) {
line 45
;43:	gitem_t		*item;
;44:
;45:	item = &bg_itemlist[itemNum];
ADDRLP4 0
CNSTI4 52
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 bg_itemlist
ADDP4
ASGNP4
line 47
;46:	
;47:	if ( item->icon && loadingItemIconCount < MAX_LOADING_ITEM_ICONS ) {
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $85
ADDRGP4 loadingItemIconCount
INDIRI4
CNSTI4 26
GEI4 $85
line 48
;48:		loadingItemIcons[loadingItemIconCount++] = trap_R_RegisterShaderNoMip( item->icon );
ADDRLP4 8
ADDRGP4 loadingItemIconCount
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 8
INDIRP4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 loadingItemIcons
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
line 49
;49:	}
LABELV $85
line 51
;50:
;51:	CG_LoadingString( item->pickup_name );
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRP4
ARGP4
ADDRGP4 CG_LoadingString
CALLV
pop
line 52
;52:}
LABELV $84
endproc CG_LoadingItem 16 4
export CG_LoadingClient
proc CG_LoadingClient 220 20
line 55
;53:
;54:
;55:void CG_LoadingClient( int clientNum ) {
line 62
;56:	const char		*info;
;57:	char			*skin;
;58:	char			personality[MAX_QPATH];
;59:	char			model[MAX_QPATH];
;60:	char			iconName[MAX_QPATH];
;61:
;62:	info = CG_ConfigString( CS_PLAYERS + clientNum );
ADDRFP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 200
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 64
ADDRLP4 200
INDIRP4
ASGNP4
line 64
;63:
;64:	if ( loadingPlayerIconCount < MAX_LOADING_PLAYER_ICONS ) {
ADDRGP4 loadingPlayerIconCount
INDIRI4
CNSTI4 16
GEI4 $88
line 65
;65:		Q_strncpyz( model, Info_ValueForKey( info, "model" ), sizeof( model ) );
ADDRLP4 64
INDIRP4
ARGP4
ADDRGP4 $90
ARGP4
ADDRLP4 204
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 72
ARGP4
ADDRLP4 204
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 66
;66:		skin = Q_strrchr( model, '/' );
ADDRLP4 72
ARGP4
CNSTI4 47
ARGI4
ADDRLP4 208
ADDRGP4 Q_strrchr
CALLP4
ASGNP4
ADDRLP4 68
ADDRLP4 208
INDIRP4
ASGNP4
line 67
;67:		if ( skin ) {
ADDRLP4 68
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $91
line 68
;68:			*skin++ = '\0';
ADDRLP4 212
ADDRLP4 68
INDIRP4
ASGNP4
ADDRLP4 68
ADDRLP4 212
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 212
INDIRP4
CNSTI1 0
ASGNI1
line 69
;69:		} else {
ADDRGP4 $92
JUMPV
LABELV $91
line 70
;70:			skin = "default";
ADDRLP4 68
ADDRGP4 $93
ASGNP4
line 71
;71:		}
LABELV $92
line 73
;72:
;73:		Com_sprintf( iconName, MAX_QPATH, "models/players/%s/icon_%s.tga", model, skin );
ADDRLP4 136
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $94
ARGP4
ADDRLP4 72
ARGP4
ADDRLP4 68
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 75
;74:		
;75:		loadingPlayerIcons[loadingPlayerIconCount] = trap_R_RegisterShaderNoMip( iconName );
ADDRLP4 136
ARGP4
ADDRLP4 212
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 loadingPlayerIconCount
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 loadingPlayerIcons
ADDP4
ADDRLP4 212
INDIRI4
ASGNI4
line 76
;76:		if ( !loadingPlayerIcons[loadingPlayerIconCount] ) {
ADDRGP4 loadingPlayerIconCount
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 loadingPlayerIcons
ADDP4
INDIRI4
CNSTI4 0
NEI4 $95
line 77
;77:			Com_sprintf( iconName, MAX_QPATH, "models/players/characters/%s/icon_%s.tga", model, skin );
ADDRLP4 136
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $97
ARGP4
ADDRLP4 72
ARGP4
ADDRLP4 68
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 78
;78:			loadingPlayerIcons[loadingPlayerIconCount] = trap_R_RegisterShaderNoMip( iconName );
ADDRLP4 136
ARGP4
ADDRLP4 216
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 loadingPlayerIconCount
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 loadingPlayerIcons
ADDP4
ADDRLP4 216
INDIRI4
ASGNI4
line 79
;79:		}
LABELV $95
line 80
;80:		if ( !loadingPlayerIcons[loadingPlayerIconCount] ) {
ADDRGP4 loadingPlayerIconCount
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 loadingPlayerIcons
ADDP4
INDIRI4
CNSTI4 0
NEI4 $98
line 81
;81:			Com_sprintf( iconName, MAX_QPATH, "models/players/%s/icon_%s.tga", DEFAULT_MODEL, "default" );
ADDRLP4 136
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $94
ARGP4
ADDRGP4 $100
ARGP4
ADDRGP4 $93
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 82
;82:			loadingPlayerIcons[loadingPlayerIconCount] = trap_R_RegisterShaderNoMip( iconName );
ADDRLP4 136
ARGP4
ADDRLP4 216
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 loadingPlayerIconCount
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 loadingPlayerIcons
ADDP4
ADDRLP4 216
INDIRI4
ASGNI4
line 83
;83:		}
LABELV $98
line 84
;84:		if ( loadingPlayerIcons[loadingPlayerIconCount] ) {
ADDRGP4 loadingPlayerIconCount
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 loadingPlayerIcons
ADDP4
INDIRI4
CNSTI4 0
EQI4 $101
line 85
;85:			loadingPlayerIconCount++;
ADDRLP4 216
ADDRGP4 loadingPlayerIconCount
ASGNP4
ADDRLP4 216
INDIRP4
ADDRLP4 216
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 86
;86:		}
LABELV $101
line 87
;87:	}
LABELV $88
line 89
;88:
;89:	Q_strncpyz( personality, Info_ValueForKey( info, "n" ), sizeof(personality) );
ADDRLP4 64
INDIRP4
ARGP4
ADDRGP4 $103
ARGP4
ADDRLP4 204
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 0
ARGP4
ADDRLP4 204
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 90
;90:	Q_CleanStr( personality );
ADDRLP4 0
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 92
;91:
;92:	if( cgs.gametype == GT_SINGLE_PLAYER ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 2
NEI4 $104
line 93
;93:		trap_S_RegisterSound( va( "sound/player/announce/%s.wav", personality ), qtrue );
ADDRGP4 $107
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 208
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 208
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 trap_S_RegisterSound
CALLI4
pop
line 94
;94:	}
LABELV $104
line 96
;95:
;96:	CG_LoadingString( personality );
ADDRLP4 0
ARGP4
ADDRGP4 CG_LoadingString
CALLV
pop
line 97
;97:}
LABELV $87
endproc CG_LoadingClient 220 20
export CG_DrawInformation
proc CG_DrawInformation 1124 36
line 100
;98:
;99:
;100:void CG_DrawInformation( void ) {
line 110
;101:	const char	*s;
;102:	const char	*info;
;103:	const char	*sysInfo;
;104:	int			y;
;105:	int			value;
;106:	qhandle_t	levelshot;
;107:	qhandle_t	detail;
;108:	char		buf[1024];
;109:
;110:	info = CG_ConfigString( CS_SERVERINFO );
CNSTI4 0
ARGI4
ADDRLP4 1052
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 1052
INDIRP4
ASGNP4
line 111
;111:	sysInfo = CG_ConfigString( CS_SYSTEMINFO );
CNSTI4 1
ARGI4
ADDRLP4 1056
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 1044
ADDRLP4 1056
INDIRP4
ASGNP4
line 113
;112:
;113:	s = Info_ValueForKey( info, "mapname" );
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 $109
ARGP4
ADDRLP4 1060
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 1060
INDIRP4
ASGNP4
line 114
;114:	levelshot = trap_R_RegisterShaderNoMip( va( "levelshots/%s.tga", s ) );
ADDRGP4 $110
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 1064
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1064
INDIRP4
ARGP4
ADDRLP4 1068
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 1040
ADDRLP4 1068
INDIRI4
ASGNI4
line 115
;115:	if ( !levelshot ) {
ADDRLP4 1040
INDIRI4
CNSTI4 0
NEI4 $111
line 116
;116:		levelshot = trap_R_RegisterShaderNoMip( "menu/art/unknownmap" );
ADDRGP4 $113
ARGP4
ADDRLP4 1072
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 1040
ADDRLP4 1072
INDIRI4
ASGNI4
line 117
;117:	}
LABELV $111
line 118
;118:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 119
;119:	CG_DrawPic( 0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, levelshot );
ADDRLP4 1072
CNSTF4 0
ASGNF4
ADDRLP4 1072
INDIRF4
ARGF4
ADDRLP4 1072
INDIRF4
ARGF4
CNSTF4 1142947840
ARGF4
CNSTF4 1139802112
ARGF4
ADDRLP4 1040
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 122
;120:
;121:	// blend a detail texture over it
;122:	detail = trap_R_RegisterShader( "levelShotDetail" );
ADDRGP4 $114
ARGP4
ADDRLP4 1076
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 1048
ADDRLP4 1076
INDIRI4
ASGNI4
line 123
;123:	trap_R_DrawStretchPic( 0, 0, cgs.glconfig.vidWidth, cgs.glconfig.vidHeight, 0, 0, 2.5, 2, detail );
ADDRLP4 1080
CNSTF4 0
ASGNF4
ADDRLP4 1080
INDIRF4
ARGF4
ADDRLP4 1080
INDIRF4
ARGF4
ADDRGP4 cgs+20100+11304
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 cgs+20100+11308
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 1080
INDIRF4
ARGF4
ADDRLP4 1080
INDIRF4
ARGF4
CNSTF4 1075838976
ARGF4
CNSTF4 1073741824
ARGF4
ADDRLP4 1048
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 126
;124:
;125:	// draw the icons of things as they are loaded
;126:	CG_DrawLoadingIcons();
ADDRGP4 CG_DrawLoadingIcons
CALLV
pop
line 130
;127:
;128:	// the first 150 rows are reserved for the client connection
;129:	// screen to write into
;130:	if ( cg.infoScreenText[0] ) {
ADDRGP4 cg+109436
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $119
line 131
;131:		UI_DrawProportionalString( 320, 128-32, va("Loading... %s", cg.infoScreenText),
ADDRGP4 $122
ARGP4
ADDRGP4 cg+109436
ARGP4
ADDRLP4 1084
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 320
ARGI4
CNSTI4 96
ARGI4
ADDRLP4 1084
INDIRP4
ARGP4
CNSTI4 2065
ARGI4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 133
;132:			UI_CENTER|UI_SMALLFONT|UI_DROPSHADOW, colorWhite );
;133:	} else {
ADDRGP4 $120
JUMPV
LABELV $119
line 134
;134:		UI_DrawProportionalString( 320, 128-32, "Awaiting snapshot...",
CNSTI4 320
ARGI4
CNSTI4 96
ARGI4
ADDRGP4 $124
ARGP4
CNSTI4 2065
ARGI4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 136
;135:			UI_CENTER|UI_SMALLFONT|UI_DROPSHADOW, colorWhite );
;136:	}
LABELV $120
line 140
;137:
;138:	// draw info string information
;139:
;140:	y = 180-32;
ADDRLP4 4
CNSTI4 148
ASGNI4
line 143
;141:
;142:	// don't print server lines if playing a local game
;143:	trap_Cvar_VariableStringBuffer( "sv_running", buf, sizeof( buf ) );
ADDRGP4 $125
ARGP4
ADDRLP4 16
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 144
;144:	if ( !atoi( buf ) ) {
ADDRLP4 16
ARGP4
ADDRLP4 1084
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1084
INDIRI4
CNSTI4 0
NEI4 $126
line 146
;145:		// server hostname
;146:		Q_strncpyz(buf, Info_ValueForKey( info, "sv_hostname" ), 1024);
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 $128
ARGP4
ADDRLP4 1088
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 16
ARGP4
ADDRLP4 1088
INDIRP4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 147
;147:		Q_CleanStr(buf);
ADDRLP4 16
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 148
;148:		UI_DrawProportionalString( 320, y, buf,
CNSTI4 320
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
CNSTI4 2065
ARGI4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 150
;149:			UI_CENTER|UI_SMALLFONT|UI_DROPSHADOW, colorWhite );
;150:		y += PROP_HEIGHT;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 27
ADDI4
ASGNI4
line 153
;151:
;152:		// pure server
;153:		s = Info_ValueForKey( sysInfo, "sv_pure" );
ADDRLP4 1044
INDIRP4
ARGP4
ADDRGP4 $129
ARGP4
ADDRLP4 1092
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 1092
INDIRP4
ASGNP4
line 154
;154:		if ( s[0] == '1' ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 49
NEI4 $130
line 155
;155:			UI_DrawProportionalString( 320, y, "Pure Server",
CNSTI4 320
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 $132
ARGP4
CNSTI4 2065
ARGI4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 157
;156:				UI_CENTER|UI_SMALLFONT|UI_DROPSHADOW, colorWhite );
;157:			y += PROP_HEIGHT;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 27
ADDI4
ASGNI4
line 158
;158:		}
LABELV $130
line 161
;159:
;160:		// server-specific message of the day
;161:		s = CG_ConfigString( CS_MOTD );
CNSTI4 4
ARGI4
ADDRLP4 1096
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 1096
INDIRP4
ASGNP4
line 162
;162:		if ( s[0] ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $133
line 163
;163:			UI_DrawProportionalString( 320, y, s,
CNSTI4 320
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 2065
ARGI4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 165
;164:				UI_CENTER|UI_SMALLFONT|UI_DROPSHADOW, colorWhite );
;165:			y += PROP_HEIGHT;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 27
ADDI4
ASGNI4
line 166
;166:		}
LABELV $133
line 169
;167:
;168:		// some extra space after hostname and motd
;169:		y += 10;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 10
ADDI4
ASGNI4
line 170
;170:	}
LABELV $126
line 173
;171:
;172:	// map-specific message (long map name)
;173:	s = CG_ConfigString( CS_MESSAGE );
CNSTI4 3
ARGI4
ADDRLP4 1088
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 1088
INDIRP4
ASGNP4
line 174
;174:	if ( s[0] ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $135
line 175
;175:		UI_DrawProportionalString( 320, y, s,
CNSTI4 320
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 2065
ARGI4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 177
;176:			UI_CENTER|UI_SMALLFONT|UI_DROPSHADOW, colorWhite );
;177:		y += PROP_HEIGHT;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 27
ADDI4
ASGNI4
line 178
;178:	}
LABELV $135
line 181
;179:
;180:	// cheats warning
;181:	s = Info_ValueForKey( sysInfo, "sv_cheats" );
ADDRLP4 1044
INDIRP4
ARGP4
ADDRGP4 $137
ARGP4
ADDRLP4 1092
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 1092
INDIRP4
ASGNP4
line 182
;182:	if ( s[0] == '1' ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 49
NEI4 $138
line 183
;183:		UI_DrawProportionalString( 320, y, "CHEATS ARE ENABLED",
CNSTI4 320
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 $140
ARGP4
CNSTI4 2065
ARGI4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 185
;184:			UI_CENTER|UI_SMALLFONT|UI_DROPSHADOW, colorWhite );
;185:		y += PROP_HEIGHT;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 27
ADDI4
ASGNI4
line 186
;186:	}
LABELV $138
line 189
;187:
;188:	// game type
;189:	switch ( cgs.gametype ) {
ADDRLP4 1096
ADDRGP4 cgs+31456
INDIRI4
ASGNI4
ADDRLP4 1096
INDIRI4
CNSTI4 0
LTI4 $141
ADDRLP4 1096
INDIRI4
CNSTI4 4
GTI4 $141
ADDRLP4 1096
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $156
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $156
address $145
address $149
address $147
address $151
address $153
code
LABELV $145
line 191
;190:	case GT_FFA:
;191:		s = "Free For All";
ADDRLP4 0
ADDRGP4 $146
ASGNP4
line 192
;192:		break;
ADDRGP4 $142
JUMPV
LABELV $147
line 194
;193:	case GT_SINGLE_PLAYER:
;194:		s = "Single Player";
ADDRLP4 0
ADDRGP4 $148
ASGNP4
line 195
;195:		break;
ADDRGP4 $142
JUMPV
LABELV $149
line 197
;196:	case GT_TOURNAMENT:
;197:		s = "Tournament";
ADDRLP4 0
ADDRGP4 $150
ASGNP4
line 198
;198:		break;
ADDRGP4 $142
JUMPV
LABELV $151
line 200
;199:	case GT_TEAM:
;200:		s = "Team Deathmatch";
ADDRLP4 0
ADDRGP4 $152
ASGNP4
line 201
;201:		break;
ADDRGP4 $142
JUMPV
LABELV $153
line 203
;202:	case GT_CTF:
;203:		s = "Capture The Flag";
ADDRLP4 0
ADDRGP4 $154
ASGNP4
line 204
;204:		break;
ADDRGP4 $142
JUMPV
LABELV $141
line 217
;205:#ifdef MISSIONPACK
;206:	case GT_1FCTF:
;207:		s = "One Flag CTF";
;208:		break;
;209:	case GT_OBELISK:
;210:		s = "Overload";
;211:		break;
;212:	case GT_HARVESTER:
;213:		s = "Harvester";
;214:		break;
;215:#endif
;216:	default:
;217:		s = "Unknown Gametype";
ADDRLP4 0
ADDRGP4 $155
ASGNP4
line 218
;218:		break;
LABELV $142
line 220
;219:	}
;220:	UI_DrawProportionalString( 320, y, s,
CNSTI4 320
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 2065
ARGI4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 222
;221:		UI_CENTER|UI_SMALLFONT|UI_DROPSHADOW, colorWhite );
;222:	y += PROP_HEIGHT;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 27
ADDI4
ASGNI4
line 224
;223:		
;224:	value = atoi( Info_ValueForKey( info, "timelimit" ) );
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 $157
ARGP4
ADDRLP4 1104
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1104
INDIRP4
ARGP4
ADDRLP4 1108
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 1108
INDIRI4
ASGNI4
line 225
;225:	if ( value ) {
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $158
line 226
;226:		UI_DrawProportionalString( 320, y, va( "timelimit %i", value ),
ADDRGP4 $160
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 1112
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 320
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 1112
INDIRP4
ARGP4
CNSTI4 2065
ARGI4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 228
;227:			UI_CENTER|UI_SMALLFONT|UI_DROPSHADOW, colorWhite );
;228:		y += PROP_HEIGHT;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 27
ADDI4
ASGNI4
line 229
;229:	}
LABELV $158
line 231
;230:
;231:	if (cgs.gametype < GT_CTF ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 4
GEI4 $161
line 232
;232:		value = atoi( Info_ValueForKey( info, "fraglimit" ) );
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 $164
ARGP4
ADDRLP4 1112
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1112
INDIRP4
ARGP4
ADDRLP4 1116
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 1116
INDIRI4
ASGNI4
line 233
;233:		if ( value ) {
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $165
line 234
;234:			UI_DrawProportionalString( 320, y, va( "fraglimit %i", value ),
ADDRGP4 $167
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 1120
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 320
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 1120
INDIRP4
ARGP4
CNSTI4 2065
ARGI4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 236
;235:				UI_CENTER|UI_SMALLFONT|UI_DROPSHADOW, colorWhite );
;236:			y += PROP_HEIGHT;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 27
ADDI4
ASGNI4
line 237
;237:		}
LABELV $165
line 238
;238:	}
LABELV $161
line 240
;239:
;240:	if (cgs.gametype >= GT_CTF) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 4
LTI4 $168
line 241
;241:		value = atoi( Info_ValueForKey( info, "capturelimit" ) );
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 $171
ARGP4
ADDRLP4 1112
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1112
INDIRP4
ARGP4
ADDRLP4 1116
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 1116
INDIRI4
ASGNI4
line 242
;242:		if ( value ) {
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $172
line 243
;243:			UI_DrawProportionalString( 320, y, va( "capturelimit %i", value ),
ADDRGP4 $174
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 1120
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 320
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 1120
INDIRP4
ARGP4
CNSTI4 2065
ARGI4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 UI_DrawProportionalString
CALLV
pop
line 245
;244:				UI_CENTER|UI_SMALLFONT|UI_DROPSHADOW, colorWhite );
;245:			y += PROP_HEIGHT;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 27
ADDI4
ASGNI4
line 246
;246:		}
LABELV $172
line 247
;247:	}
LABELV $168
line 248
;248:}
LABELV $108
endproc CG_DrawInformation 1124 36
bss
align 4
LABELV loadingItemIcons
skip 104
align 4
LABELV loadingPlayerIcons
skip 64
align 4
LABELV loadingItemIconCount
skip 4
align 4
LABELV loadingPlayerIconCount
skip 4
import CG_NewParticleArea
import initparticles
import CG_ParticleExplosion
import CG_ParticleMisc
import CG_ParticleDust
import CG_ParticleSparks
import CG_ParticleBulletDebris
import CG_ParticleSnowFlurry
import CG_AddParticleShrapnel
import CG_ParticleSmoke
import CG_ParticleSnow
import CG_AddParticles
import CG_ClearParticles
import trap_GetEntityToken
import trap_getCameraInfo
import trap_startCamera
import trap_loadCamera
import trap_SnapVector
import trap_CIN_SetExtents
import trap_CIN_DrawCinematic
import trap_CIN_RunCinematic
import trap_CIN_StopCinematic
import trap_CIN_PlayCinematic
import trap_Key_GetKey
import trap_Key_SetCatcher
import trap_Key_GetCatcher
import trap_Key_IsDown
import trap_R_RegisterFont
import trap_MemoryRemaining
import testPrintFloat
import testPrintInt
import trap_SetUserCmdValue
import trap_GetUserCmd
import trap_GetCurrentCmdNumber
import trap_GetServerCommand
import trap_GetSnapshot
import trap_GetCurrentSnapshotNumber
import trap_GetGameState
import trap_GetGlconfig
import trap_R_RemapShader
import trap_R_LerpTag
import trap_R_ModelBounds
import trap_R_DrawStretchPic
import trap_R_SetColor
import trap_R_RenderScene
import trap_R_LightForPoint
import trap_R_AddLightToScene
import trap_R_AddPolysToScene
import trap_R_AddPolyToScene
import trap_R_AddRefEntityToScene
import trap_R_ClearScene
import trap_R_RegisterShaderNoMip
import trap_R_RegisterShader
import trap_R_RegisterSkin
import trap_R_RegisterModel
import trap_R_LoadWorldMap
import trap_S_StopBackgroundTrack
import trap_S_StartBackgroundTrack
import trap_S_RegisterSound
import trap_S_Respatialize
import trap_S_UpdateEntityPosition
import trap_S_AddRealLoopingSound
import trap_S_AddLoopingSound
import trap_S_ClearLoopingSounds
import trap_S_StartLocalSound
import trap_S_StopLoopingSound
import trap_S_StartSound
import trap_CM_MarkFragments
import trap_CM_TransformedBoxTrace
import trap_CM_BoxTrace
import trap_CM_TransformedPointContents
import trap_CM_PointContents
import trap_CM_TempBoxModel
import trap_CM_InlineModel
import trap_CM_NumInlineModels
import trap_CM_LoadMap
import trap_UpdateScreen
import trap_SendClientCommand
import trap_AddCommand
import trap_SendConsoleCommand
import trap_FS_Seek
import trap_FS_FCloseFile
import trap_FS_Write
import trap_FS_Read
import trap_FS_FOpenFile
import trap_Args
import trap_Argv
import trap_Argc
import trap_Cvar_VariableStringBuffer
import trap_Cvar_Set
import trap_Cvar_Update
import trap_Cvar_Register
import trap_Milliseconds
import trap_Error
import trap_Print
import CG_CheckChangedPredictableEvents
import CG_TransitionPlayerState
import CG_Respawn
import CG_PlayBufferedVoiceChats
import CG_VoiceChatLocal
import CG_ShaderStateChanged
import CG_LoadVoiceChats
import CG_SetConfigValues
import CG_ParseServerinfo
import CG_ExecuteNewServerCommands
import CG_InitConsoleCommands
import CG_ConsoleCommand
import CG_DrawOldTourneyScoreboard
import CG_DrawOldScoreboard
import CG_ProcessSnapshots
import CG_MakeExplosion
import CG_Bleed
import CG_BigExplode
import CG_GibPlayer
import CG_ScorePlum
import CG_SpawnEffect
import CG_BubbleTrail
import CG_SmokePuff
import CG_AddLocalEntities
import CG_AllocLocalEntity
import CG_InitLocalEntities
import CG_ImpactMark
import CG_AddMarks
import CG_InitMarkPolys
import CG_OutOfAmmoChange
import CG_DrawWeaponSelect
import CG_AddPlayerWeapon
import CG_AddViewWeapon
import CG_GrappleTrail
import CG_RailTrail
import CG_Bullet
import CG_ShotgunFire
import CG_MissileHitPlayer
import CG_MissileHitWall
import CG_FireWeapon
import CG_RegisterItemVisuals
import CG_RegisterWeapon
import CG_Weapon_f
import CG_PrevWeapon_f
import CG_NextWeapon_f
import CG_PositionRotatedEntityOnTag
import CG_PositionEntityOnTag
import CG_AdjustPositionForMover
import CG_Beam
import CG_AddPacketEntities
import CG_SetEntitySoundPosition
import CG_PainEvent
import CG_EntityEvent
import CG_PlaceString
import CG_CheckEvents
import CG_LoadDeferredPlayers
import CG_PredictPlayerState
import CG_Trace
import CG_PointContents
import CG_BuildSolidList
import CG_CustomSound
import CG_NewClientInfo
import CG_AddRefEntityWithPowerups
import CG_ResetPlayerEntity
import CG_Player
import CG_StatusHandle
import CG_OtherTeamHasFlag
import CG_YourTeamHasFlag
import CG_GameTypeString
import CG_CheckOrderPending
import CG_Text_PaintChar
import CG_Draw3DModel
import CG_GetKillerText
import CG_GetGameStatusText
import CG_GetTeamColor
import CG_InitTeamChat
import CG_SetPrintString
import CG_ShowResponseHead
import CG_RunMenuScript
import CG_OwnerDrawVisible
import CG_GetValue
import CG_SelectNextPlayer
import CG_SelectPrevPlayer
import CG_Text_Height
import CG_Text_Width
import CG_Text_Paint
import CG_OwnerDraw
import CG_DrawTeamBackground
import CG_DrawFlagModel
import CG_DrawActive
import CG_DrawHead
import CG_CenterPrint
import CG_AddLagometerSnapshotInfo
import CG_AddLagometerFrameInfo
import teamChat2
import teamChat1
import systemChat
import drawTeamOverlayModificationCount
import numSortedTeamPlayers
import sortedTeamPlayers
import CG_DrawTopBottom
import CG_DrawSides
import CG_DrawRect
import UI_DrawProportionalString
import CG_GetColorForHealth
import CG_ColorForHealth
import CG_TileClear
import CG_TeamColor
import CG_FadeColor
import CG_DrawStrlen
import CG_DrawSmallStringColor
import CG_DrawSmallString
import CG_DrawBigStringColor
import CG_DrawBigString
import CG_DrawStringExt
import CG_DrawString
import CG_DrawPic
import CG_FillRect
import CG_AdjustFrom640
import CG_DrawActiveFrame
import CG_AddBufferedSound
import CG_ZoomUp_f
import CG_ZoomDown_f
import CG_TestModelPrevSkin_f
import CG_TestModelNextSkin_f
import CG_TestModelPrevFrame_f
import CG_TestModelNextFrame_f
import CG_TestGun_f
import CG_TestModel_f
import CG_BuildSpectatorString
import CG_GetSelectedScore
import CG_SetScoreSelection
import CG_RankRunFrame
import CG_EventHandling
import CG_MouseEvent
import CG_KeyEvent
import CG_LoadMenus
import CG_LastAttacker
import CG_CrosshairPlayer
import CG_UpdateCvars
import CG_StartMusic
import CG_Error
import CG_Printf
import CG_Argv
import CG_ConfigString
import cg_trueLightning
import cg_oldPlasma
import cg_oldRocket
import cg_oldRail
import cg_noProjectileTrail
import cg_noTaunt
import cg_bigFont
import cg_smallFont
import cg_cameraMode
import cg_timescale
import cg_timescaleFadeSpeed
import cg_timescaleFadeEnd
import cg_cameraOrbitDelay
import cg_cameraOrbit
import pmove_msec
import pmove_fixed
import cg_smoothClients
import cg_scorePlum
import cg_noVoiceText
import cg_noVoiceChats
import cg_teamChatsOnly
import cg_drawFriend
import cg_deferPlayers
import cg_predictItems
import cg_blood
import cg_paused
import cg_buildScript
import cg_forceModel
import cg_stats
import cg_teamChatHeight
import cg_teamChatTime
import cg_synchronousClients
import cg_drawAttacker
import cg_lagometer
import cg_stereoSeparation
import cg_thirdPerson
import cg_thirdPersonAngle
import cg_thirdPersonRange
import cg_zoomFov
import cg_fov
import cg_simpleItems
import cg_ignore
import cg_autoswitch
import cg_tracerLength
import cg_tracerWidth
import cg_tracerChance
import cg_viewsize
import cg_drawGun
import cg_gun_z
import cg_gun_y
import cg_gun_x
import cg_gun_frame
import cg_brassTime
import cg_addMarks
import cg_footsteps
import cg_showmiss
import cg_noPlayerAnims
import cg_nopredict
import cg_errorDecay
import cg_railTrailTime
import cg_debugEvents
import cg_debugPosition
import cg_debugAnim
import cg_animSpeed
import cg_draw2D
import cg_drawStatus
import cg_crosshairHealth
import cg_crosshairSize
import cg_crosshairY
import cg_crosshairX
import cg_teamOverlayUserinfo
import cg_drawTeamOverlay
import cg_drawRewards
import cg_drawCrosshairNames
import cg_drawCrosshair
import cg_drawAmmoWarning
import cg_drawIcons
import cg_draw3dIcons
import cg_drawSnapshot
import cg_drawFPS
import cg_drawTimer
import cg_gibs
import cg_shadows
import cg_swingSpeed
import cg_bobroll
import cg_bobpitch
import cg_bobup
import cg_runroll
import cg_runpitch
import cg_centertime
import cg_markPolys
import cg_items
import cg_weapons
import cg_entities
import cg
import cgs
import BG_PlayerTouchesItem
import BG_PlayerStateToEntityStateExtraPolate
import BG_PlayerStateToEntityState
import BG_TouchJumpPad
import BG_AddPredictableEventToPlayerstate
import BG_EvaluateTrajectoryDelta
import BG_EvaluateTrajectory
import BG_CanItemBeGrabbed
import BG_FindItemForHoldable
import BG_FindItemForPowerup
import BG_FindItemForWeapon
import BG_FindItem
import bg_numItems
import bg_itemlist
import Pmove
import PM_UpdateViewAngles
import Com_Printf
import Com_Error
import Info_NextPair
import Info_Validate
import Info_SetValueForKey_Big
import Info_SetValueForKey
import Info_RemoveKey_big
import Info_RemoveKey
import Info_ValueForKey
import va
import Q_CleanStr
import Q_PrintStrlen
import Q_strcat
import Q_strncpyz
import Q_strrchr
import Q_strupr
import Q_strlwr
import Q_stricmpn
import Q_strncmp
import Q_stricmp
import Q_isalpha
import Q_isupper
import Q_islower
import Q_isprint
import Com_sprintf
import Parse3DMatrix
import Parse2DMatrix
import Parse1DMatrix
import SkipRestOfLine
import SkipBracedSection
import COM_MatchToken
import COM_ParseWarning
import COM_ParseError
import COM_Compress
import COM_ParseExt
import COM_Parse
import COM_GetCurrentParseLine
import COM_BeginParseSession
import COM_DefaultExtension
import COM_StripExtension
import COM_SkipPath
import Com_Clamp
import PerpendicularVector
import AngleVectors
import MatrixMultiply
import MakeNormalVectors
import RotateAroundDirection
import RotatePointAroundVector
import ProjectPointOnPlane
import PlaneFromPoints
import AngleDelta
import AngleNormalize180
import AngleNormalize360
import AnglesSubtract
import AngleSubtract
import LerpAngle
import AngleMod
import BoxOnPlaneSide
import SetPlaneSignbits
import AxisCopy
import AxisClear
import AnglesToAxis
import vectoangles
import Q_crandom
import Q_random
import Q_rand
import Q_acos
import Q_log2
import VectorRotate
import Vector4Scale
import VectorNormalize2
import VectorNormalize
import CrossProduct
import VectorInverse
import VectorNormalizeFast
import DistanceSquared
import Distance
import VectorLengthSquared
import VectorLength
import VectorCompare
import AddPointToBounds
import ClearBounds
import RadiusFromBounds
import NormalizeColor
import ColorBytes4
import ColorBytes3
import _VectorMA
import _VectorScale
import _VectorCopy
import _VectorAdd
import _VectorSubtract
import _DotProduct
import ByteToDir
import DirToByte
import ClampShort
import ClampChar
import Q_rsqrt
import Q_fabs
import axisDefault
import vec3_origin
import g_color_table
import colorDkGrey
import colorMdGrey
import colorLtGrey
import colorWhite
import colorCyan
import colorMagenta
import colorYellow
import colorBlue
import colorGreen
import colorRed
import colorBlack
import bytedirs
import Com_Memcpy
import Com_Memset
import Hunk_Alloc
import FloatSwap
import LongSwap
import ShortSwap
import acos
import fabs
import abs
import tan
import atan2
import cos
import sin
import sqrt
import floor
import ceil
import memcpy
import memset
import memmove
import sscanf
import vsprintf
import _atoi
import atoi
import _atof
import atof
import toupper
import tolower
import strncpy
import strstr
import strchr
import strcmp
import strcpy
import strcat
import strlen
import rand
import srand
import qsort
lit
align 1
LABELV $174
byte 1 99
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $171
byte 1 99
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $167
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $164
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $160
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $157
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 108
byte 1 105
byte 1 109
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $155
byte 1 85
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 71
byte 1 97
byte 1 109
byte 1 101
byte 1 116
byte 1 121
byte 1 112
byte 1 101
byte 1 0
align 1
LABELV $154
byte 1 67
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 32
byte 1 84
byte 1 104
byte 1 101
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $152
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 32
byte 1 68
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 109
byte 1 97
byte 1 116
byte 1 99
byte 1 104
byte 1 0
align 1
LABELV $150
byte 1 84
byte 1 111
byte 1 117
byte 1 114
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $148
byte 1 83
byte 1 105
byte 1 110
byte 1 103
byte 1 108
byte 1 101
byte 1 32
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $146
byte 1 70
byte 1 114
byte 1 101
byte 1 101
byte 1 32
byte 1 70
byte 1 111
byte 1 114
byte 1 32
byte 1 65
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $140
byte 1 67
byte 1 72
byte 1 69
byte 1 65
byte 1 84
byte 1 83
byte 1 32
byte 1 65
byte 1 82
byte 1 69
byte 1 32
byte 1 69
byte 1 78
byte 1 65
byte 1 66
byte 1 76
byte 1 69
byte 1 68
byte 1 0
align 1
LABELV $137
byte 1 115
byte 1 118
byte 1 95
byte 1 99
byte 1 104
byte 1 101
byte 1 97
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $132
byte 1 80
byte 1 117
byte 1 114
byte 1 101
byte 1 32
byte 1 83
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $129
byte 1 115
byte 1 118
byte 1 95
byte 1 112
byte 1 117
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $128
byte 1 115
byte 1 118
byte 1 95
byte 1 104
byte 1 111
byte 1 115
byte 1 116
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $125
byte 1 115
byte 1 118
byte 1 95
byte 1 114
byte 1 117
byte 1 110
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $124
byte 1 65
byte 1 119
byte 1 97
byte 1 105
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 115
byte 1 110
byte 1 97
byte 1 112
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 46
byte 1 46
byte 1 46
byte 1 0
align 1
LABELV $122
byte 1 76
byte 1 111
byte 1 97
byte 1 100
byte 1 105
byte 1 110
byte 1 103
byte 1 46
byte 1 46
byte 1 46
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $114
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 83
byte 1 104
byte 1 111
byte 1 116
byte 1 68
byte 1 101
byte 1 116
byte 1 97
byte 1 105
byte 1 108
byte 1 0
align 1
LABELV $113
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 117
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 109
byte 1 97
byte 1 112
byte 1 0
align 1
LABELV $110
byte 1 108
byte 1 101
byte 1 118
byte 1 101
byte 1 108
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $109
byte 1 109
byte 1 97
byte 1 112
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $107
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 47
byte 1 97
byte 1 110
byte 1 110
byte 1 111
byte 1 117
byte 1 110
byte 1 99
byte 1 101
byte 1 47
byte 1 37
byte 1 115
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $103
byte 1 110
byte 1 0
align 1
LABELV $100
byte 1 115
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $97
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 97
byte 1 99
byte 1 116
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 95
byte 1 37
byte 1 115
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $94
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 95
byte 1 37
byte 1 115
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $93
byte 1 100
byte 1 101
byte 1 102
byte 1 97
byte 1 117
byte 1 108
byte 1 116
byte 1 0
align 1
LABELV $90
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
