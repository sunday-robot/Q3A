data
export forceModelModificationCount
align 4
LABELV forceModelModificationCount
byte 4 -1
export vmMain
code
proc vmMain 16 12
file "../cg_main.c"
line 46
;1:/*
;2:===========================================================================
;3:Copyright (C) 1999-2005 Id Software, Inc.
;4:
;5:This file is part of Quake III Arena source code.
;6:
;7:Quake III Arena source code is free software; you can redistribute it
;8:and/or modify it under the terms of the GNU General Public License as
;9:published by the Free Software Foundation; either version 2 of the License,
;10:or (at your option) any later version.
;11:
;12:Quake III Arena source code is distributed in the hope that it will be
;13:useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
;14:MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;15:GNU General Public License for more details.
;16:
;17:You should have received a copy of the GNU General Public License
;18:along with Foobar; if not, write to the Free Software
;19:Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
;20:===========================================================================
;21:*/
;22://
;23:// cg_main.c -- initialization and primary entry point for cgame
;24:#include "cg_local.h"
;25:
;26:#ifdef MISSIONPACK
;27:#include "../ui/ui_shared.h"
;28:// display context for new ui stuff
;29:displayContextDef_t cgDC;
;30:#endif
;31:
;32:int forceModelModificationCount = -1;
;33:
;34:void CG_Init( int serverMessageNum, int serverCommandSequence, int clientNum );
;35:void CG_Shutdown( void );
;36:
;37:
;38:/*
;39:================
;40:vmMain
;41:
;42:This is the only way control passes into the module.
;43:This must be the very first function compiled into the .q3vm file
;44:================
;45:*/
;46:int vmMain( int command, int arg0, int arg1, int arg2, int arg3, int arg4, int arg5, int arg6, int arg7, int arg8, int arg9, int arg10, int arg11  ) {
line 48
;47:
;48:	switch ( command ) {
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $71
ADDRLP4 0
INDIRI4
CNSTI4 8
GTI4 $71
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $83
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $83
address $73
address $74
address $75
address $76
address $77
address $78
address $79
address $80
address $81
code
LABELV $73
line 50
;49:	case CG_INIT:
;50:		CG_Init( arg0, arg1, arg2 );
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 CG_Init
CALLV
pop
line 51
;51:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $70
JUMPV
LABELV $74
line 53
;52:	case CG_SHUTDOWN:
;53:		CG_Shutdown();
ADDRGP4 CG_Shutdown
CALLV
pop
line 54
;54:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $70
JUMPV
LABELV $75
line 56
;55:	case CG_CONSOLE_COMMAND:
;56:		return CG_ConsoleCommand();
ADDRLP4 4
ADDRGP4 CG_ConsoleCommand
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
RETI4
ADDRGP4 $70
JUMPV
LABELV $76
line 58
;57:	case CG_DRAW_ACTIVE_FRAME:
;58:		CG_DrawActiveFrame( arg0, arg1, arg2 );
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 CG_DrawActiveFrame
CALLV
pop
line 59
;59:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $70
JUMPV
LABELV $77
line 61
;60:	case CG_CROSSHAIR_PLAYER:
;61:		return CG_CrosshairPlayer();
ADDRLP4 8
ADDRGP4 CG_CrosshairPlayer
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
RETI4
ADDRGP4 $70
JUMPV
LABELV $78
line 63
;62:	case CG_LAST_ATTACKER:
;63:		return CG_LastAttacker();
ADDRLP4 12
ADDRGP4 CG_LastAttacker
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
RETI4
ADDRGP4 $70
JUMPV
LABELV $79
line 65
;64:	case CG_KEY_EVENT:
;65:		CG_KeyEvent(arg0, arg1);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 CG_KeyEvent
CALLV
pop
line 66
;66:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $70
JUMPV
LABELV $80
line 72
;67:	case CG_MOUSE_EVENT:
;68:#ifdef MISSIONPACK
;69:		cgDC.cursorx = cgs.cursorX;
;70:		cgDC.cursory = cgs.cursorY;
;71:#endif
;72:		CG_MouseEvent(arg0, arg1);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 CG_MouseEvent
CALLV
pop
line 73
;73:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $70
JUMPV
LABELV $81
line 75
;74:	case CG_EVENT_HANDLING:
;75:		CG_EventHandling(arg0);
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 CG_EventHandling
CALLV
pop
line 76
;76:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $70
JUMPV
LABELV $71
line 78
;77:	default:
;78:		CG_Error( "vmMain: unknown command %i", command );
ADDRGP4 $82
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 CG_Error
CALLV
pop
line 79
;79:		break;
LABELV $72
line 81
;80:	}
;81:	return -1;
CNSTI4 -1
RETI4
LABELV $70
endproc vmMain 16 12
data
align 4
LABELV cvarTable
address cg_ignore
address $85
address $86
byte 4 0
address cg_autoswitch
address $87
address $88
byte 4 1
address cg_drawGun
address $89
address $88
byte 4 1
address cg_zoomFov
address $90
address $91
byte 4 1
address cg_fov
address $92
address $93
byte 4 1
address cg_viewsize
address $94
address $95
byte 4 1
address cg_stereoSeparation
address $96
address $97
byte 4 1
address cg_shadows
address $98
address $88
byte 4 1
address cg_gibs
address $99
address $88
byte 4 1
address cg_draw2D
address $100
address $88
byte 4 1
address cg_drawStatus
address $101
address $88
byte 4 1
address cg_drawTimer
address $102
address $86
byte 4 1
address cg_drawFPS
address $103
address $86
byte 4 1
address cg_drawSnapshot
address $104
address $86
byte 4 1
address cg_draw3dIcons
address $105
address $88
byte 4 1
address cg_drawIcons
address $106
address $88
byte 4 1
address cg_drawAmmoWarning
address $107
address $88
byte 4 1
address cg_drawAttacker
address $108
address $88
byte 4 1
address cg_drawCrosshair
address $109
address $110
byte 4 1
address cg_drawCrosshairNames
address $111
address $88
byte 4 1
address cg_drawRewards
address $112
address $88
byte 4 1
address cg_crosshairSize
address $113
address $114
byte 4 1
address cg_crosshairHealth
address $115
address $88
byte 4 1
address cg_crosshairX
address $116
address $86
byte 4 1
address cg_crosshairY
address $117
address $86
byte 4 1
address cg_brassTime
address $118
address $119
byte 4 1
address cg_simpleItems
address $120
address $86
byte 4 1
address cg_addMarks
address $121
address $88
byte 4 1
address cg_lagometer
address $122
address $88
byte 4 1
address cg_railTrailTime
address $123
address $124
byte 4 1
address cg_gun_x
address $125
address $86
byte 4 512
address cg_gun_y
address $126
address $86
byte 4 512
address cg_gun_z
address $127
address $86
byte 4 512
address cg_centertime
address $128
address $129
byte 4 512
address cg_runpitch
address $130
address $131
byte 4 1
address cg_runroll
address $132
address $133
byte 4 1
address cg_bobup
address $134
address $133
byte 4 512
address cg_bobpitch
address $135
address $131
byte 4 1
address cg_bobroll
address $136
address $131
byte 4 1
address cg_swingSpeed
address $137
address $138
byte 4 512
address cg_animSpeed
address $139
address $88
byte 4 512
address cg_debugAnim
address $140
address $86
byte 4 512
address cg_debugPosition
address $141
address $86
byte 4 512
address cg_debugEvents
address $142
address $86
byte 4 512
address cg_errorDecay
address $143
address $95
byte 4 0
address cg_nopredict
address $144
address $86
byte 4 0
address cg_noPlayerAnims
address $145
address $86
byte 4 512
address cg_showmiss
address $146
address $86
byte 4 0
address cg_footsteps
address $147
address $88
byte 4 512
address cg_tracerChance
address $148
address $97
byte 4 512
address cg_tracerWidth
address $149
address $88
byte 4 512
address cg_tracerLength
address $150
address $95
byte 4 512
address cg_thirdPersonRange
address $151
address $152
byte 4 512
address cg_thirdPersonAngle
address $153
address $86
byte 4 512
address cg_thirdPerson
address $154
address $86
byte 4 0
address cg_teamChatTime
address $155
address $156
byte 4 1
address cg_teamChatHeight
address $157
address $86
byte 4 1
address cg_forceModel
address $158
address $86
byte 4 1
address cg_predictItems
address $159
address $88
byte 4 1
address cg_deferPlayers
address $160
address $88
byte 4 1
address cg_drawTeamOverlay
address $161
address $86
byte 4 1
address cg_teamOverlayUserinfo
address $162
address $86
byte 4 66
address cg_stats
address $163
address $86
byte 4 0
address cg_drawFriend
address $164
address $88
byte 4 1
address cg_teamChatsOnly
address $165
address $86
byte 4 1
address cg_noVoiceChats
address $166
address $86
byte 4 1
address cg_noVoiceText
address $167
address $86
byte 4 1
address cg_buildScript
address $168
address $86
byte 4 0
address cg_paused
address $169
address $86
byte 4 64
address cg_blood
address $170
address $88
byte 4 1
address cg_synchronousClients
address $171
address $86
byte 4 0
address cg_cameraOrbit
address $172
address $86
byte 4 512
address cg_cameraOrbitDelay
address $173
address $174
byte 4 1
address cg_timescaleFadeEnd
address $175
address $88
byte 4 0
address cg_timescaleFadeSpeed
address $176
address $86
byte 4 0
address cg_timescale
address $177
address $88
byte 4 0
address cg_scorePlum
address $178
address $88
byte 4 3
address cg_smoothClients
address $179
address $86
byte 4 3
address cg_cameraMode
address $180
address $86
byte 4 512
address pmove_fixed
address $181
address $86
byte 4 0
address pmove_msec
address $182
address $183
byte 4 0
address cg_noTaunt
address $184
address $86
byte 4 1
address cg_noProjectileTrail
address $185
address $86
byte 4 1
address cg_smallFont
address $186
address $187
byte 4 1
address cg_bigFont
address $188
address $97
byte 4 1
address cg_oldRail
address $189
address $88
byte 4 1
address cg_oldRocket
address $190
address $88
byte 4 1
address cg_oldPlasma
address $191
address $88
byte 4 1
address cg_trueLightning
address $192
address $193
byte 4 1
align 4
LABELV cvarTableSize
byte 4 89
export CG_RegisterCvars
code
proc CG_RegisterCvars 1036 16
line 326
;82:}
;83:
;84:
;85:cg_t				cg;
;86:cgs_t				cgs;
;87:centity_t			cg_entities[MAX_GENTITIES];
;88:weaponInfo_t		cg_weapons[MAX_WEAPONS];
;89:itemInfo_t			cg_items[MAX_ITEMS];
;90:
;91:
;92:vmCvar_t	cg_railTrailTime;
;93:vmCvar_t	cg_centertime;
;94:vmCvar_t	cg_runpitch;
;95:vmCvar_t	cg_runroll;
;96:vmCvar_t	cg_bobup;
;97:vmCvar_t	cg_bobpitch;
;98:vmCvar_t	cg_bobroll;
;99:vmCvar_t	cg_swingSpeed;
;100:vmCvar_t	cg_shadows;
;101:vmCvar_t	cg_gibs;
;102:vmCvar_t	cg_drawTimer;
;103:vmCvar_t	cg_drawFPS;
;104:vmCvar_t	cg_drawSnapshot;
;105:vmCvar_t	cg_draw3dIcons;
;106:vmCvar_t	cg_drawIcons;
;107:vmCvar_t	cg_drawAmmoWarning;
;108:vmCvar_t	cg_drawCrosshair;
;109:vmCvar_t	cg_drawCrosshairNames;
;110:vmCvar_t	cg_drawRewards;
;111:vmCvar_t	cg_crosshairSize;
;112:vmCvar_t	cg_crosshairX;
;113:vmCvar_t	cg_crosshairY;
;114:vmCvar_t	cg_crosshairHealth;
;115:vmCvar_t	cg_draw2D;
;116:vmCvar_t	cg_drawStatus;
;117:vmCvar_t	cg_animSpeed;
;118:vmCvar_t	cg_debugAnim;
;119:vmCvar_t	cg_debugPosition;
;120:vmCvar_t	cg_debugEvents;
;121:vmCvar_t	cg_errorDecay;
;122:vmCvar_t	cg_nopredict;
;123:vmCvar_t	cg_noPlayerAnims;
;124:vmCvar_t	cg_showmiss;
;125:vmCvar_t	cg_footsteps;
;126:vmCvar_t	cg_addMarks;
;127:vmCvar_t	cg_brassTime;
;128:vmCvar_t	cg_viewsize;
;129:vmCvar_t	cg_drawGun;
;130:vmCvar_t	cg_gun_frame;
;131:vmCvar_t	cg_gun_x;
;132:vmCvar_t	cg_gun_y;
;133:vmCvar_t	cg_gun_z;
;134:vmCvar_t	cg_tracerChance;
;135:vmCvar_t	cg_tracerWidth;
;136:vmCvar_t	cg_tracerLength;
;137:vmCvar_t	cg_autoswitch;
;138:vmCvar_t	cg_ignore;
;139:vmCvar_t	cg_simpleItems;
;140:vmCvar_t	cg_fov;
;141:vmCvar_t	cg_zoomFov;
;142:vmCvar_t	cg_thirdPerson;
;143:vmCvar_t	cg_thirdPersonRange;
;144:vmCvar_t	cg_thirdPersonAngle;
;145:vmCvar_t	cg_stereoSeparation;
;146:vmCvar_t	cg_lagometer;
;147:vmCvar_t	cg_drawAttacker;
;148:vmCvar_t	cg_synchronousClients;
;149:vmCvar_t 	cg_teamChatTime;
;150:vmCvar_t 	cg_teamChatHeight;
;151:vmCvar_t 	cg_stats;
;152:vmCvar_t 	cg_buildScript;
;153:vmCvar_t 	cg_forceModel;
;154:vmCvar_t	cg_paused;
;155:vmCvar_t	cg_blood;
;156:vmCvar_t	cg_predictItems;
;157:vmCvar_t	cg_deferPlayers;
;158:vmCvar_t	cg_drawTeamOverlay;
;159:vmCvar_t	cg_teamOverlayUserinfo;
;160:vmCvar_t	cg_drawFriend;
;161:vmCvar_t	cg_teamChatsOnly;
;162:vmCvar_t	cg_noVoiceChats;
;163:vmCvar_t	cg_noVoiceText;
;164:vmCvar_t	cg_hudFiles;
;165:vmCvar_t 	cg_scorePlum;
;166:vmCvar_t 	cg_smoothClients;
;167:vmCvar_t	pmove_fixed;
;168:vmCvar_t	pmove_msec;
;169:vmCvar_t	cg_pmove_msec;
;170:vmCvar_t	cg_cameraMode;
;171:vmCvar_t	cg_cameraOrbit;
;172:vmCvar_t	cg_cameraOrbitDelay;
;173:vmCvar_t	cg_timescaleFadeEnd;
;174:vmCvar_t	cg_timescaleFadeSpeed;
;175:vmCvar_t	cg_timescale;
;176:vmCvar_t	cg_smallFont;
;177:vmCvar_t	cg_bigFont;
;178:vmCvar_t	cg_noTaunt;
;179:vmCvar_t	cg_noProjectileTrail;
;180:vmCvar_t	cg_oldRail;
;181:vmCvar_t	cg_oldRocket;
;182:vmCvar_t	cg_oldPlasma;
;183:vmCvar_t	cg_trueLightning;
;184:
;185:#ifdef MISSIONPACK
;186:vmCvar_t 	cg_redTeamName;
;187:vmCvar_t 	cg_blueTeamName;
;188:vmCvar_t	cg_currentSelectedPlayer;
;189:vmCvar_t	cg_currentSelectedPlayerName;
;190:vmCvar_t	cg_singlePlayer;
;191:vmCvar_t	cg_enableDust;
;192:vmCvar_t	cg_enableBreath;
;193:vmCvar_t	cg_singlePlayerActive;
;194:vmCvar_t	cg_recordSPDemo;
;195:vmCvar_t	cg_recordSPDemoName;
;196:vmCvar_t	cg_obeliskRespawnDelay;
;197:#endif
;198:
;199:typedef struct {
;200:	vmCvar_t	*vmCvar;
;201:	char		*cvarName;
;202:	char		*defaultString;
;203:	int			cvarFlags;
;204:} cvarTable_t;
;205:
;206:static cvarTable_t cvarTable[] = { // bk001129
;207:	{ &cg_ignore, "cg_ignore", "0", 0 },	// used for debugging
;208:	{ &cg_autoswitch, "cg_autoswitch", "1", CVAR_ARCHIVE },
;209:	{ &cg_drawGun, "cg_drawGun", "1", CVAR_ARCHIVE },
;210:	{ &cg_zoomFov, "cg_zoomfov", "22.5", CVAR_ARCHIVE },
;211:	{ &cg_fov, "cg_fov", "90", CVAR_ARCHIVE },
;212:	{ &cg_viewsize, "cg_viewsize", "100", CVAR_ARCHIVE },
;213:	{ &cg_stereoSeparation, "cg_stereoSeparation", "0.4", CVAR_ARCHIVE  },
;214:	{ &cg_shadows, "cg_shadows", "1", CVAR_ARCHIVE  },
;215:	{ &cg_gibs, "cg_gibs", "1", CVAR_ARCHIVE  },
;216:	{ &cg_draw2D, "cg_draw2D", "1", CVAR_ARCHIVE  },
;217:	{ &cg_drawStatus, "cg_drawStatus", "1", CVAR_ARCHIVE  },
;218:	{ &cg_drawTimer, "cg_drawTimer", "0", CVAR_ARCHIVE  },
;219:	{ &cg_drawFPS, "cg_drawFPS", "0", CVAR_ARCHIVE  },
;220:	{ &cg_drawSnapshot, "cg_drawSnapshot", "0", CVAR_ARCHIVE  },
;221:	{ &cg_draw3dIcons, "cg_draw3dIcons", "1", CVAR_ARCHIVE  },
;222:	{ &cg_drawIcons, "cg_drawIcons", "1", CVAR_ARCHIVE  },
;223:	{ &cg_drawAmmoWarning, "cg_drawAmmoWarning", "1", CVAR_ARCHIVE  },
;224:	{ &cg_drawAttacker, "cg_drawAttacker", "1", CVAR_ARCHIVE  },
;225:	{ &cg_drawCrosshair, "cg_drawCrosshair", "4", CVAR_ARCHIVE },
;226:	{ &cg_drawCrosshairNames, "cg_drawCrosshairNames", "1", CVAR_ARCHIVE },
;227:	{ &cg_drawRewards, "cg_drawRewards", "1", CVAR_ARCHIVE },
;228:	{ &cg_crosshairSize, "cg_crosshairSize", "24", CVAR_ARCHIVE },
;229:	{ &cg_crosshairHealth, "cg_crosshairHealth", "1", CVAR_ARCHIVE },
;230:	{ &cg_crosshairX, "cg_crosshairX", "0", CVAR_ARCHIVE },
;231:	{ &cg_crosshairY, "cg_crosshairY", "0", CVAR_ARCHIVE },
;232:	{ &cg_brassTime, "cg_brassTime", "2500", CVAR_ARCHIVE },
;233:	{ &cg_simpleItems, "cg_simpleItems", "0", CVAR_ARCHIVE },
;234:	{ &cg_addMarks, "cg_marks", "1", CVAR_ARCHIVE },
;235:	{ &cg_lagometer, "cg_lagometer", "1", CVAR_ARCHIVE },
;236:	{ &cg_railTrailTime, "cg_railTrailTime", "400", CVAR_ARCHIVE  },
;237:	{ &cg_gun_x, "cg_gunX", "0", CVAR_CHEAT },
;238:	{ &cg_gun_y, "cg_gunY", "0", CVAR_CHEAT },
;239:	{ &cg_gun_z, "cg_gunZ", "0", CVAR_CHEAT },
;240:	{ &cg_centertime, "cg_centertime", "3", CVAR_CHEAT },
;241:	{ &cg_runpitch, "cg_runpitch", "0.002", CVAR_ARCHIVE},
;242:	{ &cg_runroll, "cg_runroll", "0.005", CVAR_ARCHIVE },
;243:	{ &cg_bobup , "cg_bobup", "0.005", CVAR_CHEAT },
;244:	{ &cg_bobpitch, "cg_bobpitch", "0.002", CVAR_ARCHIVE },
;245:	{ &cg_bobroll, "cg_bobroll", "0.002", CVAR_ARCHIVE },
;246:	{ &cg_swingSpeed, "cg_swingSpeed", "0.3", CVAR_CHEAT },
;247:	{ &cg_animSpeed, "cg_animspeed", "1", CVAR_CHEAT },
;248:	{ &cg_debugAnim, "cg_debuganim", "0", CVAR_CHEAT },
;249:	{ &cg_debugPosition, "cg_debugposition", "0", CVAR_CHEAT },
;250:	{ &cg_debugEvents, "cg_debugevents", "0", CVAR_CHEAT },
;251:	{ &cg_errorDecay, "cg_errordecay", "100", 0 },
;252:	{ &cg_nopredict, "cg_nopredict", "0", 0 },
;253:	{ &cg_noPlayerAnims, "cg_noplayeranims", "0", CVAR_CHEAT },
;254:	{ &cg_showmiss, "cg_showmiss", "0", 0 },
;255:	{ &cg_footsteps, "cg_footsteps", "1", CVAR_CHEAT },
;256:	{ &cg_tracerChance, "cg_tracerchance", "0.4", CVAR_CHEAT },
;257:	{ &cg_tracerWidth, "cg_tracerwidth", "1", CVAR_CHEAT },
;258:	{ &cg_tracerLength, "cg_tracerlength", "100", CVAR_CHEAT },
;259:	{ &cg_thirdPersonRange, "cg_thirdPersonRange", "40", CVAR_CHEAT },
;260:	{ &cg_thirdPersonAngle, "cg_thirdPersonAngle", "0", CVAR_CHEAT },
;261:	{ &cg_thirdPerson, "cg_thirdPerson", "0", 0 },
;262:	{ &cg_teamChatTime, "cg_teamChatTime", "3000", CVAR_ARCHIVE  },
;263:	{ &cg_teamChatHeight, "cg_teamChatHeight", "0", CVAR_ARCHIVE  },
;264:	{ &cg_forceModel, "cg_forceModel", "0", CVAR_ARCHIVE  },
;265:	{ &cg_predictItems, "cg_predictItems", "1", CVAR_ARCHIVE },
;266:#ifdef MISSIONPACK
;267:	{ &cg_deferPlayers, "cg_deferPlayers", "0", CVAR_ARCHIVE },
;268:#else
;269:	{ &cg_deferPlayers, "cg_deferPlayers", "1", CVAR_ARCHIVE },
;270:#endif
;271:	{ &cg_drawTeamOverlay, "cg_drawTeamOverlay", "0", CVAR_ARCHIVE },
;272:	{ &cg_teamOverlayUserinfo, "teamoverlay", "0", CVAR_ROM | CVAR_USERINFO },
;273:	{ &cg_stats, "cg_stats", "0", 0 },
;274:	{ &cg_drawFriend, "cg_drawFriend", "1", CVAR_ARCHIVE },
;275:	{ &cg_teamChatsOnly, "cg_teamChatsOnly", "0", CVAR_ARCHIVE },
;276:	{ &cg_noVoiceChats, "cg_noVoiceChats", "0", CVAR_ARCHIVE },
;277:	{ &cg_noVoiceText, "cg_noVoiceText", "0", CVAR_ARCHIVE },
;278:	// the following variables are created in other parts of the system,
;279:	// but we also reference them here
;280:	{ &cg_buildScript, "com_buildScript", "0", 0 },	// force loading of all possible data amd error on failures
;281:	{ &cg_paused, "cl_paused", "0", CVAR_ROM },
;282:	{ &cg_blood, "com_blood", "1", CVAR_ARCHIVE },
;283:	{ &cg_synchronousClients, "g_synchronousClients", "0", 0 },	// communicated by systeminfo
;284:#ifdef MISSIONPACK
;285:	{ &cg_redTeamName, "g_redteam", DEFAULT_REDTEAM_NAME, CVAR_ARCHIVE | CVAR_SERVERINFO | CVAR_USERINFO },
;286:	{ &cg_blueTeamName, "g_blueteam", DEFAULT_BLUETEAM_NAME, CVAR_ARCHIVE | CVAR_SERVERINFO | CVAR_USERINFO },
;287:	{ &cg_currentSelectedPlayer, "cg_currentSelectedPlayer", "0", CVAR_ARCHIVE},
;288:	{ &cg_currentSelectedPlayerName, "cg_currentSelectedPlayerName", "", CVAR_ARCHIVE},
;289:	{ &cg_singlePlayer, "ui_singlePlayerActive", "0", CVAR_USERINFO},
;290:	{ &cg_enableDust, "g_enableDust", "0", CVAR_SERVERINFO},
;291:	{ &cg_enableBreath, "g_enableBreath", "0", CVAR_SERVERINFO},
;292:	{ &cg_singlePlayerActive, "ui_singlePlayerActive", "0", CVAR_USERINFO},
;293:	{ &cg_recordSPDemo, "ui_recordSPDemo", "0", CVAR_ARCHIVE},
;294:	{ &cg_recordSPDemoName, "ui_recordSPDemoName", "", CVAR_ARCHIVE},
;295:	{ &cg_obeliskRespawnDelay, "g_obeliskRespawnDelay", "10", CVAR_SERVERINFO},
;296:	{ &cg_hudFiles, "cg_hudFiles", "ui/hud.txt", CVAR_ARCHIVE},
;297:#endif
;298:	{ &cg_cameraOrbit, "cg_cameraOrbit", "0", CVAR_CHEAT},
;299:	{ &cg_cameraOrbitDelay, "cg_cameraOrbitDelay", "50", CVAR_ARCHIVE},
;300:	{ &cg_timescaleFadeEnd, "cg_timescaleFadeEnd", "1", 0},
;301:	{ &cg_timescaleFadeSpeed, "cg_timescaleFadeSpeed", "0", 0},
;302:	{ &cg_timescale, "timescale", "1", 0},
;303:	{ &cg_scorePlum, "cg_scorePlums", "1", CVAR_USERINFO | CVAR_ARCHIVE},
;304:	{ &cg_smoothClients, "cg_smoothClients", "0", CVAR_USERINFO | CVAR_ARCHIVE},
;305:	{ &cg_cameraMode, "com_cameraMode", "0", CVAR_CHEAT},
;306:
;307:	{ &pmove_fixed, "pmove_fixed", "0", 0},
;308:	{ &pmove_msec, "pmove_msec", "8", 0},
;309:	{ &cg_noTaunt, "cg_noTaunt", "0", CVAR_ARCHIVE},
;310:	{ &cg_noProjectileTrail, "cg_noProjectileTrail", "0", CVAR_ARCHIVE},
;311:	{ &cg_smallFont, "ui_smallFont", "0.25", CVAR_ARCHIVE},
;312:	{ &cg_bigFont, "ui_bigFont", "0.4", CVAR_ARCHIVE},
;313:	{ &cg_oldRail, "cg_oldRail", "1", CVAR_ARCHIVE},
;314:	{ &cg_oldRocket, "cg_oldRocket", "1", CVAR_ARCHIVE},
;315:	{ &cg_oldPlasma, "cg_oldPlasma", "1", CVAR_ARCHIVE},
;316:	{ &cg_trueLightning, "cg_trueLightning", "0.0", CVAR_ARCHIVE}
;317:};
;318:
;319:static int  cvarTableSize = sizeof( cvarTable ) / sizeof( cvarTable[0] );
;320:
;321:/*
;322:=================
;323:CG_RegisterCvars
;324:=================
;325:*/
;326:void CG_RegisterCvars( void ) {
line 331
;327:	int			i;
;328:	cvarTable_t	*cv;
;329:	char		var[MAX_TOKEN_CHARS];
;330:
;331:	for ( i = 0, cv = cvarTable ; i < cvarTableSize ; i++, cv++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRLP4 0
ADDRGP4 cvarTable
ASGNP4
ADDRGP4 $198
JUMPV
LABELV $195
line 332
;332:		trap_Cvar_Register( cv->vmCvar, cv->cvarName,
ADDRLP4 0
INDIRP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 334
;333:			cv->defaultString, cv->cvarFlags );
;334:	}
LABELV $196
line 331
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
LABELV $198
ADDRLP4 4
INDIRI4
ADDRGP4 cvarTableSize
INDIRI4
LTI4 $195
line 337
;335:
;336:	// see if we are also running the server on this machine
;337:	trap_Cvar_VariableStringBuffer( "sv_running", var, sizeof( var ) );
ADDRGP4 $199
ARGP4
ADDRLP4 8
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 338
;338:	cgs.localServer = atoi( var );
ADDRLP4 8
ARGP4
ADDRLP4 1032
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cgs+31452
ADDRLP4 1032
INDIRI4
ASGNI4
line 340
;339:
;340:	forceModelModificationCount = cg_forceModel.modificationCount;
ADDRGP4 forceModelModificationCount
ADDRGP4 cg_forceModel+4
INDIRI4
ASGNI4
line 342
;341:
;342:	trap_Cvar_Register(NULL, "model", DEFAULT_MODEL, CVAR_USERINFO | CVAR_ARCHIVE );
CNSTP4 0
ARGP4
ADDRGP4 $202
ARGP4
ADDRGP4 $203
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 343
;343:	trap_Cvar_Register(NULL, "headmodel", DEFAULT_MODEL, CVAR_USERINFO | CVAR_ARCHIVE );
CNSTP4 0
ARGP4
ADDRGP4 $204
ARGP4
ADDRGP4 $203
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 344
;344:	trap_Cvar_Register(NULL, "team_model", DEFAULT_TEAM_MODEL, CVAR_USERINFO | CVAR_ARCHIVE );
CNSTP4 0
ARGP4
ADDRGP4 $205
ARGP4
ADDRGP4 $203
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 345
;345:	trap_Cvar_Register(NULL, "team_headmodel", DEFAULT_TEAM_HEAD, CVAR_USERINFO | CVAR_ARCHIVE );
CNSTP4 0
ARGP4
ADDRGP4 $206
ARGP4
ADDRGP4 $203
ARGP4
CNSTI4 3
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 346
;346:}
LABELV $194
endproc CG_RegisterCvars 1036 16
proc CG_ForceModelChange 12 4
line 353
;347:
;348:/*																																			
;349:===================
;350:CG_ForceModelChange
;351:===================
;352:*/
;353:static void CG_ForceModelChange( void ) {
line 356
;354:	int		i;
;355:
;356:	for (i=0 ; i<MAX_CLIENTS ; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $208
line 359
;357:		const char		*clientInfo;
;358:
;359:		clientInfo = CG_ConfigString( CS_PLAYERS+i );
ADDRLP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 8
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
ASGNP4
line 360
;360:		if ( !clientInfo[0] ) {
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $212
line 361
;361:			continue;
ADDRGP4 $209
JUMPV
LABELV $212
line 363
;362:		}
;363:		CG_NewClientInfo( i );
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_NewClientInfo
CALLV
pop
line 364
;364:	}
LABELV $209
line 356
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $208
line 365
;365:}
LABELV $207
endproc CG_ForceModelChange 12 4
export CG_UpdateCvars
proc CG_UpdateCvars 8 8
line 372
;366:
;367:/*
;368:=================
;369:CG_UpdateCvars
;370:=================
;371:*/
;372:void CG_UpdateCvars( void ) {
line 376
;373:	int			i;
;374:	cvarTable_t	*cv;
;375:
;376:	for ( i = 0, cv = cvarTable ; i < cvarTableSize ; i++, cv++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRLP4 4
ADDRGP4 cvarTable
ASGNP4
ADDRGP4 $218
JUMPV
LABELV $215
line 377
;377:		trap_Cvar_Update( cv->vmCvar );
ADDRLP4 4
INDIRP4
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 378
;378:	}
LABELV $216
line 376
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
ADDRLP4 4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
LABELV $218
ADDRLP4 0
INDIRI4
ADDRGP4 cvarTableSize
INDIRI4
LTI4 $215
line 384
;379:
;380:	// check for modications here
;381:
;382:	// If team overlay is on, ask for updates from the server.  If its off,
;383:	// let the server know so we don't receive it
;384:	if ( drawTeamOverlayModificationCount != cg_drawTeamOverlay.modificationCount ) {
ADDRGP4 drawTeamOverlayModificationCount
INDIRI4
ADDRGP4 cg_drawTeamOverlay+4
INDIRI4
EQI4 $219
line 385
;385:		drawTeamOverlayModificationCount = cg_drawTeamOverlay.modificationCount;
ADDRGP4 drawTeamOverlayModificationCount
ADDRGP4 cg_drawTeamOverlay+4
INDIRI4
ASGNI4
line 387
;386:
;387:		if ( cg_drawTeamOverlay.integer > 0 ) {
ADDRGP4 cg_drawTeamOverlay+12
INDIRI4
CNSTI4 0
LEI4 $223
line 388
;388:			trap_Cvar_Set( "teamoverlay", "1" );
ADDRGP4 $162
ARGP4
ADDRGP4 $88
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 389
;389:		} else {
ADDRGP4 $224
JUMPV
LABELV $223
line 390
;390:			trap_Cvar_Set( "teamoverlay", "0" );
ADDRGP4 $162
ARGP4
ADDRGP4 $86
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 391
;391:		}
LABELV $224
line 393
;392:		// FIXME E3 HACK
;393:		trap_Cvar_Set( "teamoverlay", "1" );
ADDRGP4 $162
ARGP4
ADDRGP4 $88
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 394
;394:	}
LABELV $219
line 397
;395:
;396:	// if force model changed
;397:	if ( forceModelModificationCount != cg_forceModel.modificationCount ) {
ADDRGP4 forceModelModificationCount
INDIRI4
ADDRGP4 cg_forceModel+4
INDIRI4
EQI4 $226
line 398
;398:		forceModelModificationCount = cg_forceModel.modificationCount;
ADDRGP4 forceModelModificationCount
ADDRGP4 cg_forceModel+4
INDIRI4
ASGNI4
line 399
;399:		CG_ForceModelChange();
ADDRGP4 CG_ForceModelChange
CALLV
pop
line 400
;400:	}
LABELV $226
line 401
;401:}
LABELV $214
endproc CG_UpdateCvars 8 8
export CG_CrosshairPlayer
proc CG_CrosshairPlayer 0 0
line 403
;402:
;403:int CG_CrosshairPlayer( void ) {
line 404
;404:	if ( cg.time > ( cg.crosshairClientTime + 1000 ) ) {
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+124404
INDIRI4
CNSTI4 1000
ADDI4
LEI4 $231
line 405
;405:		return -1;
CNSTI4 -1
RETI4
ADDRGP4 $230
JUMPV
LABELV $231
line 407
;406:	}
;407:	return cg.crosshairClientNum;
ADDRGP4 cg+124400
INDIRI4
RETI4
LABELV $230
endproc CG_CrosshairPlayer 0 0
export CG_LastAttacker
proc CG_LastAttacker 0 0
line 410
;408:}
;409:
;410:int CG_LastAttacker( void ) {
line 411
;411:	if ( !cg.attackerTime ) {
ADDRGP4 cg+124416
INDIRI4
CNSTI4 0
NEI4 $237
line 412
;412:		return -1;
CNSTI4 -1
RETI4
ADDRGP4 $236
JUMPV
LABELV $237
line 414
;413:	}
;414:	return cg.snap->ps.persistant[PERS_ATTACKER];
ADDRGP4 cg+36
INDIRP4
CNSTI4 316
ADDP4
INDIRI4
RETI4
LABELV $236
endproc CG_LastAttacker 0 0
export CG_Printf
proc CG_Printf 1028 12
line 417
;415:}
;416:
;417:void QDECL CG_Printf( const char *msg, ... ) {
line 421
;418:	va_list		argptr;
;419:	char		text[1024];
;420:
;421:	va_start (argptr, msg);
ADDRLP4 0
ADDRFP4 0+4
ASGNP4
line 422
;422:	vsprintf (text, msg, argptr);
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 vsprintf
CALLI4
pop
line 423
;423:	va_end (argptr);
ADDRLP4 0
CNSTP4 0
ASGNP4
line 425
;424:
;425:	trap_Print( text );
ADDRLP4 4
ARGP4
ADDRGP4 trap_Print
CALLV
pop
line 426
;426:}
LABELV $241
endproc CG_Printf 1028 12
export CG_Error
proc CG_Error 1028 12
line 428
;427:
;428:void QDECL CG_Error( const char *msg, ... ) {
line 432
;429:	va_list		argptr;
;430:	char		text[1024];
;431:
;432:	va_start (argptr, msg);
ADDRLP4 0
ADDRFP4 0+4
ASGNP4
line 433
;433:	vsprintf (text, msg, argptr);
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 vsprintf
CALLI4
pop
line 434
;434:	va_end (argptr);
ADDRLP4 0
CNSTP4 0
ASGNP4
line 436
;435:
;436:	trap_Error( text );
ADDRLP4 4
ARGP4
ADDRGP4 trap_Error
CALLV
pop
line 437
;437:}
LABELV $243
endproc CG_Error 1028 12
export Com_Error
proc Com_Error 1028 12
line 442
;438:
;439:#ifndef CGAME_HARD_LINKED
;440:// this is only here so the functions in q_shared.c and bg_*.c can link (FIXME)
;441:
;442:void QDECL Com_Error( int level, const char *error, ... ) {
line 446
;443:	va_list		argptr;
;444:	char		text[1024];
;445:
;446:	va_start (argptr, error);
ADDRLP4 0
ADDRFP4 4+4
ASGNP4
line 447
;447:	vsprintf (text, error, argptr);
ADDRLP4 4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 vsprintf
CALLI4
pop
line 448
;448:	va_end (argptr);
ADDRLP4 0
CNSTP4 0
ASGNP4
line 450
;449:
;450:	CG_Error( "%s", text);
ADDRGP4 $247
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 451
;451:}
LABELV $245
endproc Com_Error 1028 12
export Com_Printf
proc Com_Printf 1028 12
line 453
;452:
;453:void QDECL Com_Printf( const char *msg, ... ) {
line 457
;454:	va_list		argptr;
;455:	char		text[1024];
;456:
;457:	va_start (argptr, msg);
ADDRLP4 0
ADDRFP4 0+4
ASGNP4
line 458
;458:	vsprintf (text, msg, argptr);
ADDRLP4 4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 vsprintf
CALLI4
pop
line 459
;459:	va_end (argptr);
ADDRLP4 0
CNSTP4 0
ASGNP4
line 461
;460:
;461:	CG_Printf ("%s", text);
ADDRGP4 $247
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 CG_Printf
CALLV
pop
line 462
;462:}
LABELV $248
endproc Com_Printf 1028 12
bss
align 1
LABELV $251
skip 1024
export CG_Argv
code
proc CG_Argv 0 12
line 471
;463:
;464:#endif
;465:
;466:/*
;467:================
;468:CG_Argv
;469:================
;470:*/
;471:const char *CG_Argv( int arg ) {
line 474
;472:	static char	buffer[MAX_STRING_CHARS];
;473:
;474:	trap_Argv( arg, buffer, sizeof( buffer ) );
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 $251
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Argv
CALLV
pop
line 476
;475:
;476:	return buffer;
ADDRGP4 $251
RETP4
LABELV $250
endproc CG_Argv 0 12
proc CG_RegisterItemSounds 96 12
line 489
;477:}
;478:
;479:
;480://========================================================================
;481:
;482:/*
;483:=================
;484:CG_RegisterItemSounds
;485:
;486:The server says this item is used on this level
;487:=================
;488:*/
;489:static void CG_RegisterItemSounds( int itemNum ) {
line 495
;490:	gitem_t			*item;
;491:	char			data[MAX_QPATH];
;492:	char			*s, *start;
;493:	int				len;
;494:
;495:	item = &bg_itemlist[ itemNum ];
ADDRLP4 76
CNSTI4 52
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 bg_itemlist
ADDP4
ASGNP4
line 497
;496:
;497:	if( item->pickup_sound ) {
ADDRLP4 76
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $253
line 498
;498:		trap_S_RegisterSound( item->pickup_sound, qfalse );
ADDRLP4 76
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_S_RegisterSound
CALLI4
pop
line 499
;499:	}
LABELV $253
line 502
;500:
;501:	// parse the space seperated precache string for other media
;502:	s = item->sounds;
ADDRLP4 0
ADDRLP4 76
INDIRP4
CNSTI4 48
ADDP4
INDIRP4
ASGNP4
line 503
;503:	if (!s || !s[0])
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $257
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $259
LABELV $257
line 504
;504:		return;
ADDRGP4 $252
JUMPV
LABELV $258
line 506
;505:
;506:	while (*s) {
line 507
;507:		start = s;
ADDRLP4 72
ADDRLP4 0
INDIRP4
ASGNP4
ADDRGP4 $262
JUMPV
LABELV $261
line 508
;508:		while (*s && *s != ' ') {
line 509
;509:			s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 510
;510:		}
LABELV $262
line 508
ADDRLP4 84
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 84
INDIRI4
CNSTI4 0
EQI4 $264
ADDRLP4 84
INDIRI4
CNSTI4 32
NEI4 $261
LABELV $264
line 512
;511:
;512:		len = s-start;
ADDRLP4 4
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 72
INDIRP4
CVPU4 4
SUBU4
CVUI4 4
ASGNI4
line 513
;513:		if (len >= MAX_QPATH || len < 5) {
ADDRLP4 4
INDIRI4
CNSTI4 64
GEI4 $267
ADDRLP4 4
INDIRI4
CNSTI4 5
GEI4 $265
LABELV $267
line 514
;514:			CG_Error( "PrecacheItem: %s has bad precache string", 
ADDRGP4 $268
ARGP4
ADDRLP4 76
INDIRP4
INDIRP4
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 516
;515:				item->classname);
;516:			return;
ADDRGP4 $252
JUMPV
LABELV $265
line 518
;517:		}
;518:		memcpy (data, start, len);
ADDRLP4 8
ARGP4
ADDRLP4 72
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 519
;519:		data[len] = 0;
ADDRLP4 4
INDIRI4
ADDRLP4 8
ADDP4
CNSTI1 0
ASGNI1
line 520
;520:		if ( *s ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $269
line 521
;521:			s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 522
;522:		}
LABELV $269
line 524
;523:
;524:		if ( !strcmp(data+len-3, "wav" )) {
ADDRLP4 4
INDIRI4
ADDRLP4 8-3
ADDP4
ARGP4
ADDRGP4 $274
ARGP4
ADDRLP4 92
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 92
INDIRI4
CNSTI4 0
NEI4 $271
line 525
;525:			trap_S_RegisterSound( data, qfalse );
ADDRLP4 8
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_S_RegisterSound
CALLI4
pop
line 526
;526:		}
LABELV $271
line 527
;527:	}
LABELV $259
line 506
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $258
line 528
;528:}
LABELV $252
endproc CG_RegisterItemSounds 96 12
proc CG_RegisterSounds 548 16
line 538
;529:
;530:
;531:/*
;532:=================
;533:CG_RegisterSounds
;534:
;535:called during a precache command
;536:=================
;537:*/
;538:static void CG_RegisterSounds( void ) {
line 549
;539:	int		i;
;540:	char	items[MAX_ITEMS+1];
;541:	char	name[MAX_QPATH];
;542:	const char	*soundName;
;543:
;544:	// voice commands
;545:#ifdef MISSIONPACK
;546:	CG_LoadVoiceChats();
;547:#endif
;548:
;549:	cgs.media.oneMinuteSound = trap_S_RegisterSound( "sound/feedback/1_minute.wav", qtrue );
ADDRGP4 $278
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 332
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+744
ADDRLP4 332
INDIRI4
ASGNI4
line 550
;550:	cgs.media.fiveMinuteSound = trap_S_RegisterSound( "sound/feedback/5_minute.wav", qtrue );
ADDRGP4 $281
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 336
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+748
ADDRLP4 336
INDIRI4
ASGNI4
line 551
;551:	cgs.media.suddenDeathSound = trap_S_RegisterSound( "sound/feedback/sudden_death.wav", qtrue );
ADDRGP4 $284
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 340
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+752
ADDRLP4 340
INDIRI4
ASGNI4
line 552
;552:	cgs.media.oneFragSound = trap_S_RegisterSound( "sound/feedback/1_frag.wav", qtrue );
ADDRGP4 $287
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 344
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+764
ADDRLP4 344
INDIRI4
ASGNI4
line 553
;553:	cgs.media.twoFragSound = trap_S_RegisterSound( "sound/feedback/2_frags.wav", qtrue );
ADDRGP4 $290
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 348
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+760
ADDRLP4 348
INDIRI4
ASGNI4
line 554
;554:	cgs.media.threeFragSound = trap_S_RegisterSound( "sound/feedback/3_frags.wav", qtrue );
ADDRGP4 $293
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 352
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+756
ADDRLP4 352
INDIRI4
ASGNI4
line 555
;555:	cgs.media.count3Sound = trap_S_RegisterSound( "sound/feedback/three.wav", qtrue );
ADDRGP4 $296
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 356
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+956
ADDRLP4 356
INDIRI4
ASGNI4
line 556
;556:	cgs.media.count2Sound = trap_S_RegisterSound( "sound/feedback/two.wav", qtrue );
ADDRGP4 $299
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 360
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+960
ADDRLP4 360
INDIRI4
ASGNI4
line 557
;557:	cgs.media.count1Sound = trap_S_RegisterSound( "sound/feedback/one.wav", qtrue );
ADDRGP4 $302
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 364
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+964
ADDRLP4 364
INDIRI4
ASGNI4
line 558
;558:	cgs.media.countFightSound = trap_S_RegisterSound( "sound/feedback/fight.wav", qtrue );
ADDRGP4 $305
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 368
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+968
ADDRLP4 368
INDIRI4
ASGNI4
line 559
;559:	cgs.media.countPrepareSound = trap_S_RegisterSound( "sound/feedback/prepare.wav", qtrue );
ADDRGP4 $308
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 372
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+972
ADDRLP4 372
INDIRI4
ASGNI4
line 564
;560:#ifdef MISSIONPACK
;561:	cgs.media.countPrepareTeamSound = trap_S_RegisterSound( "sound/feedback/prepare_team.wav", qtrue );
;562:#endif
;563:
;564:	if ( cgs.gametype >= GT_TEAM || cg_buildScript.integer ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
GEI4 $313
ADDRGP4 cg_buildScript+12
INDIRI4
CNSTI4 0
EQI4 $309
LABELV $313
line 566
;565:
;566:		cgs.media.captureAwardSound = trap_S_RegisterSound( "sound/teamplay/flagcapture_yourteam.wav", qtrue );
ADDRGP4 $316
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 376
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+868
ADDRLP4 376
INDIRI4
ASGNI4
line 567
;567:		cgs.media.redLeadsSound = trap_S_RegisterSound( "sound/feedback/redleads.wav", qtrue );
ADDRGP4 $319
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 380
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+880
ADDRLP4 380
INDIRI4
ASGNI4
line 568
;568:		cgs.media.blueLeadsSound = trap_S_RegisterSound( "sound/feedback/blueleads.wav", qtrue );
ADDRGP4 $322
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 384
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+884
ADDRLP4 384
INDIRI4
ASGNI4
line 569
;569:		cgs.media.teamsTiedSound = trap_S_RegisterSound( "sound/feedback/teamstied.wav", qtrue );
ADDRGP4 $325
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 388
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+888
ADDRLP4 388
INDIRI4
ASGNI4
line 570
;570:		cgs.media.hitTeamSound = trap_S_RegisterSound( "sound/feedback/hit_teammate.wav", qtrue );
ADDRGP4 $328
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 392
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+780
ADDRLP4 392
INDIRI4
ASGNI4
line 572
;571:
;572:		cgs.media.redScoredSound = trap_S_RegisterSound( "sound/teamplay/voc_red_scores.wav", qtrue );
ADDRGP4 $331
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 396
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+872
ADDRLP4 396
INDIRI4
ASGNI4
line 573
;573:		cgs.media.blueScoredSound = trap_S_RegisterSound( "sound/teamplay/voc_blue_scores.wav", qtrue );
ADDRGP4 $334
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 400
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+876
ADDRLP4 400
INDIRI4
ASGNI4
line 575
;574:
;575:		cgs.media.captureYourTeamSound = trap_S_RegisterSound( "sound/teamplay/flagcapture_yourteam.wav", qtrue );
ADDRGP4 $316
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 404
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+892
ADDRLP4 404
INDIRI4
ASGNI4
line 576
;576:		cgs.media.captureOpponentSound = trap_S_RegisterSound( "sound/teamplay/flagcapture_opponent.wav", qtrue );
ADDRGP4 $339
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 408
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+896
ADDRLP4 408
INDIRI4
ASGNI4
line 578
;577:
;578:		cgs.media.returnYourTeamSound = trap_S_RegisterSound( "sound/teamplay/flagreturn_yourteam.wav", qtrue );
ADDRGP4 $342
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 412
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+900
ADDRLP4 412
INDIRI4
ASGNI4
line 579
;579:		cgs.media.returnOpponentSound = trap_S_RegisterSound( "sound/teamplay/flagreturn_opponent.wav", qtrue );
ADDRGP4 $345
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 416
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+904
ADDRLP4 416
INDIRI4
ASGNI4
line 581
;580:
;581:		cgs.media.takenYourTeamSound = trap_S_RegisterSound( "sound/teamplay/flagtaken_yourteam.wav", qtrue );
ADDRGP4 $348
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 420
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+908
ADDRLP4 420
INDIRI4
ASGNI4
line 582
;582:		cgs.media.takenOpponentSound = trap_S_RegisterSound( "sound/teamplay/flagtaken_opponent.wav", qtrue );
ADDRGP4 $351
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 424
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+912
ADDRLP4 424
INDIRI4
ASGNI4
line 584
;583:
;584:		if ( cgs.gametype == GT_CTF || cg_buildScript.integer ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 4
EQI4 $356
ADDRGP4 cg_buildScript+12
INDIRI4
CNSTI4 0
EQI4 $352
LABELV $356
line 585
;585:			cgs.media.redFlagReturnedSound = trap_S_RegisterSound( "sound/teamplay/voc_red_returned.wav", qtrue );
ADDRGP4 $359
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 428
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+916
ADDRLP4 428
INDIRI4
ASGNI4
line 586
;586:			cgs.media.blueFlagReturnedSound = trap_S_RegisterSound( "sound/teamplay/voc_blue_returned.wav", qtrue );
ADDRGP4 $362
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 432
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+920
ADDRLP4 432
INDIRI4
ASGNI4
line 587
;587:			cgs.media.enemyTookYourFlagSound = trap_S_RegisterSound( "sound/teamplay/voc_enemy_flag.wav", qtrue );
ADDRGP4 $365
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 436
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+928
ADDRLP4 436
INDIRI4
ASGNI4
line 588
;588:			cgs.media.yourTeamTookEnemyFlagSound = trap_S_RegisterSound( "sound/teamplay/voc_team_flag.wav", qtrue );
ADDRGP4 $368
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 440
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+936
ADDRLP4 440
INDIRI4
ASGNI4
line 589
;589:		}
LABELV $352
line 608
;590:
;591:#ifdef MISSIONPACK
;592:		if ( cgs.gametype == GT_1FCTF || cg_buildScript.integer ) {
;593:			// FIXME: get a replacement for this sound ?
;594:			cgs.media.neutralFlagReturnedSound = trap_S_RegisterSound( "sound/teamplay/flagreturn_opponent.wav", qtrue );
;595:			cgs.media.yourTeamTookTheFlagSound = trap_S_RegisterSound( "sound/teamplay/voc_team_1flag.wav", qtrue );
;596:			cgs.media.enemyTookTheFlagSound = trap_S_RegisterSound( "sound/teamplay/voc_enemy_1flag.wav", qtrue );
;597:		}
;598:
;599:		if ( cgs.gametype == GT_1FCTF || cgs.gametype == GT_CTF || cg_buildScript.integer ) {
;600:			cgs.media.youHaveFlagSound = trap_S_RegisterSound( "sound/teamplay/voc_you_flag.wav", qtrue );
;601:			cgs.media.holyShitSound = trap_S_RegisterSound("sound/feedback/voc_holyshit.wav", qtrue);
;602:		}
;603:
;604:		if ( cgs.gametype == GT_OBELISK || cg_buildScript.integer ) {
;605:			cgs.media.yourBaseIsUnderAttackSound = trap_S_RegisterSound( "sound/teamplay/voc_base_attack.wav", qtrue );
;606:		}
;607:#else
;608:		cgs.media.youHaveFlagSound = trap_S_RegisterSound( "sound/teamplay/voc_you_flag.wav", qtrue );
ADDRGP4 $371
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 428
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+944
ADDRLP4 428
INDIRI4
ASGNI4
line 609
;609:		cgs.media.holyShitSound = trap_S_RegisterSound("sound/feedback/voc_holyshit.wav", qtrue);
ADDRGP4 $374
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 432
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+952
ADDRLP4 432
INDIRI4
ASGNI4
line 610
;610:		cgs.media.neutralFlagReturnedSound = trap_S_RegisterSound( "sound/teamplay/flagreturn_opponent.wav", qtrue );
ADDRGP4 $345
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 436
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+924
ADDRLP4 436
INDIRI4
ASGNI4
line 611
;611:		cgs.media.yourTeamTookTheFlagSound = trap_S_RegisterSound( "sound/teamplay/voc_team_1flag.wav", qtrue );
ADDRGP4 $379
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 440
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+940
ADDRLP4 440
INDIRI4
ASGNI4
line 612
;612:		cgs.media.enemyTookTheFlagSound = trap_S_RegisterSound( "sound/teamplay/voc_enemy_1flag.wav", qtrue );
ADDRGP4 $382
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 444
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+932
ADDRLP4 444
INDIRI4
ASGNI4
line 614
;613:#endif
;614:	}
LABELV $309
line 616
;615:
;616:	cgs.media.tracerSound = trap_S_RegisterSound( "sound/weapons/machinegun/buletby1.wav", qfalse );
ADDRGP4 $385
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 376
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+532
ADDRLP4 376
INDIRI4
ASGNI4
line 617
;617:	cgs.media.selectSound = trap_S_RegisterSound( "sound/weapons/change.wav", qfalse );
ADDRGP4 $388
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 380
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+536
ADDRLP4 380
INDIRI4
ASGNI4
line 618
;618:	cgs.media.wearOffSound = trap_S_RegisterSound( "sound/items/wearoff.wav", qfalse );
ADDRGP4 $391
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 384
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+544
ADDRLP4 384
INDIRI4
ASGNI4
line 619
;619:	cgs.media.useNothingSound = trap_S_RegisterSound( "sound/items/use_nothing.wav", qfalse );
ADDRGP4 $394
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 388
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+540
ADDRLP4 388
INDIRI4
ASGNI4
line 620
;620:	cgs.media.gibSound = trap_S_RegisterSound( "sound/player/gibsplt1.wav", qfalse );
ADDRGP4 $397
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 392
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+696
ADDRLP4 392
INDIRI4
ASGNI4
line 621
;621:	cgs.media.gibBounce1Sound = trap_S_RegisterSound( "sound/player/gibimp1.wav", qfalse );
ADDRGP4 $400
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 396
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+700
ADDRLP4 396
INDIRI4
ASGNI4
line 622
;622:	cgs.media.gibBounce2Sound = trap_S_RegisterSound( "sound/player/gibimp2.wav", qfalse );
ADDRGP4 $403
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 400
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+704
ADDRLP4 400
INDIRI4
ASGNI4
line 623
;623:	cgs.media.gibBounce3Sound = trap_S_RegisterSound( "sound/player/gibimp3.wav", qfalse );
ADDRGP4 $406
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 404
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+708
ADDRLP4 404
INDIRI4
ASGNI4
line 642
;624:
;625:#ifdef MISSIONPACK
;626:	cgs.media.useInvulnerabilitySound = trap_S_RegisterSound( "sound/items/invul_activate.wav", qfalse );
;627:	cgs.media.invulnerabilityImpactSound1 = trap_S_RegisterSound( "sound/items/invul_impact_01.wav", qfalse );
;628:	cgs.media.invulnerabilityImpactSound2 = trap_S_RegisterSound( "sound/items/invul_impact_02.wav", qfalse );
;629:	cgs.media.invulnerabilityImpactSound3 = trap_S_RegisterSound( "sound/items/invul_impact_03.wav", qfalse );
;630:	cgs.media.invulnerabilityJuicedSound = trap_S_RegisterSound( "sound/items/invul_juiced.wav", qfalse );
;631:	cgs.media.obeliskHitSound1 = trap_S_RegisterSound( "sound/items/obelisk_hit_01.wav", qfalse );
;632:	cgs.media.obeliskHitSound2 = trap_S_RegisterSound( "sound/items/obelisk_hit_02.wav", qfalse );
;633:	cgs.media.obeliskHitSound3 = trap_S_RegisterSound( "sound/items/obelisk_hit_03.wav", qfalse );
;634:	cgs.media.obeliskRespawnSound = trap_S_RegisterSound( "sound/items/obelisk_respawn.wav", qfalse );
;635:
;636:	cgs.media.ammoregenSound = trap_S_RegisterSound("sound/items/cl_ammoregen.wav", qfalse);
;637:	cgs.media.doublerSound = trap_S_RegisterSound("sound/items/cl_doubler.wav", qfalse);
;638:	cgs.media.guardSound = trap_S_RegisterSound("sound/items/cl_guard.wav", qfalse);
;639:	cgs.media.scoutSound = trap_S_RegisterSound("sound/items/cl_scout.wav", qfalse);
;640:#endif
;641:
;642:	cgs.media.teleInSound = trap_S_RegisterSound( "sound/world/telein.wav", qfalse );
ADDRGP4 $409
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 408
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+712
ADDRLP4 408
INDIRI4
ASGNI4
line 643
;643:	cgs.media.teleOutSound = trap_S_RegisterSound( "sound/world/teleout.wav", qfalse );
ADDRGP4 $412
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 412
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+716
ADDRLP4 412
INDIRI4
ASGNI4
line 644
;644:	cgs.media.respawnSound = trap_S_RegisterSound( "sound/items/respawn1.wav", qfalse );
ADDRGP4 $415
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 416
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+724
ADDRLP4 416
INDIRI4
ASGNI4
line 646
;645:
;646:	cgs.media.noAmmoSound = trap_S_RegisterSound( "sound/weapons/noammo.wav", qfalse );
ADDRGP4 $418
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 420
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+720
ADDRLP4 420
INDIRI4
ASGNI4
line 648
;647:
;648:	cgs.media.talkSound = trap_S_RegisterSound( "sound/player/talk.wav", qfalse );
ADDRGP4 $421
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 424
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+728
ADDRLP4 424
INDIRI4
ASGNI4
line 649
;649:	cgs.media.landSound = trap_S_RegisterSound( "sound/player/land1.wav", qfalse);
ADDRGP4 $424
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 428
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+732
ADDRLP4 428
INDIRI4
ASGNI4
line 651
;650:
;651:	cgs.media.hitSound = trap_S_RegisterSound( "sound/feedback/hit.wav", qfalse );
ADDRGP4 $427
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 432
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+768
ADDRLP4 432
INDIRI4
ASGNI4
line 657
;652:#ifdef MISSIONPACK
;653:	cgs.media.hitSoundHighArmor = trap_S_RegisterSound( "sound/feedback/hithi.wav", qfalse );
;654:	cgs.media.hitSoundLowArmor = trap_S_RegisterSound( "sound/feedback/hitlo.wav", qfalse );
;655:#endif
;656:
;657:	cgs.media.impressiveSound = trap_S_RegisterSound( "sound/feedback/impressive.wav", qtrue );
ADDRGP4 $430
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 436
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+784
ADDRLP4 436
INDIRI4
ASGNI4
line 658
;658:	cgs.media.excellentSound = trap_S_RegisterSound( "sound/feedback/excellent.wav", qtrue );
ADDRGP4 $433
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 440
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+788
ADDRLP4 440
INDIRI4
ASGNI4
line 659
;659:	cgs.media.deniedSound = trap_S_RegisterSound( "sound/feedback/denied.wav", qtrue );
ADDRGP4 $436
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 444
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+792
ADDRLP4 444
INDIRI4
ASGNI4
line 660
;660:	cgs.media.humiliationSound = trap_S_RegisterSound( "sound/feedback/humiliation.wav", qtrue );
ADDRGP4 $439
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 448
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+796
ADDRLP4 448
INDIRI4
ASGNI4
line 661
;661:	cgs.media.assistSound = trap_S_RegisterSound( "sound/feedback/assist.wav", qtrue );
ADDRGP4 $442
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 452
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+800
ADDRLP4 452
INDIRI4
ASGNI4
line 662
;662:	cgs.media.defendSound = trap_S_RegisterSound( "sound/feedback/defense.wav", qtrue );
ADDRGP4 $445
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 456
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+804
ADDRLP4 456
INDIRI4
ASGNI4
line 669
;663:#ifdef MISSIONPACK
;664:	cgs.media.firstImpressiveSound = trap_S_RegisterSound( "sound/feedback/first_impressive.wav", qtrue );
;665:	cgs.media.firstExcellentSound = trap_S_RegisterSound( "sound/feedback/first_excellent.wav", qtrue );
;666:	cgs.media.firstHumiliationSound = trap_S_RegisterSound( "sound/feedback/first_gauntlet.wav", qtrue );
;667:#endif
;668:
;669:	cgs.media.takenLeadSound = trap_S_RegisterSound( "sound/feedback/takenlead.wav", qtrue);
ADDRGP4 $448
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 460
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+820
ADDRLP4 460
INDIRI4
ASGNI4
line 670
;670:	cgs.media.tiedLeadSound = trap_S_RegisterSound( "sound/feedback/tiedlead.wav", qtrue);
ADDRGP4 $451
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 464
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+824
ADDRLP4 464
INDIRI4
ASGNI4
line 671
;671:	cgs.media.lostLeadSound = trap_S_RegisterSound( "sound/feedback/lostlead.wav", qtrue);
ADDRGP4 $454
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 468
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+828
ADDRLP4 468
INDIRI4
ASGNI4
line 679
;672:
;673:#ifdef MISSIONPACK
;674:	cgs.media.voteNow = trap_S_RegisterSound( "sound/feedback/vote_now.wav", qtrue);
;675:	cgs.media.votePassed = trap_S_RegisterSound( "sound/feedback/vote_passed.wav", qtrue);
;676:	cgs.media.voteFailed = trap_S_RegisterSound( "sound/feedback/vote_failed.wav", qtrue);
;677:#endif
;678:
;679:	cgs.media.watrInSound = trap_S_RegisterSound( "sound/player/watr_in.wav", qfalse);
ADDRGP4 $457
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 472
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+844
ADDRLP4 472
INDIRI4
ASGNI4
line 680
;680:	cgs.media.watrOutSound = trap_S_RegisterSound( "sound/player/watr_out.wav", qfalse);
ADDRGP4 $460
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 476
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+848
ADDRLP4 476
INDIRI4
ASGNI4
line 681
;681:	cgs.media.watrUnSound = trap_S_RegisterSound( "sound/player/watr_un.wav", qfalse);
ADDRGP4 $463
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 480
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+852
ADDRLP4 480
INDIRI4
ASGNI4
line 683
;682:
;683:	cgs.media.jumpPadSound = trap_S_RegisterSound ("sound/world/jumppad.wav", qfalse );
ADDRGP4 $466
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 484
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+740
ADDRLP4 484
INDIRI4
ASGNI4
line 685
;684:
;685:	for (i=0 ; i<4 ; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $467
line 686
;686:		Com_sprintf (name, sizeof(name), "sound/player/footsteps/step%i.wav", i+1);
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $471
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 687
;687:		cgs.media.footsteps[FOOTSTEP_NORMAL][i] = trap_S_RegisterSound (name, qfalse);
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 488
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+152340+548
ADDP4
ADDRLP4 488
INDIRI4
ASGNI4
line 689
;688:
;689:		Com_sprintf (name, sizeof(name), "sound/player/footsteps/boot%i.wav", i+1);
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $474
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 690
;690:		cgs.media.footsteps[FOOTSTEP_BOOT][i] = trap_S_RegisterSound (name, qfalse);
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 492
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+152340+548+16
ADDP4
ADDRLP4 492
INDIRI4
ASGNI4
line 692
;691:
;692:		Com_sprintf (name, sizeof(name), "sound/player/footsteps/flesh%i.wav", i+1);
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $478
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 693
;693:		cgs.media.footsteps[FOOTSTEP_FLESH][i] = trap_S_RegisterSound (name, qfalse);
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 496
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+152340+548+32
ADDP4
ADDRLP4 496
INDIRI4
ASGNI4
line 695
;694:
;695:		Com_sprintf (name, sizeof(name), "sound/player/footsteps/mech%i.wav", i+1);
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $482
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 696
;696:		cgs.media.footsteps[FOOTSTEP_MECH][i] = trap_S_RegisterSound (name, qfalse);
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 500
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+152340+548+48
ADDP4
ADDRLP4 500
INDIRI4
ASGNI4
line 698
;697:
;698:		Com_sprintf (name, sizeof(name), "sound/player/footsteps/energy%i.wav", i+1);
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $486
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 699
;699:		cgs.media.footsteps[FOOTSTEP_ENERGY][i] = trap_S_RegisterSound (name, qfalse);
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 504
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+152340+548+64
ADDP4
ADDRLP4 504
INDIRI4
ASGNI4
line 701
;700:
;701:		Com_sprintf (name, sizeof(name), "sound/player/footsteps/splash%i.wav", i+1);
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $490
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 702
;702:		cgs.media.footsteps[FOOTSTEP_SPLASH][i] = trap_S_RegisterSound (name, qfalse);
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 508
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+152340+548+96
ADDP4
ADDRLP4 508
INDIRI4
ASGNI4
line 704
;703:
;704:		Com_sprintf (name, sizeof(name), "sound/player/footsteps/clank%i.wav", i+1);
ADDRLP4 4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $494
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 705
;705:		cgs.media.footsteps[FOOTSTEP_METAL][i] = trap_S_RegisterSound (name, qfalse);
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 512
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+152340+548+80
ADDP4
ADDRLP4 512
INDIRI4
ASGNI4
line 706
;706:	}
LABELV $468
line 685
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $467
line 709
;707:
;708:	// only register the items that the server says we need
;709:	strcpy( items, CG_ConfigString( CS_ITEMS ) );
CNSTI4 27
ARGI4
ADDRLP4 488
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 72
ARGP4
ADDRLP4 488
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 711
;710:
;711:	for ( i = 1 ; i < bg_numItems ; i++ ) {
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $501
JUMPV
LABELV $498
line 713
;712://		if ( items[ i ] == '1' || cg_buildScript.integer ) {
;713:			CG_RegisterItemSounds( i );
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_RegisterItemSounds
CALLV
pop
line 715
;714://		}
;715:	}
LABELV $499
line 711
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $501
ADDRLP4 0
INDIRI4
ADDRGP4 bg_numItems
INDIRI4
LTI4 $498
line 717
;716:
;717:	for ( i = 1 ; i < MAX_SOUNDS ; i++ ) {
ADDRLP4 0
CNSTI4 1
ASGNI4
LABELV $502
line 718
;718:		soundName = CG_ConfigString( CS_SOUNDS+i );
ADDRLP4 0
INDIRI4
CNSTI4 288
ADDI4
ARGI4
ADDRLP4 492
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 68
ADDRLP4 492
INDIRP4
ASGNP4
line 719
;719:		if ( !soundName[0] ) {
ADDRLP4 68
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $506
line 720
;720:			break;
ADDRGP4 $504
JUMPV
LABELV $506
line 722
;721:		}
;722:		if ( soundName[0] == '*' ) {
ADDRLP4 68
INDIRP4
INDIRI1
CVII4 1
CNSTI4 42
NEI4 $508
line 723
;723:			continue;	// custom sound
ADDRGP4 $503
JUMPV
LABELV $508
line 725
;724:		}
;725:		cgs.gameSounds[i] = trap_S_RegisterSound( soundName, qfalse );
ADDRLP4 68
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 496
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+35848
ADDP4
ADDRLP4 496
INDIRI4
ASGNI4
line 726
;726:	}
LABELV $503
line 717
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 256
LTI4 $502
LABELV $504
line 729
;727:
;728:	// FIXME: only needed with item
;729:	cgs.media.flightSound = trap_S_RegisterSound( "sound/items/flight.wav", qfalse );
ADDRGP4 $513
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 492
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+856
ADDRLP4 492
INDIRI4
ASGNI4
line 730
;730:	cgs.media.medkitSound = trap_S_RegisterSound ("sound/items/use_medkit.wav", qfalse);
ADDRGP4 $516
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 496
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+860
ADDRLP4 496
INDIRI4
ASGNI4
line 731
;731:	cgs.media.quadSound = trap_S_RegisterSound("sound/items/damage3.wav", qfalse);
ADDRGP4 $519
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 500
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+528
ADDRLP4 500
INDIRI4
ASGNI4
line 732
;732:	cgs.media.sfx_ric1 = trap_S_RegisterSound ("sound/weapons/machinegun/ric1.wav", qfalse);
ADDRGP4 $522
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 504
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+672
ADDRLP4 504
INDIRI4
ASGNI4
line 733
;733:	cgs.media.sfx_ric2 = trap_S_RegisterSound ("sound/weapons/machinegun/ric2.wav", qfalse);
ADDRGP4 $525
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 508
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+676
ADDRLP4 508
INDIRI4
ASGNI4
line 734
;734:	cgs.media.sfx_ric3 = trap_S_RegisterSound ("sound/weapons/machinegun/ric3.wav", qfalse);
ADDRGP4 $528
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 512
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+680
ADDRLP4 512
INDIRI4
ASGNI4
line 735
;735:	cgs.media.sfx_railg = trap_S_RegisterSound ("sound/weapons/railgun/railgf1a.wav", qfalse);
ADDRGP4 $531
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 516
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+684
ADDRLP4 516
INDIRI4
ASGNI4
line 736
;736:	cgs.media.sfx_rockexp = trap_S_RegisterSound ("sound/weapons/rocket/rocklx1a.wav", qfalse);
ADDRGP4 $534
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 520
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+688
ADDRLP4 520
INDIRI4
ASGNI4
line 737
;737:	cgs.media.sfx_plasmaexp = trap_S_RegisterSound ("sound/weapons/plasma/plasmx1a.wav", qfalse);
ADDRGP4 $537
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 524
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+692
ADDRLP4 524
INDIRI4
ASGNI4
line 760
;738:#ifdef MISSIONPACK
;739:	cgs.media.sfx_proxexp = trap_S_RegisterSound( "sound/weapons/proxmine/wstbexpl.wav" , qfalse);
;740:	cgs.media.sfx_nghit = trap_S_RegisterSound( "sound/weapons/nailgun/wnalimpd.wav" , qfalse);
;741:	cgs.media.sfx_nghitflesh = trap_S_RegisterSound( "sound/weapons/nailgun/wnalimpl.wav" , qfalse);
;742:	cgs.media.sfx_nghitmetal = trap_S_RegisterSound( "sound/weapons/nailgun/wnalimpm.wav", qfalse );
;743:	cgs.media.sfx_chghit = trap_S_RegisterSound( "sound/weapons/vulcan/wvulimpd.wav", qfalse );
;744:	cgs.media.sfx_chghitflesh = trap_S_RegisterSound( "sound/weapons/vulcan/wvulimpl.wav", qfalse );
;745:	cgs.media.sfx_chghitmetal = trap_S_RegisterSound( "sound/weapons/vulcan/wvulimpm.wav", qfalse );
;746:	cgs.media.weaponHoverSound = trap_S_RegisterSound( "sound/weapons/weapon_hover.wav", qfalse );
;747:	cgs.media.kamikazeExplodeSound = trap_S_RegisterSound( "sound/items/kam_explode.wav", qfalse );
;748:	cgs.media.kamikazeImplodeSound = trap_S_RegisterSound( "sound/items/kam_implode.wav", qfalse );
;749:	cgs.media.kamikazeFarSound = trap_S_RegisterSound( "sound/items/kam_explode_far.wav", qfalse );
;750:	cgs.media.winnerSound = trap_S_RegisterSound( "sound/feedback/voc_youwin.wav", qfalse );
;751:	cgs.media.loserSound = trap_S_RegisterSound( "sound/feedback/voc_youlose.wav", qfalse );
;752:	cgs.media.youSuckSound = trap_S_RegisterSound( "sound/misc/yousuck.wav", qfalse );
;753:
;754:	cgs.media.wstbimplSound = trap_S_RegisterSound("sound/weapons/proxmine/wstbimpl.wav", qfalse);
;755:	cgs.media.wstbimpmSound = trap_S_RegisterSound("sound/weapons/proxmine/wstbimpm.wav", qfalse);
;756:	cgs.media.wstbimpdSound = trap_S_RegisterSound("sound/weapons/proxmine/wstbimpd.wav", qfalse);
;757:	cgs.media.wstbactvSound = trap_S_RegisterSound("sound/weapons/proxmine/wstbactv.wav", qfalse);
;758:#endif
;759:
;760:	cgs.media.regenSound = trap_S_RegisterSound("sound/items/regen.wav", qfalse);
ADDRGP4 $540
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 528
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+988
ADDRLP4 528
INDIRI4
ASGNI4
line 761
;761:	cgs.media.protectSound = trap_S_RegisterSound("sound/items/protect3.wav", qfalse);
ADDRGP4 $543
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 532
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+992
ADDRLP4 532
INDIRI4
ASGNI4
line 762
;762:	cgs.media.n_healthSound = trap_S_RegisterSound("sound/items/n_health.wav", qfalse );
ADDRGP4 $546
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 536
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+996
ADDRLP4 536
INDIRI4
ASGNI4
line 763
;763:	cgs.media.hgrenb1aSound = trap_S_RegisterSound("sound/weapons/grenade/hgrenb1a.wav", qfalse);
ADDRGP4 $549
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 540
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+1000
ADDRLP4 540
INDIRI4
ASGNI4
line 764
;764:	cgs.media.hgrenb2aSound = trap_S_RegisterSound("sound/weapons/grenade/hgrenb2a.wav", qfalse);
ADDRGP4 $552
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 544
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 cgs+152340+1004
ADDRLP4 544
INDIRI4
ASGNI4
line 794
;765:
;766:#ifdef MISSIONPACK
;767:	trap_S_RegisterSound("sound/player/james/death1.wav", qfalse );
;768:	trap_S_RegisterSound("sound/player/james/death2.wav", qfalse );
;769:	trap_S_RegisterSound("sound/player/james/death3.wav", qfalse );
;770:	trap_S_RegisterSound("sound/player/james/jump1.wav", qfalse );
;771:	trap_S_RegisterSound("sound/player/james/pain25_1.wav", qfalse );
;772:	trap_S_RegisterSound("sound/player/james/pain75_1.wav", qfalse );
;773:	trap_S_RegisterSound("sound/player/james/pain100_1.wav", qfalse );
;774:	trap_S_RegisterSound("sound/player/james/falling1.wav", qfalse );
;775:	trap_S_RegisterSound("sound/player/james/gasp.wav", qfalse );
;776:	trap_S_RegisterSound("sound/player/james/drown.wav", qfalse );
;777:	trap_S_RegisterSound("sound/player/james/fall1.wav", qfalse );
;778:	trap_S_RegisterSound("sound/player/james/taunt.wav", qfalse );
;779:
;780:	trap_S_RegisterSound("sound/player/janet/death1.wav", qfalse );
;781:	trap_S_RegisterSound("sound/player/janet/death2.wav", qfalse );
;782:	trap_S_RegisterSound("sound/player/janet/death3.wav", qfalse );
;783:	trap_S_RegisterSound("sound/player/janet/jump1.wav", qfalse );
;784:	trap_S_RegisterSound("sound/player/janet/pain25_1.wav", qfalse );
;785:	trap_S_RegisterSound("sound/player/janet/pain75_1.wav", qfalse );
;786:	trap_S_RegisterSound("sound/player/janet/pain100_1.wav", qfalse );
;787:	trap_S_RegisterSound("sound/player/janet/falling1.wav", qfalse );
;788:	trap_S_RegisterSound("sound/player/janet/gasp.wav", qfalse );
;789:	trap_S_RegisterSound("sound/player/janet/drown.wav", qfalse );
;790:	trap_S_RegisterSound("sound/player/janet/fall1.wav", qfalse );
;791:	trap_S_RegisterSound("sound/player/janet/taunt.wav", qfalse );
;792:#endif
;793:
;794:}
LABELV $275
endproc CG_RegisterSounds 548 16
data
align 4
LABELV $554
address $555
address $556
address $557
address $558
address $559
address $560
address $561
address $562
address $563
address $564
address $565
code
proc CG_RegisterGraphics 588 16
line 807
;795:
;796:
;797://===================================================================================
;798:
;799:
;800:/*
;801:=================
;802:CG_RegisterGraphics
;803:
;804:This function may execute for a couple of minutes with a slow disk.
;805:=================
;806:*/
;807:static void CG_RegisterGraphics( void ) {
line 825
;808:	int			i;
;809:	char		items[MAX_ITEMS+1];
;810:	static char		*sb_nums[11] = {
;811:		"gfx/2d/numbers/zero_32b",
;812:		"gfx/2d/numbers/one_32b",
;813:		"gfx/2d/numbers/two_32b",
;814:		"gfx/2d/numbers/three_32b",
;815:		"gfx/2d/numbers/four_32b",
;816:		"gfx/2d/numbers/five_32b",
;817:		"gfx/2d/numbers/six_32b",
;818:		"gfx/2d/numbers/seven_32b",
;819:		"gfx/2d/numbers/eight_32b",
;820:		"gfx/2d/numbers/nine_32b",
;821:		"gfx/2d/numbers/minus_32b",
;822:	};
;823:
;824:	// clear any references to old media
;825:	memset( &cg.refdef, 0, sizeof( cg.refdef ) );
ADDRGP4 cg+109044
ARGP4
CNSTI4 0
ARGI4
CNSTI4 368
ARGI4
ADDRGP4 memset
CALLP4
pop
line 826
;826:	trap_R_ClearScene();
ADDRGP4 trap_R_ClearScene
CALLV
pop
line 828
;827:
;828:	CG_LoadingString( cgs.mapname );
ADDRGP4 cgs+31484
ARGP4
ADDRGP4 CG_LoadingString
CALLV
pop
line 830
;829:
;830:	trap_R_LoadWorldMap( cgs.mapname );
ADDRGP4 cgs+31484
ARGP4
ADDRGP4 trap_R_LoadWorldMap
CALLV
pop
line 833
;831:
;832:	// precache status bar pics
;833:	CG_LoadingString( "game media" );
ADDRGP4 $570
ARGP4
ADDRGP4 CG_LoadingString
CALLV
pop
line 835
;834:
;835:	for ( i=0 ; i<11 ; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $571
line 836
;836:		cgs.media.numberShaders[i] = trap_R_RegisterShader( sb_nums[i] );
ADDRLP4 264
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 264
INDIRI4
ADDRGP4 $554
ADDP4
INDIRP4
ARGP4
ADDRLP4 268
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 264
INDIRI4
ADDRGP4 cgs+152340+300
ADDP4
ADDRLP4 268
INDIRI4
ASGNI4
line 837
;837:	}
LABELV $572
line 835
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 11
LTI4 $571
line 839
;838:
;839:	cgs.media.botSkillShaders[0] = trap_R_RegisterShader( "menu/art/skill1.tga" );
ADDRGP4 $579
ARGP4
ADDRLP4 264
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+152340+348
ADDRLP4 264
INDIRI4
ASGNI4
line 840
;840:	cgs.media.botSkillShaders[1] = trap_R_RegisterShader( "menu/art/skill2.tga" );
ADDRGP4 $583
ARGP4
ADDRLP4 268
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+152340+348+4
ADDRLP4 268
INDIRI4
ASGNI4
line 841
;841:	cgs.media.botSkillShaders[2] = trap_R_RegisterShader( "menu/art/skill3.tga" );
ADDRGP4 $587
ARGP4
ADDRLP4 272
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+152340+348+8
ADDRLP4 272
INDIRI4
ASGNI4
line 842
;842:	cgs.media.botSkillShaders[3] = trap_R_RegisterShader( "menu/art/skill4.tga" );
ADDRGP4 $591
ARGP4
ADDRLP4 276
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+152340+348+12
ADDRLP4 276
INDIRI4
ASGNI4
line 843
;843:	cgs.media.botSkillShaders[4] = trap_R_RegisterShader( "menu/art/skill5.tga" );
ADDRGP4 $595
ARGP4
ADDRLP4 280
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+152340+348+16
ADDRLP4 280
INDIRI4
ASGNI4
line 845
;844:
;845:	cgs.media.viewBloodShader = trap_R_RegisterShader( "viewBloodBlend" );
ADDRGP4 $598
ARGP4
ADDRLP4 284
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+152340+216
ADDRLP4 284
INDIRI4
ASGNI4
line 847
;846:
;847:	cgs.media.deferShader = trap_R_RegisterShaderNoMip( "gfx/2d/defer.tga" );
ADDRGP4 $601
ARGP4
ADDRLP4 288
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+152340+132
ADDRLP4 288
INDIRI4
ASGNI4
line 849
;848:
;849:	cgs.media.scoreboardName = trap_R_RegisterShaderNoMip( "menu/tab/name.tga" );
ADDRGP4 $604
ARGP4
ADDRLP4 292
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+152340+488
ADDRLP4 292
INDIRI4
ASGNI4
line 850
;850:	cgs.media.scoreboardPing = trap_R_RegisterShaderNoMip( "menu/tab/ping.tga" );
ADDRGP4 $607
ARGP4
ADDRLP4 296
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+152340+492
ADDRLP4 296
INDIRI4
ASGNI4
line 851
;851:	cgs.media.scoreboardScore = trap_R_RegisterShaderNoMip( "menu/tab/score.tga" );
ADDRGP4 $610
ARGP4
ADDRLP4 300
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+152340+496
ADDRLP4 300
INDIRI4
ASGNI4
line 852
;852:	cgs.media.scoreboardTime = trap_R_RegisterShaderNoMip( "menu/tab/time.tga" );
ADDRGP4 $613
ARGP4
ADDRLP4 304
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+152340+500
ADDRLP4 304
INDIRI4
ASGNI4
line 854
;853:
;854:	cgs.media.smokePuffShader = trap_R_RegisterShader( "smokePuff" );
ADDRGP4 $616
ARGP4
ADDRLP4 308
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+152340+276
ADDRLP4 308
INDIRI4
ASGNI4
line 855
;855:	cgs.media.smokePuffRageProShader = trap_R_RegisterShader( "smokePuffRagePro" );
ADDRGP4 $619
ARGP4
ADDRLP4 312
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+152340+280
ADDRLP4 312
INDIRI4
ASGNI4
line 856
;856:	cgs.media.shotgunSmokePuffShader = trap_R_RegisterShader( "shotgunSmokePuff" );
ADDRGP4 $622
ARGP4
ADDRLP4 316
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+152340+284
ADDRLP4 316
INDIRI4
ASGNI4
line 861
;857:#ifdef MISSIONPACK
;858:	cgs.media.nailPuffShader = trap_R_RegisterShader( "nailtrail" );
;859:	cgs.media.blueProxMine = trap_R_RegisterModel( "models/weaphits/proxmineb.md3" );
;860:#endif
;861:	cgs.media.plasmaBallShader = trap_R_RegisterShader( "sprites/plasma1" );
ADDRGP4 $625
ARGP4
ADDRLP4 320
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+152340+288
ADDRLP4 320
INDIRI4
ASGNI4
line 862
;862:	cgs.media.bloodTrailShader = trap_R_RegisterShader( "bloodTrail" );
ADDRGP4 $628
ARGP4
ADDRLP4 324
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+152340+296
ADDRLP4 324
INDIRI4
ASGNI4
line 863
;863:	cgs.media.lagometerShader = trap_R_RegisterShader("lagometer" );
ADDRGP4 $631
ARGP4
ADDRLP4 328
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+152340+264
ADDRLP4 328
INDIRI4
ASGNI4
line 864
;864:	cgs.media.connectionShader = trap_R_RegisterShader( "disconnected" );
ADDRGP4 $634
ARGP4
ADDRLP4 332
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+152340+208
ADDRLP4 332
INDIRI4
ASGNI4
line 866
;865:
;866:	cgs.media.waterBubbleShader = trap_R_RegisterShader( "waterBubble" );
ADDRGP4 $637
ARGP4
ADDRLP4 336
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+152340+292
ADDRLP4 336
INDIRI4
ASGNI4
line 868
;867:
;868:	cgs.media.tracerShader = trap_R_RegisterShader( "gfx/misc/tracer" );
ADDRGP4 $640
ARGP4
ADDRLP4 340
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+152340+220
ADDRLP4 340
INDIRI4
ASGNI4
line 869
;869:	cgs.media.selectShader = trap_R_RegisterShader( "gfx/2d/select" );
ADDRGP4 $643
ARGP4
ADDRLP4 344
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+152340+212
ADDRLP4 344
INDIRI4
ASGNI4
line 871
;870:
;871:	for ( i = 0 ; i < NUM_CROSSHAIRS ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $644
line 872
;872:		cgs.media.crosshairShader[i] = trap_R_RegisterShader( va("gfx/2d/crosshair%c", 'a'+i) );
ADDRGP4 $650
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 97
ADDI4
ARGI4
ADDRLP4 352
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 352
INDIRP4
ARGP4
ADDRLP4 356
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+152340+224
ADDP4
ADDRLP4 356
INDIRI4
ASGNI4
line 873
;873:	}
LABELV $645
line 871
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 10
LTI4 $644
line 875
;874:
;875:	cgs.media.backTileShader = trap_R_RegisterShader( "gfx/2d/backtile" );
ADDRGP4 $653
ARGP4
ADDRLP4 348
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+152340+268
ADDRLP4 348
INDIRI4
ASGNI4
line 876
;876:	cgs.media.noammoShader = trap_R_RegisterShader( "icons/noammo" );
ADDRGP4 $656
ARGP4
ADDRLP4 352
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+152340+272
ADDRLP4 352
INDIRI4
ASGNI4
line 879
;877:
;878:	// powerup shaders
;879:	cgs.media.quadShader = trap_R_RegisterShader("powerups/quad" );
ADDRGP4 $659
ARGP4
ADDRLP4 356
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+152340+392
ADDRLP4 356
INDIRI4
ASGNI4
line 880
;880:	cgs.media.quadWeaponShader = trap_R_RegisterShader("powerups/quadWeapon" );
ADDRGP4 $662
ARGP4
ADDRLP4 360
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+152340+400
ADDRLP4 360
INDIRI4
ASGNI4
line 881
;881:	cgs.media.battleSuitShader = trap_R_RegisterShader("powerups/battleSuit" );
ADDRGP4 $665
ARGP4
ADDRLP4 364
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+152340+412
ADDRLP4 364
INDIRI4
ASGNI4
line 882
;882:	cgs.media.battleWeaponShader = trap_R_RegisterShader("powerups/battleWeapon" );
ADDRGP4 $668
ARGP4
ADDRLP4 368
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+152340+416
ADDRLP4 368
INDIRI4
ASGNI4
line 883
;883:	cgs.media.invisShader = trap_R_RegisterShader("powerups/invisibility" );
ADDRGP4 $671
ARGP4
ADDRLP4 372
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+152340+404
ADDRLP4 372
INDIRI4
ASGNI4
line 884
;884:	cgs.media.regenShader = trap_R_RegisterShader("powerups/regen" );
ADDRGP4 $674
ARGP4
ADDRLP4 376
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+152340+408
ADDRLP4 376
INDIRI4
ASGNI4
line 885
;885:	cgs.media.hastePuffShader = trap_R_RegisterShader("hasteSmokePuff" );
ADDRGP4 $677
ARGP4
ADDRLP4 380
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+152340+420
ADDRLP4 380
INDIRI4
ASGNI4
line 890
;886:
;887:#ifdef MISSIONPACK
;888:	if ( cgs.gametype == GT_CTF || cgs.gametype == GT_1FCTF || cgs.gametype == GT_HARVESTER || cg_buildScript.integer ) {
;889:#else
;890:	if ( cgs.gametype == GT_CTF || cg_buildScript.integer ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 4
EQI4 $682
ADDRGP4 cg_buildScript+12
INDIRI4
CNSTI4 0
EQI4 $678
LABELV $682
line 892
;891:#endif
;892:		cgs.media.redCubeModel = trap_R_RegisterModel( "models/powerups/orb/r_orb.md3" );
ADDRGP4 $685
ARGP4
ADDRLP4 384
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+152340+20
ADDRLP4 384
INDIRI4
ASGNI4
line 893
;893:		cgs.media.blueCubeModel = trap_R_RegisterModel( "models/powerups/orb/b_orb.md3" );
ADDRGP4 $688
ARGP4
ADDRLP4 388
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+152340+24
ADDRLP4 388
INDIRI4
ASGNI4
line 894
;894:		cgs.media.redCubeIcon = trap_R_RegisterShader( "icons/skull_red" );
ADDRGP4 $691
ARGP4
ADDRLP4 392
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+152340+28
ADDRLP4 392
INDIRI4
ASGNI4
line 895
;895:		cgs.media.blueCubeIcon = trap_R_RegisterShader( "icons/skull_blue" );
ADDRGP4 $694
ARGP4
ADDRLP4 396
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+152340+32
ADDRLP4 396
INDIRI4
ASGNI4
line 896
;896:	}
LABELV $678
line 901
;897:
;898:#ifdef MISSIONPACK
;899:	if ( cgs.gametype == GT_CTF || cgs.gametype == GT_1FCTF || cgs.gametype == GT_HARVESTER || cg_buildScript.integer ) {
;900:#else
;901:	if ( cgs.gametype == GT_CTF || cg_buildScript.integer ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 4
EQI4 $699
ADDRGP4 cg_buildScript+12
INDIRI4
CNSTI4 0
EQI4 $695
LABELV $699
line 903
;902:#endif
;903:		cgs.media.redFlagModel = trap_R_RegisterModel( "models/flags/r_flag.md3" );
ADDRGP4 $702
ARGP4
ADDRLP4 384
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+152340+36
ADDRLP4 384
INDIRI4
ASGNI4
line 904
;904:		cgs.media.blueFlagModel = trap_R_RegisterModel( "models/flags/b_flag.md3" );
ADDRGP4 $705
ARGP4
ADDRLP4 388
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+152340+40
ADDRLP4 388
INDIRI4
ASGNI4
line 905
;905:		cgs.media.redFlagShader[0] = trap_R_RegisterShaderNoMip( "icons/iconf_red1" );
ADDRGP4 $708
ARGP4
ADDRLP4 392
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+152340+48
ADDRLP4 392
INDIRI4
ASGNI4
line 906
;906:		cgs.media.redFlagShader[1] = trap_R_RegisterShaderNoMip( "icons/iconf_red2" );
ADDRGP4 $712
ARGP4
ADDRLP4 396
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+152340+48+4
ADDRLP4 396
INDIRI4
ASGNI4
line 907
;907:		cgs.media.redFlagShader[2] = trap_R_RegisterShaderNoMip( "icons/iconf_red3" );
ADDRGP4 $716
ARGP4
ADDRLP4 400
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+152340+48+8
ADDRLP4 400
INDIRI4
ASGNI4
line 908
;908:		cgs.media.blueFlagShader[0] = trap_R_RegisterShaderNoMip( "icons/iconf_blu1" );
ADDRGP4 $719
ARGP4
ADDRLP4 404
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+152340+60
ADDRLP4 404
INDIRI4
ASGNI4
line 909
;909:		cgs.media.blueFlagShader[1] = trap_R_RegisterShaderNoMip( "icons/iconf_blu2" );
ADDRGP4 $723
ARGP4
ADDRLP4 408
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+152340+60+4
ADDRLP4 408
INDIRI4
ASGNI4
line 910
;910:		cgs.media.blueFlagShader[2] = trap_R_RegisterShaderNoMip( "icons/iconf_blu3" );
ADDRGP4 $727
ARGP4
ADDRLP4 412
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+152340+60+8
ADDRLP4 412
INDIRI4
ASGNI4
line 923
;911:#ifdef MISSIONPACK
;912:		cgs.media.flagPoleModel = trap_R_RegisterModel( "models/flag2/flagpole.md3" );
;913:		cgs.media.flagFlapModel = trap_R_RegisterModel( "models/flag2/flagflap3.md3" );
;914:
;915:		cgs.media.redFlagFlapSkin = trap_R_RegisterSkin( "models/flag2/red.skin" );
;916:		cgs.media.blueFlagFlapSkin = trap_R_RegisterSkin( "models/flag2/blue.skin" );
;917:		cgs.media.neutralFlagFlapSkin = trap_R_RegisterSkin( "models/flag2/white.skin" );
;918:
;919:		cgs.media.redFlagBaseModel = trap_R_RegisterModel( "models/mapobjects/flagbase/red_base.md3" );
;920:		cgs.media.blueFlagBaseModel = trap_R_RegisterModel( "models/mapobjects/flagbase/blue_base.md3" );
;921:		cgs.media.neutralFlagBaseModel = trap_R_RegisterModel( "models/mapobjects/flagbase/ntrl_base.md3" );
;922:#endif
;923:	}
LABELV $695
line 952
;924:
;925:#ifdef MISSIONPACK
;926:	if ( cgs.gametype == GT_1FCTF || cg_buildScript.integer ) {
;927:		cgs.media.neutralFlagModel = trap_R_RegisterModel( "models/flags/n_flag.md3" );
;928:		cgs.media.flagShader[0] = trap_R_RegisterShaderNoMip( "icons/iconf_neutral1" );
;929:		cgs.media.flagShader[1] = trap_R_RegisterShaderNoMip( "icons/iconf_red2" );
;930:		cgs.media.flagShader[2] = trap_R_RegisterShaderNoMip( "icons/iconf_blu2" );
;931:		cgs.media.flagShader[3] = trap_R_RegisterShaderNoMip( "icons/iconf_neutral3" );
;932:	}
;933:
;934:	if ( cgs.gametype == GT_OBELISK || cg_buildScript.integer ) {
;935:		cgs.media.overloadBaseModel = trap_R_RegisterModel( "models/powerups/overload_base.md3" );
;936:		cgs.media.overloadTargetModel = trap_R_RegisterModel( "models/powerups/overload_target.md3" );
;937:		cgs.media.overloadLightsModel = trap_R_RegisterModel( "models/powerups/overload_lights.md3" );
;938:		cgs.media.overloadEnergyModel = trap_R_RegisterModel( "models/powerups/overload_energy.md3" );
;939:	}
;940:
;941:	if ( cgs.gametype == GT_HARVESTER || cg_buildScript.integer ) {
;942:		cgs.media.harvesterModel = trap_R_RegisterModel( "models/powerups/harvester/harvester.md3" );
;943:		cgs.media.harvesterRedSkin = trap_R_RegisterSkin( "models/powerups/harvester/red.skin" );
;944:		cgs.media.harvesterBlueSkin = trap_R_RegisterSkin( "models/powerups/harvester/blue.skin" );
;945:		cgs.media.harvesterNeutralModel = trap_R_RegisterModel( "models/powerups/obelisk/obelisk.md3" );
;946:	}
;947:
;948:	cgs.media.redKamikazeShader = trap_R_RegisterShader( "models/weaphits/kamikred" );
;949:	cgs.media.dustPuffShader = trap_R_RegisterShader("hasteSmokePuff" );
;950:#endif
;951:
;952:	if ( cgs.gametype >= GT_TEAM || cg_buildScript.integer ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
GEI4 $732
ADDRGP4 cg_buildScript+12
INDIRI4
CNSTI4 0
EQI4 $728
LABELV $732
line 953
;953:		cgs.media.friendShader = trap_R_RegisterShader( "sprites/foe" );
ADDRGP4 $735
ARGP4
ADDRLP4 384
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+152340+200
ADDRLP4 384
INDIRI4
ASGNI4
line 954
;954:		cgs.media.redQuadShader = trap_R_RegisterShader("powerups/blueflag" );
ADDRGP4 $738
ARGP4
ADDRLP4 388
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+152340+396
ADDRLP4 388
INDIRI4
ASGNI4
line 955
;955:		cgs.media.teamStatusBar = trap_R_RegisterShader( "gfx/2d/colorbar.tga" );
ADDRGP4 $741
ARGP4
ADDRLP4 392
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+152340+128
ADDRLP4 392
INDIRI4
ASGNI4
line 959
;956:#ifdef MISSIONPACK
;957:		cgs.media.blueKamikazeShader = trap_R_RegisterShader( "models/weaphits/kamikblu" );
;958:#endif
;959:	}
LABELV $728
line 961
;960:
;961:	cgs.media.armorModel = trap_R_RegisterModel( "models/powerups/armor/armor_yel.md3" );
ADDRGP4 $744
ARGP4
ADDRLP4 384
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+152340+120
ADDRLP4 384
INDIRI4
ASGNI4
line 962
;962:	cgs.media.armorIcon  = trap_R_RegisterShaderNoMip( "icons/iconr_yellow" );
ADDRGP4 $747
ARGP4
ADDRLP4 388
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+152340+124
ADDRLP4 388
INDIRI4
ASGNI4
line 964
;963:
;964:	cgs.media.machinegunBrassModel = trap_R_RegisterModel( "models/weapons2/shells/m_shell.md3" );
ADDRGP4 $750
ARGP4
ADDRLP4 392
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+152340+180
ADDRLP4 392
INDIRI4
ASGNI4
line 965
;965:	cgs.media.shotgunBrassModel = trap_R_RegisterModel( "models/weapons2/shells/s_shell.md3" );
ADDRGP4 $753
ARGP4
ADDRLP4 396
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+152340+184
ADDRLP4 396
INDIRI4
ASGNI4
line 967
;966:
;967:	cgs.media.gibAbdomen = trap_R_RegisterModel( "models/gibs/abdomen.md3" );
ADDRGP4 $756
ARGP4
ADDRLP4 400
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+152340+136
ADDRLP4 400
INDIRI4
ASGNI4
line 968
;968:	cgs.media.gibArm = trap_R_RegisterModel( "models/gibs/arm.md3" );
ADDRGP4 $759
ARGP4
ADDRLP4 404
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+152340+140
ADDRLP4 404
INDIRI4
ASGNI4
line 969
;969:	cgs.media.gibChest = trap_R_RegisterModel( "models/gibs/chest.md3" );
ADDRGP4 $762
ARGP4
ADDRLP4 408
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+152340+144
ADDRLP4 408
INDIRI4
ASGNI4
line 970
;970:	cgs.media.gibFist = trap_R_RegisterModel( "models/gibs/fist.md3" );
ADDRGP4 $765
ARGP4
ADDRLP4 412
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+152340+148
ADDRLP4 412
INDIRI4
ASGNI4
line 971
;971:	cgs.media.gibFoot = trap_R_RegisterModel( "models/gibs/foot.md3" );
ADDRGP4 $768
ARGP4
ADDRLP4 416
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+152340+152
ADDRLP4 416
INDIRI4
ASGNI4
line 972
;972:	cgs.media.gibForearm = trap_R_RegisterModel( "models/gibs/forearm.md3" );
ADDRGP4 $771
ARGP4
ADDRLP4 420
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+152340+156
ADDRLP4 420
INDIRI4
ASGNI4
line 973
;973:	cgs.media.gibIntestine = trap_R_RegisterModel( "models/gibs/intestine.md3" );
ADDRGP4 $774
ARGP4
ADDRLP4 424
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+152340+160
ADDRLP4 424
INDIRI4
ASGNI4
line 974
;974:	cgs.media.gibLeg = trap_R_RegisterModel( "models/gibs/leg.md3" );
ADDRGP4 $777
ARGP4
ADDRLP4 428
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+152340+164
ADDRLP4 428
INDIRI4
ASGNI4
line 975
;975:	cgs.media.gibSkull = trap_R_RegisterModel( "models/gibs/skull.md3" );
ADDRGP4 $780
ARGP4
ADDRLP4 432
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+152340+168
ADDRLP4 432
INDIRI4
ASGNI4
line 976
;976:	cgs.media.gibBrain = trap_R_RegisterModel( "models/gibs/brain.md3" );
ADDRGP4 $783
ARGP4
ADDRLP4 436
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+152340+172
ADDRLP4 436
INDIRI4
ASGNI4
line 978
;977:
;978:	cgs.media.smoke2 = trap_R_RegisterModel( "models/weapons2/shells/s_shell.md3" );
ADDRGP4 $753
ARGP4
ADDRLP4 440
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+152340+176
ADDRLP4 440
INDIRI4
ASGNI4
line 980
;979:
;980:	cgs.media.balloonShader = trap_R_RegisterShader( "sprites/balloon3" );
ADDRGP4 $788
ARGP4
ADDRLP4 444
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+152340+204
ADDRLP4 444
INDIRI4
ASGNI4
line 982
;981:
;982:	cgs.media.bloodExplosionShader = trap_R_RegisterShader( "bloodExplosion" );
ADDRGP4 $791
ARGP4
ADDRLP4 448
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+152340+472
ADDRLP4 448
INDIRI4
ASGNI4
line 984
;983:
;984:	cgs.media.bulletFlashModel = trap_R_RegisterModel("models/weaphits/bullet.md3");
ADDRGP4 $794
ARGP4
ADDRLP4 452
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+152340+432
ADDRLP4 452
INDIRI4
ASGNI4
line 985
;985:	cgs.media.ringFlashModel = trap_R_RegisterModel("models/weaphits/ring02.md3");
ADDRGP4 $797
ARGP4
ADDRLP4 456
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+152340+436
ADDRLP4 456
INDIRI4
ASGNI4
line 986
;986:	cgs.media.dishFlashModel = trap_R_RegisterModel("models/weaphits/boom01.md3");
ADDRGP4 $800
ARGP4
ADDRLP4 460
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+152340+440
ADDRLP4 460
INDIRI4
ASGNI4
line 990
;987:#ifdef MISSIONPACK
;988:	cgs.media.teleportEffectModel = trap_R_RegisterModel( "models/powerups/pop.md3" );
;989:#else
;990:	cgs.media.teleportEffectModel = trap_R_RegisterModel( "models/misc/telep.md3" );
ADDRGP4 $803
ARGP4
ADDRLP4 464
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+152340+476
ADDRLP4 464
INDIRI4
ASGNI4
line 991
;991:	cgs.media.teleportEffectShader = trap_R_RegisterShader( "teleportEffect" );
ADDRGP4 $806
ARGP4
ADDRLP4 468
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+152340+480
ADDRLP4 468
INDIRI4
ASGNI4
line 1009
;992:#endif
;993:#ifdef MISSIONPACK
;994:	cgs.media.kamikazeEffectModel = trap_R_RegisterModel( "models/weaphits/kamboom2.md3" );
;995:	cgs.media.kamikazeShockWave = trap_R_RegisterModel( "models/weaphits/kamwave.md3" );
;996:	cgs.media.kamikazeHeadModel = trap_R_RegisterModel( "models/powerups/kamikazi.md3" );
;997:	cgs.media.kamikazeHeadTrail = trap_R_RegisterModel( "models/powerups/trailtest.md3" );
;998:	cgs.media.guardPowerupModel = trap_R_RegisterModel( "models/powerups/guard_player.md3" );
;999:	cgs.media.scoutPowerupModel = trap_R_RegisterModel( "models/powerups/scout_player.md3" );
;1000:	cgs.media.doublerPowerupModel = trap_R_RegisterModel( "models/powerups/doubler_player.md3" );
;1001:	cgs.media.ammoRegenPowerupModel = trap_R_RegisterModel( "models/powerups/ammo_player.md3" );
;1002:	cgs.media.invulnerabilityImpactModel = trap_R_RegisterModel( "models/powerups/shield/impact.md3" );
;1003:	cgs.media.invulnerabilityJuicedModel = trap_R_RegisterModel( "models/powerups/shield/juicer.md3" );
;1004:	cgs.media.medkitUsageModel = trap_R_RegisterModel( "models/powerups/regen.md3" );
;1005:	cgs.media.heartShader = trap_R_RegisterShaderNoMip( "ui/assets/statusbar/selectedhealth.tga" );
;1006:
;1007:#endif
;1008:
;1009:	cgs.media.invulnerabilityPowerupModel = trap_R_RegisterModel( "models/powerups/shield/shield.md3" );
ADDRGP4 $809
ARGP4
ADDRLP4 472
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRGP4 cgs+152340+484
ADDRLP4 472
INDIRI4
ASGNI4
line 1010
;1010:	cgs.media.medalImpressive = trap_R_RegisterShaderNoMip( "medal_impressive" );
ADDRGP4 $812
ARGP4
ADDRLP4 476
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+152340+504
ADDRLP4 476
INDIRI4
ASGNI4
line 1011
;1011:	cgs.media.medalExcellent = trap_R_RegisterShaderNoMip( "medal_excellent" );
ADDRGP4 $815
ARGP4
ADDRLP4 480
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+152340+508
ADDRLP4 480
INDIRI4
ASGNI4
line 1012
;1012:	cgs.media.medalGauntlet = trap_R_RegisterShaderNoMip( "medal_gauntlet" );
ADDRGP4 $818
ARGP4
ADDRLP4 484
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+152340+512
ADDRLP4 484
INDIRI4
ASGNI4
line 1013
;1013:	cgs.media.medalDefend = trap_R_RegisterShaderNoMip( "medal_defend" );
ADDRGP4 $821
ARGP4
ADDRLP4 488
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+152340+516
ADDRLP4 488
INDIRI4
ASGNI4
line 1014
;1014:	cgs.media.medalAssist = trap_R_RegisterShaderNoMip( "medal_assist" );
ADDRGP4 $824
ARGP4
ADDRLP4 492
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+152340+520
ADDRLP4 492
INDIRI4
ASGNI4
line 1015
;1015:	cgs.media.medalCapture = trap_R_RegisterShaderNoMip( "medal_capture" );
ADDRGP4 $827
ARGP4
ADDRLP4 496
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+152340+524
ADDRLP4 496
INDIRI4
ASGNI4
line 1018
;1016:
;1017:
;1018:	memset( cg_items, 0, sizeof( cg_items ) );
ADDRGP4 cg_items
ARGP4
CNSTI4 0
ARGI4
CNSTI4 6144
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1019
;1019:	memset( cg_weapons, 0, sizeof( cg_weapons ) );
ADDRGP4 cg_weapons
ARGP4
CNSTI4 0
ARGI4
CNSTI4 2176
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1022
;1020:
;1021:	// only register the items that the server says we need
;1022:	strcpy( items, CG_ConfigString( CS_ITEMS) );
CNSTI4 27
ARGI4
ADDRLP4 500
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 4
ARGP4
ADDRLP4 500
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 1024
;1023:
;1024:	for ( i = 1 ; i < bg_numItems ; i++ ) {
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $831
JUMPV
LABELV $828
line 1025
;1025:		if ( items[ i ] == '1' || cg_buildScript.integer ) {
ADDRLP4 0
INDIRI4
ADDRLP4 4
ADDP4
INDIRI1
CVII4 1
CNSTI4 49
EQI4 $835
ADDRGP4 cg_buildScript+12
INDIRI4
CNSTI4 0
EQI4 $832
LABELV $835
line 1026
;1026:			CG_LoadingItem( i );
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_LoadingItem
CALLV
pop
line 1027
;1027:			CG_RegisterItemVisuals( i );
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_RegisterItemVisuals
CALLV
pop
line 1028
;1028:		}
LABELV $832
line 1029
;1029:	}
LABELV $829
line 1024
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $831
ADDRLP4 0
INDIRI4
ADDRGP4 bg_numItems
INDIRI4
LTI4 $828
line 1032
;1030:
;1031:	// wall marks
;1032:	cgs.media.bulletMarkShader = trap_R_RegisterShader( "gfx/damage/bullet_mrk" );
ADDRGP4 $838
ARGP4
ADDRLP4 504
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+152340+376
ADDRLP4 504
INDIRI4
ASGNI4
line 1033
;1033:	cgs.media.burnMarkShader = trap_R_RegisterShader( "gfx/damage/burn_med_mrk" );
ADDRGP4 $841
ARGP4
ADDRLP4 508
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+152340+380
ADDRLP4 508
INDIRI4
ASGNI4
line 1034
;1034:	cgs.media.holeMarkShader = trap_R_RegisterShader( "gfx/damage/hole_lg_mrk" );
ADDRGP4 $844
ARGP4
ADDRLP4 512
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+152340+384
ADDRLP4 512
INDIRI4
ASGNI4
line 1035
;1035:	cgs.media.energyMarkShader = trap_R_RegisterShader( "gfx/damage/plasma_mrk" );
ADDRGP4 $847
ARGP4
ADDRLP4 516
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+152340+388
ADDRLP4 516
INDIRI4
ASGNI4
line 1036
;1036:	cgs.media.shadowMarkShader = trap_R_RegisterShader( "markShadow" );
ADDRGP4 $850
ARGP4
ADDRLP4 520
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+152340+344
ADDRLP4 520
INDIRI4
ASGNI4
line 1037
;1037:	cgs.media.wakeMarkShader = trap_R_RegisterShader( "wake" );
ADDRGP4 $853
ARGP4
ADDRLP4 524
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+152340+368
ADDRLP4 524
INDIRI4
ASGNI4
line 1038
;1038:	cgs.media.bloodMarkShader = trap_R_RegisterShader( "bloodMark" );
ADDRGP4 $856
ARGP4
ADDRLP4 528
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+152340+372
ADDRLP4 528
INDIRI4
ASGNI4
line 1041
;1039:
;1040:	// register the inline models
;1041:	cgs.numInlineModels = trap_CM_NumInlineModels();
ADDRLP4 532
ADDRGP4 trap_CM_NumInlineModels
CALLI4
ASGNI4
ADDRGP4 cgs+36872
ADDRLP4 532
INDIRI4
ASGNI4
line 1042
;1042:	for ( i = 1 ; i < cgs.numInlineModels ; i++ ) {
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $861
JUMPV
LABELV $858
line 1047
;1043:		char	name[10];
;1044:		vec3_t			mins, maxs;
;1045:		int				j;
;1046:
;1047:		Com_sprintf( name, sizeof(name), "*%i", i );
ADDRLP4 564
ARGP4
CNSTI4 10
ARGI4
ADDRGP4 $863
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1048
;1048:		cgs.inlineDrawModel[i] = trap_R_RegisterModel( name );
ADDRLP4 564
ARGP4
ADDRLP4 576
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+36876
ADDP4
ADDRLP4 576
INDIRI4
ASGNI4
line 1049
;1049:		trap_R_ModelBounds( cgs.inlineDrawModel[i], mins, maxs );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+36876
ADDP4
INDIRI4
ARGI4
ADDRLP4 540
ARGP4
ADDRLP4 552
ARGP4
ADDRGP4 trap_R_ModelBounds
CALLV
pop
line 1050
;1050:		for ( j = 0 ; j < 3 ; j++ ) {
ADDRLP4 536
CNSTI4 0
ASGNI4
LABELV $866
line 1051
;1051:			cgs.inlineModelMidpoints[i][j] = mins[j] + 0.5 * ( maxs[j] - mins[j] );
ADDRLP4 580
ADDRLP4 536
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 584
ADDRLP4 580
INDIRI4
ADDRLP4 540
ADDP4
INDIRF4
ASGNF4
ADDRLP4 580
INDIRI4
CNSTI4 12
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cgs+37900
ADDP4
ADDP4
ADDRLP4 584
INDIRF4
CNSTF4 1056964608
ADDRLP4 580
INDIRI4
ADDRLP4 552
ADDP4
INDIRF4
ADDRLP4 584
INDIRF4
SUBF4
MULF4
ADDF4
ASGNF4
line 1052
;1052:		}
LABELV $867
line 1050
ADDRLP4 536
ADDRLP4 536
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 536
INDIRI4
CNSTI4 3
LTI4 $866
line 1053
;1053:	}
LABELV $859
line 1042
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $861
ADDRLP4 0
INDIRI4
ADDRGP4 cgs+36872
INDIRI4
LTI4 $858
line 1056
;1054:
;1055:	// register all the server specified models
;1056:	for (i=1 ; i<MAX_MODELS ; i++) {
ADDRLP4 0
CNSTI4 1
ASGNI4
LABELV $871
line 1059
;1057:		const char		*modelName;
;1058:
;1059:		modelName = CG_ConfigString( CS_MODELS+i );
ADDRLP4 0
INDIRI4
CNSTI4 32
ADDI4
ARGI4
ADDRLP4 540
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 536
ADDRLP4 540
INDIRP4
ASGNP4
line 1060
;1060:		if ( !modelName[0] ) {
ADDRLP4 536
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $875
line 1061
;1061:			break;
ADDRGP4 $873
JUMPV
LABELV $875
line 1063
;1062:		}
;1063:		cgs.gameModels[i] = trap_R_RegisterModel( modelName );
ADDRLP4 536
INDIRP4
ARGP4
ADDRLP4 544
ADDRGP4 trap_R_RegisterModel
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+34824
ADDP4
ADDRLP4 544
INDIRI4
ASGNI4
line 1064
;1064:	}
LABELV $872
line 1056
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 256
LTI4 $871
LABELV $873
line 1092
;1065:
;1066:#ifdef MISSIONPACK
;1067:	// new stuff
;1068:	cgs.media.patrolShader = trap_R_RegisterShaderNoMip("ui/assets/statusbar/patrol.tga");
;1069:	cgs.media.assaultShader = trap_R_RegisterShaderNoMip("ui/assets/statusbar/assault.tga");
;1070:	cgs.media.campShader = trap_R_RegisterShaderNoMip("ui/assets/statusbar/camp.tga");
;1071:	cgs.media.followShader = trap_R_RegisterShaderNoMip("ui/assets/statusbar/follow.tga");
;1072:	cgs.media.defendShader = trap_R_RegisterShaderNoMip("ui/assets/statusbar/defend.tga");
;1073:	cgs.media.teamLeaderShader = trap_R_RegisterShaderNoMip("ui/assets/statusbar/team_leader.tga");
;1074:	cgs.media.retrieveShader = trap_R_RegisterShaderNoMip("ui/assets/statusbar/retrieve.tga");
;1075:	cgs.media.escortShader = trap_R_RegisterShaderNoMip("ui/assets/statusbar/escort.tga");
;1076:	cgs.media.cursor = trap_R_RegisterShaderNoMip( "menu/art/3_cursor2" );
;1077:	cgs.media.sizeCursor = trap_R_RegisterShaderNoMip( "ui/assets/sizecursor.tga" );
;1078:	cgs.media.selectCursor = trap_R_RegisterShaderNoMip( "ui/assets/selectcursor.tga" );
;1079:	cgs.media.flagShaders[0] = trap_R_RegisterShaderNoMip("ui/assets/statusbar/flag_in_base.tga");
;1080:	cgs.media.flagShaders[1] = trap_R_RegisterShaderNoMip("ui/assets/statusbar/flag_capture.tga");
;1081:	cgs.media.flagShaders[2] = trap_R_RegisterShaderNoMip("ui/assets/statusbar/flag_missing.tga");
;1082:
;1083:	trap_R_RegisterModel( "models/players/james/lower.md3" );
;1084:	trap_R_RegisterModel( "models/players/james/upper.md3" );
;1085:	trap_R_RegisterModel( "models/players/heads/james/james.md3" );
;1086:
;1087:	trap_R_RegisterModel( "models/players/janet/lower.md3" );
;1088:	trap_R_RegisterModel( "models/players/janet/upper.md3" );
;1089:	trap_R_RegisterModel( "models/players/heads/janet/janet.md3" );
;1090:
;1091:#endif
;1092:	CG_ClearParticles ();
ADDRGP4 CG_ClearParticles
CALLV
pop
line 1105
;1093:/*
;1094:	for (i=1; i<MAX_PARTICLES_AREAS; i++)
;1095:	{
;1096:		{
;1097:			int rval;
;1098:
;1099:			rval = CG_NewParticleArea ( CS_PARTICLES + i);
;1100:			if (!rval)
;1101:				break;
;1102:		}
;1103:	}
;1104:*/
;1105:}
LABELV $553
endproc CG_RegisterGraphics 588 16
export CG_BuildSpectatorString
proc CG_BuildSpectatorString 12 12
line 1115
;1106:
;1107:
;1108:
;1109:/*																																			
;1110:=======================
;1111:CG_BuildSpectatorString
;1112:
;1113:=======================
;1114:*/
;1115:void CG_BuildSpectatorString() {
line 1117
;1116:	int i;
;1117:	cg.spectatorList[0] = 0;
ADDRGP4 cg+114364
CNSTI1 0
ASGNI1
line 1118
;1118:	for (i = 0; i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $880
line 1119
;1119:		if (cgs.clientinfo[i].infoValid && cgs.clientinfo[i].team == TEAM_SPECTATOR ) {
ADDRLP4 4
CNSTI4 1708
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 4
INDIRI4
ADDRGP4 cgs+40972
ADDP4
INDIRI4
CNSTI4 0
EQI4 $884
ADDRLP4 4
INDIRI4
ADDRGP4 cgs+40972+68
ADDP4
INDIRI4
CNSTI4 3
NEI4 $884
line 1120
;1120:			Q_strcat(cg.spectatorList, sizeof(cg.spectatorList), va("%s     ", cgs.clientinfo[i].name));
ADDRGP4 $891
ARGP4
CNSTI4 1708
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cgs+40972+4
ADDP4
ARGP4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 cg+114364
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 1121
;1121:		}
LABELV $884
line 1122
;1122:	}
LABELV $881
line 1118
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $880
line 1123
;1123:	i = strlen(cg.spectatorList);
ADDRGP4 cg+114364
ARGP4
ADDRLP4 4
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 1124
;1124:	if (i != cg.spectatorLen) {
ADDRLP4 0
INDIRI4
ADDRGP4 cg+115388
INDIRI4
EQI4 $895
line 1125
;1125:		cg.spectatorLen = i;
ADDRGP4 cg+115388
ADDRLP4 0
INDIRI4
ASGNI4
line 1126
;1126:		cg.spectatorWidth = -1;
ADDRGP4 cg+115392
CNSTF4 3212836864
ASGNF4
line 1127
;1127:	}
LABELV $895
line 1128
;1128:}
LABELV $878
endproc CG_BuildSpectatorString 12 12
proc CG_RegisterClients 12 4
line 1136
;1129:
;1130:
;1131:/*																																			
;1132:===================
;1133:CG_RegisterClients
;1134:===================
;1135:*/
;1136:static void CG_RegisterClients( void ) {
line 1139
;1137:	int		i;
;1138:
;1139:	CG_LoadingClient(cg.clientNum);
ADDRGP4 cg+4
INDIRI4
ARGI4
ADDRGP4 CG_LoadingClient
CALLV
pop
line 1140
;1140:	CG_NewClientInfo(cg.clientNum);
ADDRGP4 cg+4
INDIRI4
ARGI4
ADDRGP4 CG_NewClientInfo
CALLV
pop
line 1142
;1141:
;1142:	for (i=0 ; i<MAX_CLIENTS ; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $903
line 1145
;1143:		const char		*clientInfo;
;1144:
;1145:		if (cg.clientNum == i) {
ADDRGP4 cg+4
INDIRI4
ADDRLP4 0
INDIRI4
NEI4 $907
line 1146
;1146:			continue;
ADDRGP4 $904
JUMPV
LABELV $907
line 1149
;1147:		}
;1148:
;1149:		clientInfo = CG_ConfigString( CS_PLAYERS+i );
ADDRLP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 8
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
ASGNP4
line 1150
;1150:		if ( !clientInfo[0]) {
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $910
line 1151
;1151:			continue;
ADDRGP4 $904
JUMPV
LABELV $910
line 1153
;1152:		}
;1153:		CG_LoadingClient( i );
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_LoadingClient
CALLV
pop
line 1154
;1154:		CG_NewClientInfo( i );
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_NewClientInfo
CALLV
pop
line 1155
;1155:	}
LABELV $904
line 1142
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 64
LTI4 $903
line 1156
;1156:	CG_BuildSpectatorString();
ADDRGP4 CG_BuildSpectatorString
CALLV
pop
line 1157
;1157:}
LABELV $900
endproc CG_RegisterClients 12 4
export CG_ConfigString
proc CG_ConfigString 4 8
line 1166
;1158:
;1159://===========================================================================
;1160:
;1161:/*
;1162:=================
;1163:CG_ConfigString
;1164:=================
;1165:*/
;1166:const char *CG_ConfigString( int index ) {
line 1167
;1167:	if ( index < 0 || index >= MAX_CONFIGSTRINGS ) {
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $915
ADDRLP4 0
INDIRI4
CNSTI4 1024
LTI4 $913
LABELV $915
line 1168
;1168:		CG_Error( "CG_ConfigString: bad index: %i", index );
ADDRGP4 $916
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 CG_Error
CALLV
pop
line 1169
;1169:	}
LABELV $913
line 1170
;1170:	return cgs.gameState.stringData + cgs.gameState.stringOffsets[ index ];
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs
ADDP4
INDIRI4
ADDRGP4 cgs+4096
ADDP4
RETP4
LABELV $912
endproc CG_ConfigString 4 8
export CG_StartMusic
proc CG_StartMusic 144 12
line 1181
;1171:}
;1172:
;1173://==================================================================
;1174:
;1175:/*
;1176:======================
;1177:CG_StartMusic
;1178:
;1179:======================
;1180:*/
;1181:void CG_StartMusic( void ) {
line 1186
;1182:	char	*s;
;1183:	char	parm1[MAX_QPATH], parm2[MAX_QPATH];
;1184:
;1185:	// start the background music
;1186:	s = (char *)CG_ConfigString( CS_MUSIC );
CNSTI4 2
ARGI4
ADDRLP4 132
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 132
INDIRP4
ASGNP4
line 1187
;1187:	Q_strncpyz( parm1, COM_Parse( &s ), sizeof( parm1 ) );
ADDRLP4 0
ARGP4
ADDRLP4 136
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 4
ARGP4
ADDRLP4 136
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1188
;1188:	Q_strncpyz( parm2, COM_Parse( &s ), sizeof( parm2 ) );
ADDRLP4 0
ARGP4
ADDRLP4 140
ADDRGP4 COM_Parse
CALLP4
ASGNP4
ADDRLP4 68
ARGP4
ADDRLP4 140
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1190
;1189:
;1190:	trap_S_StartBackgroundTrack( parm1, parm2 );
ADDRLP4 4
ARGP4
ADDRLP4 68
ARGP4
ADDRGP4 trap_S_StartBackgroundTrack
CALLV
pop
line 1191
;1191:}
LABELV $918
endproc CG_StartMusic 144 12
export CG_Init
proc CG_Init 44 12
line 1857
;1192:#ifdef MISSIONPACK
;1193:char *CG_GetMenuBuffer(const char *filename) {
;1194:	int	len;
;1195:	fileHandle_t	f;
;1196:	static char buf[MAX_MENUFILE];
;1197:
;1198:	len = trap_FS_FOpenFile( filename, &f, FS_READ );
;1199:	if ( !f ) {
;1200:		trap_Print( va( S_COLOR_RED "menu file not found: %s, using default\n", filename ) );
;1201:		return NULL;
;1202:	}
;1203:	if ( len >= MAX_MENUFILE ) {
;1204:		trap_Print( va( S_COLOR_RED "menu file too large: %s is %i, max allowed is %i", filename, len, MAX_MENUFILE ) );
;1205:		trap_FS_FCloseFile( f );
;1206:		return NULL;
;1207:	}
;1208:
;1209:	trap_FS_Read( buf, len, f );
;1210:	buf[len] = 0;
;1211:	trap_FS_FCloseFile( f );
;1212:
;1213:	return buf;
;1214:}
;1215:
;1216://
;1217:// ==============================
;1218:// new hud stuff ( mission pack )
;1219:// ==============================
;1220://
;1221:qboolean CG_Asset_Parse(int handle) {
;1222:	pc_token_t token;
;1223:	const char *tempStr;
;1224:
;1225:	if (!trap_PC_ReadToken(handle, &token))
;1226:		return qfalse;
;1227:	if (Q_stricmp(token.string, "{") != 0) {
;1228:		return qfalse;
;1229:	}
;1230:    
;1231:	while ( 1 ) {
;1232:		if (!trap_PC_ReadToken(handle, &token))
;1233:			return qfalse;
;1234:
;1235:		if (Q_stricmp(token.string, "}") == 0) {
;1236:			return qtrue;
;1237:		}
;1238:
;1239:		// font
;1240:		if (Q_stricmp(token.string, "font") == 0) {
;1241:			int pointSize;
;1242:			if (!PC_String_Parse(handle, &tempStr) || !PC_Int_Parse(handle, &pointSize)) {
;1243:				return qfalse;
;1244:			}
;1245:			cgDC.registerFont(tempStr, pointSize, &cgDC.Assets.textFont);
;1246:			continue;
;1247:		}
;1248:
;1249:		// smallFont
;1250:		if (Q_stricmp(token.string, "smallFont") == 0) {
;1251:			int pointSize;
;1252:			if (!PC_String_Parse(handle, &tempStr) || !PC_Int_Parse(handle, &pointSize)) {
;1253:				return qfalse;
;1254:			}
;1255:			cgDC.registerFont(tempStr, pointSize, &cgDC.Assets.smallFont);
;1256:			continue;
;1257:		}
;1258:
;1259:		// font
;1260:		if (Q_stricmp(token.string, "bigfont") == 0) {
;1261:			int pointSize;
;1262:			if (!PC_String_Parse(handle, &tempStr) || !PC_Int_Parse(handle, &pointSize)) {
;1263:				return qfalse;
;1264:			}
;1265:			cgDC.registerFont(tempStr, pointSize, &cgDC.Assets.bigFont);
;1266:			continue;
;1267:		}
;1268:
;1269:		// gradientbar
;1270:		if (Q_stricmp(token.string, "gradientbar") == 0) {
;1271:			if (!PC_String_Parse(handle, &tempStr)) {
;1272:				return qfalse;
;1273:			}
;1274:			cgDC.Assets.gradientBar = trap_R_RegisterShaderNoMip(tempStr);
;1275:			continue;
;1276:		}
;1277:
;1278:		// enterMenuSound
;1279:		if (Q_stricmp(token.string, "menuEnterSound") == 0) {
;1280:			if (!PC_String_Parse(handle, &tempStr)) {
;1281:				return qfalse;
;1282:			}
;1283:			cgDC.Assets.menuEnterSound = trap_S_RegisterSound( tempStr, qfalse );
;1284:			continue;
;1285:		}
;1286:
;1287:		// exitMenuSound
;1288:		if (Q_stricmp(token.string, "menuExitSound") == 0) {
;1289:			if (!PC_String_Parse(handle, &tempStr)) {
;1290:				return qfalse;
;1291:			}
;1292:			cgDC.Assets.menuExitSound = trap_S_RegisterSound( tempStr, qfalse );
;1293:			continue;
;1294:		}
;1295:
;1296:		// itemFocusSound
;1297:		if (Q_stricmp(token.string, "itemFocusSound") == 0) {
;1298:			if (!PC_String_Parse(handle, &tempStr)) {
;1299:				return qfalse;
;1300:			}
;1301:			cgDC.Assets.itemFocusSound = trap_S_RegisterSound( tempStr, qfalse );
;1302:			continue;
;1303:		}
;1304:
;1305:		// menuBuzzSound
;1306:		if (Q_stricmp(token.string, "menuBuzzSound") == 0) {
;1307:			if (!PC_String_Parse(handle, &tempStr)) {
;1308:				return qfalse;
;1309:			}
;1310:			cgDC.Assets.menuBuzzSound = trap_S_RegisterSound( tempStr, qfalse );
;1311:			continue;
;1312:		}
;1313:
;1314:		if (Q_stricmp(token.string, "cursor") == 0) {
;1315:			if (!PC_String_Parse(handle, &cgDC.Assets.cursorStr)) {
;1316:				return qfalse;
;1317:			}
;1318:			cgDC.Assets.cursor = trap_R_RegisterShaderNoMip( cgDC.Assets.cursorStr);
;1319:			continue;
;1320:		}
;1321:
;1322:		if (Q_stricmp(token.string, "fadeClamp") == 0) {
;1323:			if (!PC_Float_Parse(handle, &cgDC.Assets.fadeClamp)) {
;1324:				return qfalse;
;1325:			}
;1326:			continue;
;1327:		}
;1328:
;1329:		if (Q_stricmp(token.string, "fadeCycle") == 0) {
;1330:			if (!PC_Int_Parse(handle, &cgDC.Assets.fadeCycle)) {
;1331:				return qfalse;
;1332:			}
;1333:			continue;
;1334:		}
;1335:
;1336:		if (Q_stricmp(token.string, "fadeAmount") == 0) {
;1337:			if (!PC_Float_Parse(handle, &cgDC.Assets.fadeAmount)) {
;1338:				return qfalse;
;1339:			}
;1340:			continue;
;1341:		}
;1342:
;1343:		if (Q_stricmp(token.string, "shadowX") == 0) {
;1344:			if (!PC_Float_Parse(handle, &cgDC.Assets.shadowX)) {
;1345:				return qfalse;
;1346:			}
;1347:			continue;
;1348:		}
;1349:
;1350:		if (Q_stricmp(token.string, "shadowY") == 0) {
;1351:			if (!PC_Float_Parse(handle, &cgDC.Assets.shadowY)) {
;1352:				return qfalse;
;1353:			}
;1354:			continue;
;1355:		}
;1356:
;1357:		if (Q_stricmp(token.string, "shadowColor") == 0) {
;1358:			if (!PC_Color_Parse(handle, &cgDC.Assets.shadowColor)) {
;1359:				return qfalse;
;1360:			}
;1361:			cgDC.Assets.shadowFadeClamp = cgDC.Assets.shadowColor[3];
;1362:			continue;
;1363:		}
;1364:	}
;1365:	return qfalse; // bk001204 - why not?
;1366:}
;1367:
;1368:void CG_ParseMenu(const char *menuFile) {
;1369:	pc_token_t token;
;1370:	int handle;
;1371:
;1372:	handle = trap_PC_LoadSource(menuFile);
;1373:	if (!handle)
;1374:		handle = trap_PC_LoadSource("ui/testhud.menu");
;1375:	if (!handle)
;1376:		return;
;1377:
;1378:	while ( 1 ) {
;1379:		if (!trap_PC_ReadToken( handle, &token )) {
;1380:			break;
;1381:		}
;1382:
;1383:		//if ( Q_stricmp( token, "{" ) ) {
;1384:		//	Com_Printf( "Missing { in menu file\n" );
;1385:		//	break;
;1386:		//}
;1387:
;1388:		//if ( menuCount == MAX_MENUS ) {
;1389:		//	Com_Printf( "Too many menus!\n" );
;1390:		//	break;
;1391:		//}
;1392:
;1393:		if ( token.string[0] == '}' ) {
;1394:			break;
;1395:		}
;1396:
;1397:		if (Q_stricmp(token.string, "assetGlobalDef") == 0) {
;1398:			if (CG_Asset_Parse(handle)) {
;1399:				continue;
;1400:			} else {
;1401:				break;
;1402:			}
;1403:		}
;1404:
;1405:
;1406:		if (Q_stricmp(token.string, "menudef") == 0) {
;1407:			// start a new menu
;1408:			Menu_New(handle);
;1409:		}
;1410:	}
;1411:	trap_PC_FreeSource(handle);
;1412:}
;1413:
;1414:qboolean CG_Load_Menu(char **p) {
;1415:	char *token;
;1416:
;1417:	token = COM_ParseExt(p, qtrue);
;1418:
;1419:	if (token[0] != '{') {
;1420:		return qfalse;
;1421:	}
;1422:
;1423:	while ( 1 ) {
;1424:
;1425:		token = COM_ParseExt(p, qtrue);
;1426:    
;1427:		if (Q_stricmp(token, "}") == 0) {
;1428:			return qtrue;
;1429:		}
;1430:
;1431:		if ( !token || token[0] == 0 ) {
;1432:			return qfalse;
;1433:		}
;1434:
;1435:		CG_ParseMenu(token); 
;1436:	}
;1437:	return qfalse;
;1438:}
;1439:
;1440:
;1441:
;1442:void CG_LoadMenus(const char *menuFile) {
;1443:	char	*token;
;1444:	char *p;
;1445:	int	len, start;
;1446:	fileHandle_t	f;
;1447:	static char buf[MAX_MENUDEFFILE];
;1448:
;1449:	start = trap_Milliseconds();
;1450:
;1451:	len = trap_FS_FOpenFile( menuFile, &f, FS_READ );
;1452:	if ( !f ) {
;1453:		trap_Error( va( S_COLOR_YELLOW "menu file not found: %s, using default\n", menuFile ) );
;1454:		len = trap_FS_FOpenFile( "ui/hud.txt", &f, FS_READ );
;1455:		if (!f) {
;1456:			trap_Error( va( S_COLOR_RED "default menu file not found: ui/hud.txt, unable to continue!\n", menuFile ) );
;1457:		}
;1458:	}
;1459:
;1460:	if ( len >= MAX_MENUDEFFILE ) {
;1461:		trap_Error( va( S_COLOR_RED "menu file too large: %s is %i, max allowed is %i", menuFile, len, MAX_MENUDEFFILE ) );
;1462:		trap_FS_FCloseFile( f );
;1463:		return;
;1464:	}
;1465:
;1466:	trap_FS_Read( buf, len, f );
;1467:	buf[len] = 0;
;1468:	trap_FS_FCloseFile( f );
;1469:	
;1470:	COM_Compress(buf);
;1471:
;1472:	Menu_Reset();
;1473:
;1474:	p = buf;
;1475:
;1476:	while ( 1 ) {
;1477:		token = COM_ParseExt( &p, qtrue );
;1478:		if( !token || token[0] == 0 || token[0] == '}') {
;1479:			break;
;1480:		}
;1481:
;1482:		//if ( Q_stricmp( token, "{" ) ) {
;1483:		//	Com_Printf( "Missing { in menu file\n" );
;1484:		//	break;
;1485:		//}
;1486:
;1487:		//if ( menuCount == MAX_MENUS ) {
;1488:		//	Com_Printf( "Too many menus!\n" );
;1489:		//	break;
;1490:		//}
;1491:
;1492:		if ( Q_stricmp( token, "}" ) == 0 ) {
;1493:			break;
;1494:		}
;1495:
;1496:		if (Q_stricmp(token, "loadmenu") == 0) {
;1497:			if (CG_Load_Menu(&p)) {
;1498:				continue;
;1499:			} else {
;1500:				break;
;1501:			}
;1502:		}
;1503:	}
;1504:
;1505:	Com_Printf("UI menu load time = %d milli seconds\n", trap_Milliseconds() - start);
;1506:
;1507:}
;1508:
;1509:
;1510:
;1511:static qboolean CG_OwnerDrawHandleKey(int ownerDraw, int flags, float *special, int key) {
;1512:	return qfalse;
;1513:}
;1514:
;1515:
;1516:static int CG_FeederCount(float feederID) {
;1517:	int i, count;
;1518:	count = 0;
;1519:	if (feederID == FEEDER_REDTEAM_LIST) {
;1520:		for (i = 0; i < cg.numScores; i++) {
;1521:			if (cg.scores[i].team == TEAM_RED) {
;1522:				count++;
;1523:			}
;1524:		}
;1525:	} else if (feederID == FEEDER_BLUETEAM_LIST) {
;1526:		for (i = 0; i < cg.numScores; i++) {
;1527:			if (cg.scores[i].team == TEAM_BLUE) {
;1528:				count++;
;1529:			}
;1530:		}
;1531:	} else if (feederID == FEEDER_SCOREBOARD) {
;1532:		return cg.numScores;
;1533:	}
;1534:	return count;
;1535:}
;1536:
;1537:
;1538:void CG_SetScoreSelection(void *p) {
;1539:	menuDef_t *menu = (menuDef_t*)p;
;1540:	playerState_t *ps = &cg.snap->ps;
;1541:	int i, red, blue;
;1542:	red = blue = 0;
;1543:	for (i = 0; i < cg.numScores; i++) {
;1544:		if (cg.scores[i].team == TEAM_RED) {
;1545:			red++;
;1546:		} else if (cg.scores[i].team == TEAM_BLUE) {
;1547:			blue++;
;1548:		}
;1549:		if (ps->clientNum == cg.scores[i].client) {
;1550:			cg.selectedScore = i;
;1551:		}
;1552:	}
;1553:
;1554:	if (menu == NULL) {
;1555:		// just interested in setting the selected score
;1556:		return;
;1557:	}
;1558:
;1559:	if ( cgs.gametype >= GT_TEAM ) {
;1560:		int feeder = FEEDER_REDTEAM_LIST;
;1561:		i = red;
;1562:		if (cg.scores[cg.selectedScore].team == TEAM_BLUE) {
;1563:			feeder = FEEDER_BLUETEAM_LIST;
;1564:			i = blue;
;1565:		}
;1566:		Menu_SetFeederSelection(menu, feeder, i, NULL);
;1567:	} else {
;1568:		Menu_SetFeederSelection(menu, FEEDER_SCOREBOARD, cg.selectedScore, NULL);
;1569:	}
;1570:}
;1571:
;1572:// FIXME: might need to cache this info
;1573:static clientInfo_t * CG_InfoFromScoreIndex(int index, int team, int *scoreIndex) {
;1574:	int i, count;
;1575:	if ( cgs.gametype >= GT_TEAM ) {
;1576:		count = 0;
;1577:		for (i = 0; i < cg.numScores; i++) {
;1578:			if (cg.scores[i].team == team) {
;1579:				if (count == index) {
;1580:					*scoreIndex = i;
;1581:					return &cgs.clientinfo[cg.scores[i].client];
;1582:				}
;1583:				count++;
;1584:			}
;1585:		}
;1586:	}
;1587:	*scoreIndex = index;
;1588:	return &cgs.clientinfo[ cg.scores[index].client ];
;1589:}
;1590:
;1591:static const char *CG_FeederItemText(float feederID, int index, int column, qhandle_t *handle) {
;1592:	gitem_t *item;
;1593:	int scoreIndex = 0;
;1594:	clientInfo_t *info = NULL;
;1595:	int team = -1;
;1596:	score_t *sp = NULL;
;1597:
;1598:	*handle = -1;
;1599:
;1600:	if (feederID == FEEDER_REDTEAM_LIST) {
;1601:		team = TEAM_RED;
;1602:	} else if (feederID == FEEDER_BLUETEAM_LIST) {
;1603:		team = TEAM_BLUE;
;1604:	}
;1605:
;1606:	info = CG_InfoFromScoreIndex(index, team, &scoreIndex);
;1607:	sp = &cg.scores[scoreIndex];
;1608:
;1609:	if (info && info->infoValid) {
;1610:		switch (column) {
;1611:			case 0:
;1612:				if ( info->powerups & ( 1 << PW_NEUTRALFLAG ) ) {
;1613:					item = BG_FindItemForPowerup( PW_NEUTRALFLAG );
;1614:					*handle = cg_items[ ITEM_INDEX(item) ].icon;
;1615:				} else if ( info->powerups & ( 1 << PW_REDFLAG ) ) {
;1616:					item = BG_FindItemForPowerup( PW_REDFLAG );
;1617:					*handle = cg_items[ ITEM_INDEX(item) ].icon;
;1618:				} else if ( info->powerups & ( 1 << PW_BLUEFLAG ) ) {
;1619:					item = BG_FindItemForPowerup( PW_BLUEFLAG );
;1620:					*handle = cg_items[ ITEM_INDEX(item) ].icon;
;1621:				} else {
;1622:					if ( info->botSkill > 0 && info->botSkill <= 5 ) {
;1623:						*handle = cgs.media.botSkillShaders[ info->botSkill - 1 ];
;1624:					} else if ( info->handicap < 100 ) {
;1625:					return va("%i", info->handicap );
;1626:					}
;1627:				}
;1628:			break;
;1629:			case 1:
;1630:				if (team == -1) {
;1631:					return "";
;1632:				} else {
;1633:					*handle = CG_StatusHandle(info->teamTask);
;1634:				}
;1635:		  break;
;1636:			case 2:
;1637:				if ( cg.snap->ps.stats[ STAT_CLIENTS_READY ] & ( 1 << sp->client ) ) {
;1638:					return "Ready";
;1639:				}
;1640:				if (team == -1) {
;1641:					if (cgs.gametype == GT_TOURNAMENT) {
;1642:						return va("%i/%i", info->wins, info->losses);
;1643:					} else if (info->infoValid && info->team == TEAM_SPECTATOR ) {
;1644:						return "Spectator";
;1645:					} else {
;1646:						return "";
;1647:					}
;1648:				} else {
;1649:					if (info->teamLeader) {
;1650:						return "Leader";
;1651:					}
;1652:				}
;1653:			break;
;1654:			case 3:
;1655:				return info->name;
;1656:			break;
;1657:			case 4:
;1658:				return va("%i", info->score);
;1659:			break;
;1660:			case 5:
;1661:				return va("%4i", sp->time);
;1662:			break;
;1663:			case 6:
;1664:				if ( sp->ping == -1 ) {
;1665:					return "connecting";
;1666:				} 
;1667:				return va("%4i", sp->ping);
;1668:			break;
;1669:		}
;1670:	}
;1671:
;1672:	return "";
;1673:}
;1674:
;1675:static qhandle_t CG_FeederItemImage(float feederID, int index) {
;1676:	return 0;
;1677:}
;1678:
;1679:static void CG_FeederSelection(float feederID, int index) {
;1680:	if ( cgs.gametype >= GT_TEAM ) {
;1681:		int i, count;
;1682:		int team = (feederID == FEEDER_REDTEAM_LIST) ? TEAM_RED : TEAM_BLUE;
;1683:		count = 0;
;1684:		for (i = 0; i < cg.numScores; i++) {
;1685:			if (cg.scores[i].team == team) {
;1686:				if (index == count) {
;1687:					cg.selectedScore = i;
;1688:				}
;1689:				count++;
;1690:			}
;1691:		}
;1692:	} else {
;1693:		cg.selectedScore = index;
;1694:	}
;1695:}
;1696:#endif
;1697:
;1698:#ifdef MISSIONPACK // bk001204 - only needed there
;1699:static float CG_Cvar_Get(const char *cvar) {
;1700:	char buff[128];
;1701:	memset(buff, 0, sizeof(buff));
;1702:	trap_Cvar_VariableStringBuffer(cvar, buff, sizeof(buff));
;1703:	return atof(buff);
;1704:}
;1705:#endif
;1706:
;1707:#ifdef MISSIONPACK
;1708:void CG_Text_PaintWithCursor(float x, float y, float scale, vec4_t color, const char *text, int cursorPos, char cursor, int limit, int style) {
;1709:	CG_Text_Paint(x, y, scale, color, text, 0, limit, style);
;1710:}
;1711:
;1712:static int CG_OwnerDrawWidth(int ownerDraw, float scale) {
;1713:	switch (ownerDraw) {
;1714:	  case CG_GAME_TYPE:
;1715:			return CG_Text_Width(CG_GameTypeString(), scale, 0);
;1716:	  case CG_GAME_STATUS:
;1717:			return CG_Text_Width(CG_GetGameStatusText(), scale, 0);
;1718:			break;
;1719:	  case CG_KILLER:
;1720:			return CG_Text_Width(CG_GetKillerText(), scale, 0);
;1721:			break;
;1722:	  case CG_RED_NAME:
;1723:			return CG_Text_Width(cg_redTeamName.string, scale, 0);
;1724:			break;
;1725:	  case CG_BLUE_NAME:
;1726:			return CG_Text_Width(cg_blueTeamName.string, scale, 0);
;1727:			break;
;1728:
;1729:
;1730:	}
;1731:	return 0;
;1732:}
;1733:
;1734:static int CG_PlayCinematic(const char *name, float x, float y, float w, float h) {
;1735:  return trap_CIN_PlayCinematic(name, x, y, w, h, CIN_loop);
;1736:}
;1737:
;1738:static void CG_StopCinematic(int handle) {
;1739:  trap_CIN_StopCinematic(handle);
;1740:}
;1741:
;1742:static void CG_DrawCinematic(int handle, float x, float y, float w, float h) {
;1743:  trap_CIN_SetExtents(handle, x, y, w, h);
;1744:  trap_CIN_DrawCinematic(handle);
;1745:}
;1746:
;1747:static void CG_RunCinematicFrame(int handle) {
;1748:  trap_CIN_RunCinematic(handle);
;1749:}
;1750:
;1751:/*
;1752:=================
;1753:CG_LoadHudMenu();
;1754:
;1755:=================
;1756:*/
;1757:void CG_LoadHudMenu() {
;1758:	char buff[1024];
;1759:	const char *hudSet;
;1760:
;1761:	cgDC.registerShaderNoMip = &trap_R_RegisterShaderNoMip;
;1762:	cgDC.setColor = &trap_R_SetColor;
;1763:	cgDC.drawHandlePic = &CG_DrawPic;
;1764:	cgDC.drawStretchPic = &trap_R_DrawStretchPic;
;1765:	cgDC.drawText = &CG_Text_Paint;
;1766:	cgDC.textWidth = &CG_Text_Width;
;1767:	cgDC.textHeight = &CG_Text_Height;
;1768:	cgDC.registerModel = &trap_R_RegisterModel;
;1769:	cgDC.modelBounds = &trap_R_ModelBounds;
;1770:	cgDC.fillRect = &CG_FillRect;
;1771:	cgDC.drawRect = &CG_DrawRect;   
;1772:	cgDC.drawSides = &CG_DrawSides;
;1773:	cgDC.drawTopBottom = &CG_DrawTopBottom;
;1774:	cgDC.clearScene = &trap_R_ClearScene;
;1775:	cgDC.addRefEntityToScene = &trap_R_AddRefEntityToScene;
;1776:	cgDC.renderScene = &trap_R_RenderScene;
;1777:	cgDC.registerFont = &trap_R_RegisterFont;
;1778:	cgDC.ownerDrawItem = &CG_OwnerDraw;
;1779:	cgDC.getValue = &CG_GetValue;
;1780:	cgDC.ownerDrawVisible = &CG_OwnerDrawVisible;
;1781:	cgDC.runScript = &CG_RunMenuScript;
;1782:	cgDC.getTeamColor = &CG_GetTeamColor;
;1783:	cgDC.setCVar = trap_Cvar_Set;
;1784:	cgDC.getCVarString = trap_Cvar_VariableStringBuffer;
;1785:	cgDC.getCVarValue = CG_Cvar_Get;
;1786:	cgDC.drawTextWithCursor = &CG_Text_PaintWithCursor;
;1787:	//cgDC.setOverstrikeMode = &trap_Key_SetOverstrikeMode;
;1788:	//cgDC.getOverstrikeMode = &trap_Key_GetOverstrikeMode;
;1789:	cgDC.startLocalSound = &trap_S_StartLocalSound;
;1790:	cgDC.ownerDrawHandleKey = &CG_OwnerDrawHandleKey;
;1791:	cgDC.feederCount = &CG_FeederCount;
;1792:	cgDC.feederItemImage = &CG_FeederItemImage;
;1793:	cgDC.feederItemText = &CG_FeederItemText;
;1794:	cgDC.feederSelection = &CG_FeederSelection;
;1795:	//cgDC.setBinding = &trap_Key_SetBinding;
;1796:	//cgDC.getBindingBuf = &trap_Key_GetBindingBuf;
;1797:	//cgDC.keynumToStringBuf = &trap_Key_KeynumToStringBuf;
;1798:	//cgDC.executeText = &trap_Cmd_ExecuteText;
;1799:	cgDC.Error = &Com_Error; 
;1800:	cgDC.Print = &Com_Printf; 
;1801:	cgDC.ownerDrawWidth = &CG_OwnerDrawWidth;
;1802:	//cgDC.Pause = &CG_Pause;
;1803:	cgDC.registerSound = &trap_S_RegisterSound;
;1804:	cgDC.startBackgroundTrack = &trap_S_StartBackgroundTrack;
;1805:	cgDC.stopBackgroundTrack = &trap_S_StopBackgroundTrack;
;1806:	cgDC.playCinematic = &CG_PlayCinematic;
;1807:	cgDC.stopCinematic = &CG_StopCinematic;
;1808:	cgDC.drawCinematic = &CG_DrawCinematic;
;1809:	cgDC.runCinematicFrame = &CG_RunCinematicFrame;
;1810:	
;1811:	Init_Display(&cgDC);
;1812:
;1813:	Menu_Reset();
;1814:	
;1815:	trap_Cvar_VariableStringBuffer("cg_hudFiles", buff, sizeof(buff));
;1816:	hudSet = buff;
;1817:	if (hudSet[0] == '\0') {
;1818:		hudSet = "ui/hud.txt";
;1819:	}
;1820:
;1821:	CG_LoadMenus(hudSet);
;1822:}
;1823:
;1824:void CG_AssetCache() {
;1825:	//if (Assets.textFont == NULL) {
;1826:	//  trap_R_RegisterFont("fonts/arial.ttf", 72, &Assets.textFont);
;1827:	//}
;1828:	//Assets.background = trap_R_RegisterShaderNoMip( ASSET_BACKGROUND );
;1829:	//Com_Printf("Menu Size: %i bytes\n", sizeof(Menus));
;1830:	cgDC.Assets.gradientBar = trap_R_RegisterShaderNoMip( ASSET_GRADIENTBAR );
;1831:	cgDC.Assets.fxBasePic = trap_R_RegisterShaderNoMip( ART_FX_BASE );
;1832:	cgDC.Assets.fxPic[0] = trap_R_RegisterShaderNoMip( ART_FX_RED );
;1833:	cgDC.Assets.fxPic[1] = trap_R_RegisterShaderNoMip( ART_FX_YELLOW );
;1834:	cgDC.Assets.fxPic[2] = trap_R_RegisterShaderNoMip( ART_FX_GREEN );
;1835:	cgDC.Assets.fxPic[3] = trap_R_RegisterShaderNoMip( ART_FX_TEAL );
;1836:	cgDC.Assets.fxPic[4] = trap_R_RegisterShaderNoMip( ART_FX_BLUE );
;1837:	cgDC.Assets.fxPic[5] = trap_R_RegisterShaderNoMip( ART_FX_CYAN );
;1838:	cgDC.Assets.fxPic[6] = trap_R_RegisterShaderNoMip( ART_FX_WHITE );
;1839:	cgDC.Assets.scrollBar = trap_R_RegisterShaderNoMip( ASSET_SCROLLBAR );
;1840:	cgDC.Assets.scrollBarArrowDown = trap_R_RegisterShaderNoMip( ASSET_SCROLLBAR_ARROWDOWN );
;1841:	cgDC.Assets.scrollBarArrowUp = trap_R_RegisterShaderNoMip( ASSET_SCROLLBAR_ARROWUP );
;1842:	cgDC.Assets.scrollBarArrowLeft = trap_R_RegisterShaderNoMip( ASSET_SCROLLBAR_ARROWLEFT );
;1843:	cgDC.Assets.scrollBarArrowRight = trap_R_RegisterShaderNoMip( ASSET_SCROLLBAR_ARROWRIGHT );
;1844:	cgDC.Assets.scrollBarThumb = trap_R_RegisterShaderNoMip( ASSET_SCROLL_THUMB );
;1845:	cgDC.Assets.sliderBar = trap_R_RegisterShaderNoMip( ASSET_SLIDER_BAR );
;1846:	cgDC.Assets.sliderThumb = trap_R_RegisterShaderNoMip( ASSET_SLIDER_THUMB );
;1847:}
;1848:#endif
;1849:/*
;1850:=================
;1851:CG_Init
;1852:
;1853:Called after every level change or subsystem restart
;1854:Will perform callbacks to make the loading info screen update.
;1855:=================
;1856:*/
;1857:void CG_Init( int serverMessageNum, int serverCommandSequence, int clientNum ) {
line 1861
;1858:	const char	*s;
;1859:
;1860:	// clear everything
;1861:	memset( &cgs, 0, sizeof( cgs ) );
ADDRGP4 cgs
ARGP4
CNSTI4 0
ARGI4
CNSTI4 153364
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1862
;1862:	memset( &cg, 0, sizeof( cg ) );
ADDRGP4 cg
ARGP4
CNSTI4 0
ARGI4
CNSTI4 124992
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1863
;1863:	memset( cg_entities, 0, sizeof(cg_entities) );
ADDRGP4 cg_entities
ARGP4
CNSTI4 0
ARGI4
CNSTI4 745472
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1864
;1864:	memset( cg_weapons, 0, sizeof(cg_weapons) );
ADDRGP4 cg_weapons
ARGP4
CNSTI4 0
ARGI4
CNSTI4 2176
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1865
;1865:	memset( cg_items, 0, sizeof(cg_items) );
ADDRGP4 cg_items
ARGP4
CNSTI4 0
ARGI4
CNSTI4 6144
ARGI4
ADDRGP4 memset
CALLP4
pop
line 1867
;1866:
;1867:	cg.clientNum = clientNum;
ADDRGP4 cg+4
ADDRFP4 8
INDIRI4
ASGNI4
line 1869
;1868:
;1869:	cgs.processedSnapshotNum = serverMessageNum;
ADDRGP4 cgs+31448
ADDRFP4 0
INDIRI4
ASGNI4
line 1870
;1870:	cgs.serverCommandSequence = serverCommandSequence;
ADDRGP4 cgs+31444
ADDRFP4 4
INDIRI4
ASGNI4
line 1873
;1871:
;1872:	// load a few needed things before we do any screen updates
;1873:	cgs.media.charsetShader		= trap_R_RegisterShader( "gfx/2d/bigchars" );
ADDRGP4 $924
ARGP4
ADDRLP4 4
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+152340
ADDRLP4 4
INDIRI4
ASGNI4
line 1874
;1874:	cgs.media.whiteShader		= trap_R_RegisterShader( "white" );
ADDRGP4 $927
ARGP4
ADDRLP4 8
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRGP4 cgs+152340+16
ADDRLP4 8
INDIRI4
ASGNI4
line 1875
;1875:	cgs.media.charsetProp		= trap_R_RegisterShaderNoMip( "menu/art/font1_prop.tga" );
ADDRGP4 $930
ARGP4
ADDRLP4 12
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+152340+4
ADDRLP4 12
INDIRI4
ASGNI4
line 1876
;1876:	cgs.media.charsetPropGlow	= trap_R_RegisterShaderNoMip( "menu/art/font1_prop_glo.tga" );
ADDRGP4 $933
ARGP4
ADDRLP4 16
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+152340+8
ADDRLP4 16
INDIRI4
ASGNI4
line 1877
;1877:	cgs.media.charsetPropB		= trap_R_RegisterShaderNoMip( "menu/art/font2_prop.tga" );
ADDRGP4 $936
ARGP4
ADDRLP4 20
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 cgs+152340+12
ADDRLP4 20
INDIRI4
ASGNI4
line 1879
;1878:
;1879:	CG_RegisterCvars();
ADDRGP4 CG_RegisterCvars
CALLV
pop
line 1881
;1880:
;1881:	CG_InitConsoleCommands();
ADDRGP4 CG_InitConsoleCommands
CALLV
pop
line 1883
;1882:
;1883:	cg.weaponSelect = WP_MACHINEGUN;
ADDRGP4 cg+108944
CNSTI4 2
ASGNI4
line 1885
;1884:
;1885:	cgs.redflag = cgs.blueflag = -1; // For compatibily, default to unset for
ADDRLP4 24
CNSTI4 -1
ASGNI4
ADDRGP4 cgs+34812
ADDRLP4 24
INDIRI4
ASGNI4
ADDRGP4 cgs+34808
ADDRLP4 24
INDIRI4
ASGNI4
line 1886
;1886:	cgs.flagStatus = -1;
ADDRGP4 cgs+34816
CNSTI4 -1
ASGNI4
line 1890
;1887:	// old servers
;1888:
;1889:	// get the rendering configuration from the client system
;1890:	trap_GetGlconfig( &cgs.glconfig );
ADDRGP4 cgs+20100
ARGP4
ADDRGP4 trap_GetGlconfig
CALLV
pop
line 1891
;1891:	cgs.screenXScale = cgs.glconfig.vidWidth / 640.0;
ADDRGP4 cgs+31432
ADDRGP4 cgs+20100+11304
INDIRI4
CVIF4 4
CNSTF4 1142947840
DIVF4
ASGNF4
line 1892
;1892:	cgs.screenYScale = cgs.glconfig.vidHeight / 480.0;
ADDRGP4 cgs+31436
ADDRGP4 cgs+20100+11308
INDIRI4
CVIF4 4
CNSTF4 1139802112
DIVF4
ASGNF4
line 1895
;1893:
;1894:	// get the gamestate from the client system
;1895:	trap_GetGameState( &cgs.gameState );
ADDRGP4 cgs
ARGP4
ADDRGP4 trap_GetGameState
CALLV
pop
line 1898
;1896:
;1897:	// check version
;1898:	s = CG_ConfigString( CS_GAME_VERSION );
CNSTI4 20
ARGI4
ADDRLP4 28
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 28
INDIRP4
ASGNP4
line 1899
;1899:	if ( strcmp( s, GAME_VERSION ) ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $950
ARGP4
ADDRLP4 32
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $948
line 1900
;1900:		CG_Error( "Client/Server game mismatch: %s/%s", GAME_VERSION, s );
ADDRGP4 $951
ARGP4
ADDRGP4 $950
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 1901
;1901:	}
LABELV $948
line 1903
;1902:
;1903:	s = CG_ConfigString( CS_LEVEL_START_TIME );
CNSTI4 21
ARGI4
ADDRLP4 36
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 36
INDIRP4
ASGNP4
line 1904
;1904:	cgs.levelStartTime = atoi( s );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 cgs+34796
ADDRLP4 40
INDIRI4
ASGNI4
line 1906
;1905:
;1906:	CG_ParseServerinfo();
ADDRGP4 CG_ParseServerinfo
CALLV
pop
line 1909
;1907:
;1908:	// load the new map
;1909:	CG_LoadingString( "collision map" );
ADDRGP4 $953
ARGP4
ADDRGP4 CG_LoadingString
CALLV
pop
line 1911
;1910:
;1911:	trap_CM_LoadMap( cgs.mapname );
ADDRGP4 cgs+31484
ARGP4
ADDRGP4 trap_CM_LoadMap
CALLV
pop
line 1917
;1912:
;1913:#ifdef MISSIONPACK
;1914:	String_Init();
;1915:#endif
;1916:
;1917:	cg.loading = qtrue;		// force players to load instead of defer
ADDRGP4 cg+20
CNSTI4 1
ASGNI4
line 1919
;1918:
;1919:	CG_LoadingString( "sounds" );
ADDRGP4 $956
ARGP4
ADDRGP4 CG_LoadingString
CALLV
pop
line 1921
;1920:
;1921:	CG_RegisterSounds();
ADDRGP4 CG_RegisterSounds
CALLV
pop
line 1923
;1922:
;1923:	CG_LoadingString( "graphics" );
ADDRGP4 $957
ARGP4
ADDRGP4 CG_LoadingString
CALLV
pop
line 1925
;1924:
;1925:	CG_RegisterGraphics();
ADDRGP4 CG_RegisterGraphics
CALLV
pop
line 1927
;1926:
;1927:	CG_LoadingString( "clients" );
ADDRGP4 $958
ARGP4
ADDRGP4 CG_LoadingString
CALLV
pop
line 1929
;1928:
;1929:	CG_RegisterClients();		// if low on memory, some clients will be deferred
ADDRGP4 CG_RegisterClients
CALLV
pop
line 1936
;1930:
;1931:#ifdef MISSIONPACK
;1932:	CG_AssetCache();
;1933:	CG_LoadHudMenu();      // load new hud stuff
;1934:#endif
;1935:
;1936:	cg.loading = qfalse;	// future players will be deferred
ADDRGP4 cg+20
CNSTI4 0
ASGNI4
line 1938
;1937:
;1938:	CG_InitLocalEntities();
ADDRGP4 CG_InitLocalEntities
CALLV
pop
line 1940
;1939:
;1940:	CG_InitMarkPolys();
ADDRGP4 CG_InitMarkPolys
CALLV
pop
line 1943
;1941:
;1942:	// remove the last loading update
;1943:	cg.infoScreenText[0] = 0;
ADDRGP4 cg+109436
CNSTI1 0
ASGNI1
line 1946
;1944:
;1945:	// Make sure we have update values (scores)
;1946:	CG_SetConfigValues();
ADDRGP4 CG_SetConfigValues
CALLV
pop
line 1948
;1947:
;1948:	CG_StartMusic();
ADDRGP4 CG_StartMusic
CALLV
pop
line 1950
;1949:
;1950:	CG_LoadingString( "" );
ADDRGP4 $961
ARGP4
ADDRGP4 CG_LoadingString
CALLV
pop
line 1956
;1951:
;1952:#ifdef MISSIONPACK
;1953:	CG_InitTeamChat();
;1954:#endif
;1955:
;1956:	CG_ShaderStateChanged();
ADDRGP4 CG_ShaderStateChanged
CALLV
pop
line 1958
;1957:
;1958:	trap_S_ClearLoopingSounds( qtrue );
CNSTI4 1
ARGI4
ADDRGP4 trap_S_ClearLoopingSounds
CALLV
pop
line 1959
;1959:}
LABELV $919
endproc CG_Init 44 12
export CG_Shutdown
proc CG_Shutdown 0 0
line 1968
;1960:
;1961:/*
;1962:=================
;1963:CG_Shutdown
;1964:
;1965:Called before every level change or subsystem restart
;1966:=================
;1967:*/
;1968:void CG_Shutdown( void ) {
line 1971
;1969:	// some mods may need to do cleanup work here,
;1970:	// like closing files or archiving session data
;1971:}
LABELV $962
endproc CG_Shutdown 0 0
export CG_EventHandling
proc CG_EventHandling 0 0
line 1984
;1972:
;1973:
;1974:/*
;1975:==================
;1976:CG_EventHandling
;1977:==================
;1978: type 0 - no event handling
;1979:      1 - team menu
;1980:      2 - hud editor
;1981:
;1982:*/
;1983:#ifndef MISSIONPACK
;1984:void CG_EventHandling(int type) {
line 1985
;1985:}
LABELV $963
endproc CG_EventHandling 0 0
export CG_KeyEvent
proc CG_KeyEvent 0 0
line 1989
;1986:
;1987:
;1988:
;1989:void CG_KeyEvent(int key, qboolean down) {
line 1990
;1990:}
LABELV $964
endproc CG_KeyEvent 0 0
export CG_MouseEvent
proc CG_MouseEvent 0 0
line 1992
;1991:
;1992:void CG_MouseEvent(int x, int y) {
line 1993
;1993:}
LABELV $965
endproc CG_MouseEvent 0 0
bss
export cg_pmove_msec
align 4
LABELV cg_pmove_msec
skip 272
export cg_hudFiles
align 4
LABELV cg_hudFiles
skip 272
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
import CG_DrawInformation
import CG_LoadingClient
import CG_LoadingItem
import CG_LoadingString
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
import CG_GetSelectedScore
import CG_SetScoreSelection
import CG_RankRunFrame
import CG_LoadMenus
export cg_trueLightning
align 4
LABELV cg_trueLightning
skip 272
export cg_oldPlasma
align 4
LABELV cg_oldPlasma
skip 272
export cg_oldRocket
align 4
LABELV cg_oldRocket
skip 272
export cg_oldRail
align 4
LABELV cg_oldRail
skip 272
export cg_noProjectileTrail
align 4
LABELV cg_noProjectileTrail
skip 272
export cg_noTaunt
align 4
LABELV cg_noTaunt
skip 272
export cg_bigFont
align 4
LABELV cg_bigFont
skip 272
export cg_smallFont
align 4
LABELV cg_smallFont
skip 272
export cg_cameraMode
align 4
LABELV cg_cameraMode
skip 272
export cg_timescale
align 4
LABELV cg_timescale
skip 272
export cg_timescaleFadeSpeed
align 4
LABELV cg_timescaleFadeSpeed
skip 272
export cg_timescaleFadeEnd
align 4
LABELV cg_timescaleFadeEnd
skip 272
export cg_cameraOrbitDelay
align 4
LABELV cg_cameraOrbitDelay
skip 272
export cg_cameraOrbit
align 4
LABELV cg_cameraOrbit
skip 272
export pmove_msec
align 4
LABELV pmove_msec
skip 272
export pmove_fixed
align 4
LABELV pmove_fixed
skip 272
export cg_smoothClients
align 4
LABELV cg_smoothClients
skip 272
export cg_scorePlum
align 4
LABELV cg_scorePlum
skip 272
export cg_noVoiceText
align 4
LABELV cg_noVoiceText
skip 272
export cg_noVoiceChats
align 4
LABELV cg_noVoiceChats
skip 272
export cg_teamChatsOnly
align 4
LABELV cg_teamChatsOnly
skip 272
export cg_drawFriend
align 4
LABELV cg_drawFriend
skip 272
export cg_deferPlayers
align 4
LABELV cg_deferPlayers
skip 272
export cg_predictItems
align 4
LABELV cg_predictItems
skip 272
export cg_blood
align 4
LABELV cg_blood
skip 272
export cg_paused
align 4
LABELV cg_paused
skip 272
export cg_buildScript
align 4
LABELV cg_buildScript
skip 272
export cg_forceModel
align 4
LABELV cg_forceModel
skip 272
export cg_stats
align 4
LABELV cg_stats
skip 272
export cg_teamChatHeight
align 4
LABELV cg_teamChatHeight
skip 272
export cg_teamChatTime
align 4
LABELV cg_teamChatTime
skip 272
export cg_synchronousClients
align 4
LABELV cg_synchronousClients
skip 272
export cg_drawAttacker
align 4
LABELV cg_drawAttacker
skip 272
export cg_lagometer
align 4
LABELV cg_lagometer
skip 272
export cg_stereoSeparation
align 4
LABELV cg_stereoSeparation
skip 272
export cg_thirdPerson
align 4
LABELV cg_thirdPerson
skip 272
export cg_thirdPersonAngle
align 4
LABELV cg_thirdPersonAngle
skip 272
export cg_thirdPersonRange
align 4
LABELV cg_thirdPersonRange
skip 272
export cg_zoomFov
align 4
LABELV cg_zoomFov
skip 272
export cg_fov
align 4
LABELV cg_fov
skip 272
export cg_simpleItems
align 4
LABELV cg_simpleItems
skip 272
export cg_ignore
align 4
LABELV cg_ignore
skip 272
export cg_autoswitch
align 4
LABELV cg_autoswitch
skip 272
export cg_tracerLength
align 4
LABELV cg_tracerLength
skip 272
export cg_tracerWidth
align 4
LABELV cg_tracerWidth
skip 272
export cg_tracerChance
align 4
LABELV cg_tracerChance
skip 272
export cg_viewsize
align 4
LABELV cg_viewsize
skip 272
export cg_drawGun
align 4
LABELV cg_drawGun
skip 272
export cg_gun_z
align 4
LABELV cg_gun_z
skip 272
export cg_gun_y
align 4
LABELV cg_gun_y
skip 272
export cg_gun_x
align 4
LABELV cg_gun_x
skip 272
export cg_gun_frame
align 4
LABELV cg_gun_frame
skip 272
export cg_brassTime
align 4
LABELV cg_brassTime
skip 272
export cg_addMarks
align 4
LABELV cg_addMarks
skip 272
export cg_footsteps
align 4
LABELV cg_footsteps
skip 272
export cg_showmiss
align 4
LABELV cg_showmiss
skip 272
export cg_noPlayerAnims
align 4
LABELV cg_noPlayerAnims
skip 272
export cg_nopredict
align 4
LABELV cg_nopredict
skip 272
export cg_errorDecay
align 4
LABELV cg_errorDecay
skip 272
export cg_railTrailTime
align 4
LABELV cg_railTrailTime
skip 272
export cg_debugEvents
align 4
LABELV cg_debugEvents
skip 272
export cg_debugPosition
align 4
LABELV cg_debugPosition
skip 272
export cg_debugAnim
align 4
LABELV cg_debugAnim
skip 272
export cg_animSpeed
align 4
LABELV cg_animSpeed
skip 272
export cg_draw2D
align 4
LABELV cg_draw2D
skip 272
export cg_drawStatus
align 4
LABELV cg_drawStatus
skip 272
export cg_crosshairHealth
align 4
LABELV cg_crosshairHealth
skip 272
export cg_crosshairSize
align 4
LABELV cg_crosshairSize
skip 272
export cg_crosshairY
align 4
LABELV cg_crosshairY
skip 272
export cg_crosshairX
align 4
LABELV cg_crosshairX
skip 272
export cg_teamOverlayUserinfo
align 4
LABELV cg_teamOverlayUserinfo
skip 272
export cg_drawTeamOverlay
align 4
LABELV cg_drawTeamOverlay
skip 272
export cg_drawRewards
align 4
LABELV cg_drawRewards
skip 272
export cg_drawCrosshairNames
align 4
LABELV cg_drawCrosshairNames
skip 272
export cg_drawCrosshair
align 4
LABELV cg_drawCrosshair
skip 272
export cg_drawAmmoWarning
align 4
LABELV cg_drawAmmoWarning
skip 272
export cg_drawIcons
align 4
LABELV cg_drawIcons
skip 272
export cg_draw3dIcons
align 4
LABELV cg_draw3dIcons
skip 272
export cg_drawSnapshot
align 4
LABELV cg_drawSnapshot
skip 272
export cg_drawFPS
align 4
LABELV cg_drawFPS
skip 272
export cg_drawTimer
align 4
LABELV cg_drawTimer
skip 272
export cg_gibs
align 4
LABELV cg_gibs
skip 272
export cg_shadows
align 4
LABELV cg_shadows
skip 272
export cg_swingSpeed
align 4
LABELV cg_swingSpeed
skip 272
export cg_bobroll
align 4
LABELV cg_bobroll
skip 272
export cg_bobpitch
align 4
LABELV cg_bobpitch
skip 272
export cg_bobup
align 4
LABELV cg_bobup
skip 272
export cg_runroll
align 4
LABELV cg_runroll
skip 272
export cg_runpitch
align 4
LABELV cg_runpitch
skip 272
export cg_centertime
align 4
LABELV cg_centertime
skip 272
import cg_markPolys
export cg_items
align 4
LABELV cg_items
skip 6144
export cg_weapons
align 4
LABELV cg_weapons
skip 2176
export cg_entities
align 4
LABELV cg_entities
skip 745472
export cg
align 4
LABELV cg
skip 124992
export cgs
align 4
LABELV cgs
skip 153364
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
LABELV $961
byte 1 0
align 1
LABELV $958
byte 1 99
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $957
byte 1 103
byte 1 114
byte 1 97
byte 1 112
byte 1 104
byte 1 105
byte 1 99
byte 1 115
byte 1 0
align 1
LABELV $956
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 115
byte 1 0
align 1
LABELV $953
byte 1 99
byte 1 111
byte 1 108
byte 1 108
byte 1 105
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 109
byte 1 97
byte 1 112
byte 1 0
align 1
LABELV $951
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 47
byte 1 83
byte 1 101
byte 1 114
byte 1 118
byte 1 101
byte 1 114
byte 1 32
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 32
byte 1 109
byte 1 105
byte 1 115
byte 1 109
byte 1 97
byte 1 116
byte 1 99
byte 1 104
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 47
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $950
byte 1 98
byte 1 97
byte 1 115
byte 1 101
byte 1 113
byte 1 51
byte 1 45
byte 1 49
byte 1 0
align 1
LABELV $936
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 102
byte 1 111
byte 1 110
byte 1 116
byte 1 50
byte 1 95
byte 1 112
byte 1 114
byte 1 111
byte 1 112
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $933
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 102
byte 1 111
byte 1 110
byte 1 116
byte 1 49
byte 1 95
byte 1 112
byte 1 114
byte 1 111
byte 1 112
byte 1 95
byte 1 103
byte 1 108
byte 1 111
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $930
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 102
byte 1 111
byte 1 110
byte 1 116
byte 1 49
byte 1 95
byte 1 112
byte 1 114
byte 1 111
byte 1 112
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $927
byte 1 119
byte 1 104
byte 1 105
byte 1 116
byte 1 101
byte 1 0
align 1
LABELV $924
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 98
byte 1 105
byte 1 103
byte 1 99
byte 1 104
byte 1 97
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $916
byte 1 67
byte 1 71
byte 1 95
byte 1 67
byte 1 111
byte 1 110
byte 1 102
byte 1 105
byte 1 103
byte 1 83
byte 1 116
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 58
byte 1 32
byte 1 98
byte 1 97
byte 1 100
byte 1 32
byte 1 105
byte 1 110
byte 1 100
byte 1 101
byte 1 120
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $891
byte 1 37
byte 1 115
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 32
byte 1 0
align 1
LABELV $863
byte 1 42
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $856
byte 1 98
byte 1 108
byte 1 111
byte 1 111
byte 1 100
byte 1 77
byte 1 97
byte 1 114
byte 1 107
byte 1 0
align 1
LABELV $853
byte 1 119
byte 1 97
byte 1 107
byte 1 101
byte 1 0
align 1
LABELV $850
byte 1 109
byte 1 97
byte 1 114
byte 1 107
byte 1 83
byte 1 104
byte 1 97
byte 1 100
byte 1 111
byte 1 119
byte 1 0
align 1
LABELV $847
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 100
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 115
byte 1 109
byte 1 97
byte 1 95
byte 1 109
byte 1 114
byte 1 107
byte 1 0
align 1
LABELV $844
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 100
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 47
byte 1 104
byte 1 111
byte 1 108
byte 1 101
byte 1 95
byte 1 108
byte 1 103
byte 1 95
byte 1 109
byte 1 114
byte 1 107
byte 1 0
align 1
LABELV $841
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 100
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 47
byte 1 98
byte 1 117
byte 1 114
byte 1 110
byte 1 95
byte 1 109
byte 1 101
byte 1 100
byte 1 95
byte 1 109
byte 1 114
byte 1 107
byte 1 0
align 1
LABELV $838
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 100
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 47
byte 1 98
byte 1 117
byte 1 108
byte 1 108
byte 1 101
byte 1 116
byte 1 95
byte 1 109
byte 1 114
byte 1 107
byte 1 0
align 1
LABELV $827
byte 1 109
byte 1 101
byte 1 100
byte 1 97
byte 1 108
byte 1 95
byte 1 99
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $824
byte 1 109
byte 1 101
byte 1 100
byte 1 97
byte 1 108
byte 1 95
byte 1 97
byte 1 115
byte 1 115
byte 1 105
byte 1 115
byte 1 116
byte 1 0
align 1
LABELV $821
byte 1 109
byte 1 101
byte 1 100
byte 1 97
byte 1 108
byte 1 95
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $818
byte 1 109
byte 1 101
byte 1 100
byte 1 97
byte 1 108
byte 1 95
byte 1 103
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 108
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $815
byte 1 109
byte 1 101
byte 1 100
byte 1 97
byte 1 108
byte 1 95
byte 1 101
byte 1 120
byte 1 99
byte 1 101
byte 1 108
byte 1 108
byte 1 101
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $812
byte 1 109
byte 1 101
byte 1 100
byte 1 97
byte 1 108
byte 1 95
byte 1 105
byte 1 109
byte 1 112
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 105
byte 1 118
byte 1 101
byte 1 0
align 1
LABELV $809
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 115
byte 1 104
byte 1 105
byte 1 101
byte 1 108
byte 1 100
byte 1 47
byte 1 115
byte 1 104
byte 1 105
byte 1 101
byte 1 108
byte 1 100
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $806
byte 1 116
byte 1 101
byte 1 108
byte 1 101
byte 1 112
byte 1 111
byte 1 114
byte 1 116
byte 1 69
byte 1 102
byte 1 102
byte 1 101
byte 1 99
byte 1 116
byte 1 0
align 1
LABELV $803
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 47
byte 1 116
byte 1 101
byte 1 108
byte 1 101
byte 1 112
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $800
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 104
byte 1 105
byte 1 116
byte 1 115
byte 1 47
byte 1 98
byte 1 111
byte 1 111
byte 1 109
byte 1 48
byte 1 49
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $797
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 104
byte 1 105
byte 1 116
byte 1 115
byte 1 47
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 48
byte 1 50
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $794
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 104
byte 1 105
byte 1 116
byte 1 115
byte 1 47
byte 1 98
byte 1 117
byte 1 108
byte 1 108
byte 1 101
byte 1 116
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $791
byte 1 98
byte 1 108
byte 1 111
byte 1 111
byte 1 100
byte 1 69
byte 1 120
byte 1 112
byte 1 108
byte 1 111
byte 1 115
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $788
byte 1 115
byte 1 112
byte 1 114
byte 1 105
byte 1 116
byte 1 101
byte 1 115
byte 1 47
byte 1 98
byte 1 97
byte 1 108
byte 1 108
byte 1 111
byte 1 111
byte 1 110
byte 1 51
byte 1 0
align 1
LABELV $783
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 115
byte 1 47
byte 1 98
byte 1 114
byte 1 97
byte 1 105
byte 1 110
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $780
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 115
byte 1 47
byte 1 115
byte 1 107
byte 1 117
byte 1 108
byte 1 108
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $777
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 115
byte 1 47
byte 1 108
byte 1 101
byte 1 103
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $774
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 115
byte 1 47
byte 1 105
byte 1 110
byte 1 116
byte 1 101
byte 1 115
byte 1 116
byte 1 105
byte 1 110
byte 1 101
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $771
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 115
byte 1 47
byte 1 102
byte 1 111
byte 1 114
byte 1 101
byte 1 97
byte 1 114
byte 1 109
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $768
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 115
byte 1 47
byte 1 102
byte 1 111
byte 1 111
byte 1 116
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $765
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 115
byte 1 47
byte 1 102
byte 1 105
byte 1 115
byte 1 116
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $762
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 115
byte 1 47
byte 1 99
byte 1 104
byte 1 101
byte 1 115
byte 1 116
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $759
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 115
byte 1 47
byte 1 97
byte 1 114
byte 1 109
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $756
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 103
byte 1 105
byte 1 98
byte 1 115
byte 1 47
byte 1 97
byte 1 98
byte 1 100
byte 1 111
byte 1 109
byte 1 101
byte 1 110
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $753
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 50
byte 1 47
byte 1 115
byte 1 104
byte 1 101
byte 1 108
byte 1 108
byte 1 115
byte 1 47
byte 1 115
byte 1 95
byte 1 115
byte 1 104
byte 1 101
byte 1 108
byte 1 108
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $750
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 50
byte 1 47
byte 1 115
byte 1 104
byte 1 101
byte 1 108
byte 1 108
byte 1 115
byte 1 47
byte 1 109
byte 1 95
byte 1 115
byte 1 104
byte 1 101
byte 1 108
byte 1 108
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $747
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 114
byte 1 95
byte 1 121
byte 1 101
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 0
align 1
LABELV $744
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 97
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 47
byte 1 97
byte 1 114
byte 1 109
byte 1 111
byte 1 114
byte 1 95
byte 1 121
byte 1 101
byte 1 108
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $741
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 99
byte 1 111
byte 1 108
byte 1 111
byte 1 114
byte 1 98
byte 1 97
byte 1 114
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $738
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $735
byte 1 115
byte 1 112
byte 1 114
byte 1 105
byte 1 116
byte 1 101
byte 1 115
byte 1 47
byte 1 102
byte 1 111
byte 1 101
byte 1 0
align 1
LABELV $727
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 102
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 51
byte 1 0
align 1
LABELV $723
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 102
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 50
byte 1 0
align 1
LABELV $719
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 102
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 49
byte 1 0
align 1
LABELV $716
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 102
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $712
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 102
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 50
byte 1 0
align 1
LABELV $708
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 102
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 49
byte 1 0
align 1
LABELV $705
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 115
byte 1 47
byte 1 98
byte 1 95
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $702
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 115
byte 1 47
byte 1 114
byte 1 95
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $694
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 115
byte 1 107
byte 1 117
byte 1 108
byte 1 108
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 0
align 1
LABELV $691
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 115
byte 1 107
byte 1 117
byte 1 108
byte 1 108
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $688
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 111
byte 1 114
byte 1 98
byte 1 47
byte 1 98
byte 1 95
byte 1 111
byte 1 114
byte 1 98
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $685
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 115
byte 1 47
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 111
byte 1 114
byte 1 98
byte 1 47
byte 1 114
byte 1 95
byte 1 111
byte 1 114
byte 1 98
byte 1 46
byte 1 109
byte 1 100
byte 1 51
byte 1 0
align 1
LABELV $677
byte 1 104
byte 1 97
byte 1 115
byte 1 116
byte 1 101
byte 1 83
byte 1 109
byte 1 111
byte 1 107
byte 1 101
byte 1 80
byte 1 117
byte 1 102
byte 1 102
byte 1 0
align 1
LABELV $674
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 114
byte 1 101
byte 1 103
byte 1 101
byte 1 110
byte 1 0
align 1
LABELV $671
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 105
byte 1 110
byte 1 118
byte 1 105
byte 1 115
byte 1 105
byte 1 98
byte 1 105
byte 1 108
byte 1 105
byte 1 116
byte 1 121
byte 1 0
align 1
LABELV $668
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 87
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $665
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 98
byte 1 97
byte 1 116
byte 1 116
byte 1 108
byte 1 101
byte 1 83
byte 1 117
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $662
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 113
byte 1 117
byte 1 97
byte 1 100
byte 1 87
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $659
byte 1 112
byte 1 111
byte 1 119
byte 1 101
byte 1 114
byte 1 117
byte 1 112
byte 1 115
byte 1 47
byte 1 113
byte 1 117
byte 1 97
byte 1 100
byte 1 0
align 1
LABELV $656
byte 1 105
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 110
byte 1 111
byte 1 97
byte 1 109
byte 1 109
byte 1 111
byte 1 0
align 1
LABELV $653
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 116
byte 1 105
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $650
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 99
byte 1 114
byte 1 111
byte 1 115
byte 1 115
byte 1 104
byte 1 97
byte 1 105
byte 1 114
byte 1 37
byte 1 99
byte 1 0
align 1
LABELV $643
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 115
byte 1 101
byte 1 108
byte 1 101
byte 1 99
byte 1 116
byte 1 0
align 1
LABELV $640
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 109
byte 1 105
byte 1 115
byte 1 99
byte 1 47
byte 1 116
byte 1 114
byte 1 97
byte 1 99
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $637
byte 1 119
byte 1 97
byte 1 116
byte 1 101
byte 1 114
byte 1 66
byte 1 117
byte 1 98
byte 1 98
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $634
byte 1 100
byte 1 105
byte 1 115
byte 1 99
byte 1 111
byte 1 110
byte 1 110
byte 1 101
byte 1 99
byte 1 116
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $631
byte 1 108
byte 1 97
byte 1 103
byte 1 111
byte 1 109
byte 1 101
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $628
byte 1 98
byte 1 108
byte 1 111
byte 1 111
byte 1 100
byte 1 84
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 0
align 1
LABELV $625
byte 1 115
byte 1 112
byte 1 114
byte 1 105
byte 1 116
byte 1 101
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 115
byte 1 109
byte 1 97
byte 1 49
byte 1 0
align 1
LABELV $622
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 103
byte 1 117
byte 1 110
byte 1 83
byte 1 109
byte 1 111
byte 1 107
byte 1 101
byte 1 80
byte 1 117
byte 1 102
byte 1 102
byte 1 0
align 1
LABELV $619
byte 1 115
byte 1 109
byte 1 111
byte 1 107
byte 1 101
byte 1 80
byte 1 117
byte 1 102
byte 1 102
byte 1 82
byte 1 97
byte 1 103
byte 1 101
byte 1 80
byte 1 114
byte 1 111
byte 1 0
align 1
LABELV $616
byte 1 115
byte 1 109
byte 1 111
byte 1 107
byte 1 101
byte 1 80
byte 1 117
byte 1 102
byte 1 102
byte 1 0
align 1
LABELV $613
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 116
byte 1 97
byte 1 98
byte 1 47
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $610
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 116
byte 1 97
byte 1 98
byte 1 47
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $607
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 116
byte 1 97
byte 1 98
byte 1 47
byte 1 112
byte 1 105
byte 1 110
byte 1 103
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $604
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 116
byte 1 97
byte 1 98
byte 1 47
byte 1 110
byte 1 97
byte 1 109
byte 1 101
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $601
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 114
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $598
byte 1 118
byte 1 105
byte 1 101
byte 1 119
byte 1 66
byte 1 108
byte 1 111
byte 1 111
byte 1 100
byte 1 66
byte 1 108
byte 1 101
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $595
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 115
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 53
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $591
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 115
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 52
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $587
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 115
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 51
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $583
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 115
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 50
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $579
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 47
byte 1 97
byte 1 114
byte 1 116
byte 1 47
byte 1 115
byte 1 107
byte 1 105
byte 1 108
byte 1 108
byte 1 49
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $570
byte 1 103
byte 1 97
byte 1 109
byte 1 101
byte 1 32
byte 1 109
byte 1 101
byte 1 100
byte 1 105
byte 1 97
byte 1 0
align 1
LABELV $565
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 109
byte 1 105
byte 1 110
byte 1 117
byte 1 115
byte 1 95
byte 1 51
byte 1 50
byte 1 98
byte 1 0
align 1
LABELV $564
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 110
byte 1 105
byte 1 110
byte 1 101
byte 1 95
byte 1 51
byte 1 50
byte 1 98
byte 1 0
align 1
LABELV $563
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 101
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 95
byte 1 51
byte 1 50
byte 1 98
byte 1 0
align 1
LABELV $562
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 115
byte 1 101
byte 1 118
byte 1 101
byte 1 110
byte 1 95
byte 1 51
byte 1 50
byte 1 98
byte 1 0
align 1
LABELV $561
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 115
byte 1 105
byte 1 120
byte 1 95
byte 1 51
byte 1 50
byte 1 98
byte 1 0
align 1
LABELV $560
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 102
byte 1 105
byte 1 118
byte 1 101
byte 1 95
byte 1 51
byte 1 50
byte 1 98
byte 1 0
align 1
LABELV $559
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 102
byte 1 111
byte 1 117
byte 1 114
byte 1 95
byte 1 51
byte 1 50
byte 1 98
byte 1 0
align 1
LABELV $558
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 116
byte 1 104
byte 1 114
byte 1 101
byte 1 101
byte 1 95
byte 1 51
byte 1 50
byte 1 98
byte 1 0
align 1
LABELV $557
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 116
byte 1 119
byte 1 111
byte 1 95
byte 1 51
byte 1 50
byte 1 98
byte 1 0
align 1
LABELV $556
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 111
byte 1 110
byte 1 101
byte 1 95
byte 1 51
byte 1 50
byte 1 98
byte 1 0
align 1
LABELV $555
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 117
byte 1 109
byte 1 98
byte 1 101
byte 1 114
byte 1 115
byte 1 47
byte 1 122
byte 1 101
byte 1 114
byte 1 111
byte 1 95
byte 1 51
byte 1 50
byte 1 98
byte 1 0
align 1
LABELV $552
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 47
byte 1 104
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 98
byte 1 50
byte 1 97
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $549
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 97
byte 1 100
byte 1 101
byte 1 47
byte 1 104
byte 1 103
byte 1 114
byte 1 101
byte 1 110
byte 1 98
byte 1 49
byte 1 97
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $546
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 110
byte 1 95
byte 1 104
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $543
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 112
byte 1 114
byte 1 111
byte 1 116
byte 1 101
byte 1 99
byte 1 116
byte 1 51
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $540
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 114
byte 1 101
byte 1 103
byte 1 101
byte 1 110
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $537
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 115
byte 1 109
byte 1 97
byte 1 47
byte 1 112
byte 1 108
byte 1 97
byte 1 115
byte 1 109
byte 1 120
byte 1 49
byte 1 97
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $534
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 47
byte 1 114
byte 1 111
byte 1 99
byte 1 107
byte 1 108
byte 1 120
byte 1 49
byte 1 97
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $531
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 103
byte 1 117
byte 1 110
byte 1 47
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 103
byte 1 102
byte 1 49
byte 1 97
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $528
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 109
byte 1 97
byte 1 99
byte 1 104
byte 1 105
byte 1 110
byte 1 101
byte 1 103
byte 1 117
byte 1 110
byte 1 47
byte 1 114
byte 1 105
byte 1 99
byte 1 51
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $525
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 109
byte 1 97
byte 1 99
byte 1 104
byte 1 105
byte 1 110
byte 1 101
byte 1 103
byte 1 117
byte 1 110
byte 1 47
byte 1 114
byte 1 105
byte 1 99
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $522
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 109
byte 1 97
byte 1 99
byte 1 104
byte 1 105
byte 1 110
byte 1 101
byte 1 103
byte 1 117
byte 1 110
byte 1 47
byte 1 114
byte 1 105
byte 1 99
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $519
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 100
byte 1 97
byte 1 109
byte 1 97
byte 1 103
byte 1 101
byte 1 51
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $516
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 117
byte 1 115
byte 1 101
byte 1 95
byte 1 109
byte 1 101
byte 1 100
byte 1 107
byte 1 105
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $513
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 102
byte 1 108
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $494
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
byte 1 102
byte 1 111
byte 1 111
byte 1 116
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 115
byte 1 47
byte 1 99
byte 1 108
byte 1 97
byte 1 110
byte 1 107
byte 1 37
byte 1 105
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $490
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
byte 1 102
byte 1 111
byte 1 111
byte 1 116
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 115
byte 1 47
byte 1 115
byte 1 112
byte 1 108
byte 1 97
byte 1 115
byte 1 104
byte 1 37
byte 1 105
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $486
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
byte 1 102
byte 1 111
byte 1 111
byte 1 116
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 115
byte 1 47
byte 1 101
byte 1 110
byte 1 101
byte 1 114
byte 1 103
byte 1 121
byte 1 37
byte 1 105
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $482
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
byte 1 102
byte 1 111
byte 1 111
byte 1 116
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 115
byte 1 47
byte 1 109
byte 1 101
byte 1 99
byte 1 104
byte 1 37
byte 1 105
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $478
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
byte 1 102
byte 1 111
byte 1 111
byte 1 116
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 115
byte 1 47
byte 1 102
byte 1 108
byte 1 101
byte 1 115
byte 1 104
byte 1 37
byte 1 105
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $474
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
byte 1 102
byte 1 111
byte 1 111
byte 1 116
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 115
byte 1 47
byte 1 98
byte 1 111
byte 1 111
byte 1 116
byte 1 37
byte 1 105
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $471
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
byte 1 102
byte 1 111
byte 1 111
byte 1 116
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 115
byte 1 47
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 37
byte 1 105
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $466
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 111
byte 1 114
byte 1 108
byte 1 100
byte 1 47
byte 1 106
byte 1 117
byte 1 109
byte 1 112
byte 1 112
byte 1 97
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $463
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
byte 1 119
byte 1 97
byte 1 116
byte 1 114
byte 1 95
byte 1 117
byte 1 110
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $460
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
byte 1 119
byte 1 97
byte 1 116
byte 1 114
byte 1 95
byte 1 111
byte 1 117
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $457
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
byte 1 119
byte 1 97
byte 1 116
byte 1 114
byte 1 95
byte 1 105
byte 1 110
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $454
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 108
byte 1 111
byte 1 115
byte 1 116
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $451
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 116
byte 1 105
byte 1 101
byte 1 100
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $448
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 116
byte 1 97
byte 1 107
byte 1 101
byte 1 110
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $445
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 110
byte 1 115
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $442
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 97
byte 1 115
byte 1 115
byte 1 105
byte 1 115
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $439
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 104
byte 1 117
byte 1 109
byte 1 105
byte 1 108
byte 1 105
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $436
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 100
byte 1 101
byte 1 110
byte 1 105
byte 1 101
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $433
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 101
byte 1 120
byte 1 99
byte 1 101
byte 1 108
byte 1 108
byte 1 101
byte 1 110
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $430
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 105
byte 1 109
byte 1 112
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 105
byte 1 118
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $427
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 104
byte 1 105
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $424
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
byte 1 108
byte 1 97
byte 1 110
byte 1 100
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $421
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
byte 1 116
byte 1 97
byte 1 108
byte 1 107
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $418
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 110
byte 1 111
byte 1 97
byte 1 109
byte 1 109
byte 1 111
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $415
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 114
byte 1 101
byte 1 115
byte 1 112
byte 1 97
byte 1 119
byte 1 110
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $412
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 111
byte 1 114
byte 1 108
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 108
byte 1 101
byte 1 111
byte 1 117
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $409
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 111
byte 1 114
byte 1 108
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 108
byte 1 101
byte 1 105
byte 1 110
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $406
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
byte 1 103
byte 1 105
byte 1 98
byte 1 105
byte 1 109
byte 1 112
byte 1 51
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $403
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
byte 1 103
byte 1 105
byte 1 98
byte 1 105
byte 1 109
byte 1 112
byte 1 50
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $400
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
byte 1 103
byte 1 105
byte 1 98
byte 1 105
byte 1 109
byte 1 112
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $397
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
byte 1 103
byte 1 105
byte 1 98
byte 1 115
byte 1 112
byte 1 108
byte 1 116
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $394
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 117
byte 1 115
byte 1 101
byte 1 95
byte 1 110
byte 1 111
byte 1 116
byte 1 104
byte 1 105
byte 1 110
byte 1 103
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $391
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 105
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 114
byte 1 111
byte 1 102
byte 1 102
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $388
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 99
byte 1 104
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $385
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 119
byte 1 101
byte 1 97
byte 1 112
byte 1 111
byte 1 110
byte 1 115
byte 1 47
byte 1 109
byte 1 97
byte 1 99
byte 1 104
byte 1 105
byte 1 110
byte 1 101
byte 1 103
byte 1 117
byte 1 110
byte 1 47
byte 1 98
byte 1 117
byte 1 108
byte 1 101
byte 1 116
byte 1 98
byte 1 121
byte 1 49
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $382
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 118
byte 1 111
byte 1 99
byte 1 95
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 95
byte 1 49
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $379
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 118
byte 1 111
byte 1 99
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 49
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $374
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 118
byte 1 111
byte 1 99
byte 1 95
byte 1 104
byte 1 111
byte 1 108
byte 1 121
byte 1 115
byte 1 104
byte 1 105
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $371
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 118
byte 1 111
byte 1 99
byte 1 95
byte 1 121
byte 1 111
byte 1 117
byte 1 95
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $368
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 118
byte 1 111
byte 1 99
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $365
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 118
byte 1 111
byte 1 99
byte 1 95
byte 1 101
byte 1 110
byte 1 101
byte 1 109
byte 1 121
byte 1 95
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $362
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 118
byte 1 111
byte 1 99
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 95
byte 1 114
byte 1 101
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $359
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 118
byte 1 111
byte 1 99
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 95
byte 1 114
byte 1 101
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 101
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $351
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 116
byte 1 97
byte 1 107
byte 1 101
byte 1 110
byte 1 95
byte 1 111
byte 1 112
byte 1 112
byte 1 111
byte 1 110
byte 1 101
byte 1 110
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $348
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 116
byte 1 97
byte 1 107
byte 1 101
byte 1 110
byte 1 95
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $345
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 114
byte 1 101
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 95
byte 1 111
byte 1 112
byte 1 112
byte 1 111
byte 1 110
byte 1 101
byte 1 110
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $342
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 114
byte 1 101
byte 1 116
byte 1 117
byte 1 114
byte 1 110
byte 1 95
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $339
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 99
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 95
byte 1 111
byte 1 112
byte 1 112
byte 1 111
byte 1 110
byte 1 101
byte 1 110
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $334
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 118
byte 1 111
byte 1 99
byte 1 95
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $331
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 118
byte 1 111
byte 1 99
byte 1 95
byte 1 114
byte 1 101
byte 1 100
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 115
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $328
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 104
byte 1 105
byte 1 116
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 109
byte 1 97
byte 1 116
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $325
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 115
byte 1 116
byte 1 105
byte 1 101
byte 1 100
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $322
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 98
byte 1 108
byte 1 117
byte 1 101
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 115
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $319
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 114
byte 1 101
byte 1 100
byte 1 108
byte 1 101
byte 1 97
byte 1 100
byte 1 115
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $316
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 47
byte 1 102
byte 1 108
byte 1 97
byte 1 103
byte 1 99
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 95
byte 1 121
byte 1 111
byte 1 117
byte 1 114
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $308
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 112
byte 1 114
byte 1 101
byte 1 112
byte 1 97
byte 1 114
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $305
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 102
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $302
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 111
byte 1 110
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $299
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 116
byte 1 119
byte 1 111
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $296
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 116
byte 1 104
byte 1 114
byte 1 101
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $293
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 51
byte 1 95
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 115
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $290
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 50
byte 1 95
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 115
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $287
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 49
byte 1 95
byte 1 102
byte 1 114
byte 1 97
byte 1 103
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $284
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 115
byte 1 117
byte 1 100
byte 1 100
byte 1 101
byte 1 110
byte 1 95
byte 1 100
byte 1 101
byte 1 97
byte 1 116
byte 1 104
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $281
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 53
byte 1 95
byte 1 109
byte 1 105
byte 1 110
byte 1 117
byte 1 116
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $278
byte 1 115
byte 1 111
byte 1 117
byte 1 110
byte 1 100
byte 1 47
byte 1 102
byte 1 101
byte 1 101
byte 1 100
byte 1 98
byte 1 97
byte 1 99
byte 1 107
byte 1 47
byte 1 49
byte 1 95
byte 1 109
byte 1 105
byte 1 110
byte 1 117
byte 1 116
byte 1 101
byte 1 46
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $274
byte 1 119
byte 1 97
byte 1 118
byte 1 0
align 1
LABELV $268
byte 1 80
byte 1 114
byte 1 101
byte 1 99
byte 1 97
byte 1 99
byte 1 104
byte 1 101
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 58
byte 1 32
byte 1 37
byte 1 115
byte 1 32
byte 1 104
byte 1 97
byte 1 115
byte 1 32
byte 1 98
byte 1 97
byte 1 100
byte 1 32
byte 1 112
byte 1 114
byte 1 101
byte 1 99
byte 1 97
byte 1 99
byte 1 104
byte 1 101
byte 1 32
byte 1 115
byte 1 116
byte 1 114
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $247
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $206
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $205
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 95
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $204
byte 1 104
byte 1 101
byte 1 97
byte 1 100
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $203
byte 1 115
byte 1 97
byte 1 114
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $202
byte 1 109
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $199
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
LABELV $193
byte 1 48
byte 1 46
byte 1 48
byte 1 0
align 1
LABELV $192
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 114
byte 1 117
byte 1 101
byte 1 76
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $191
byte 1 99
byte 1 103
byte 1 95
byte 1 111
byte 1 108
byte 1 100
byte 1 80
byte 1 108
byte 1 97
byte 1 115
byte 1 109
byte 1 97
byte 1 0
align 1
LABELV $190
byte 1 99
byte 1 103
byte 1 95
byte 1 111
byte 1 108
byte 1 100
byte 1 82
byte 1 111
byte 1 99
byte 1 107
byte 1 101
byte 1 116
byte 1 0
align 1
LABELV $189
byte 1 99
byte 1 103
byte 1 95
byte 1 111
byte 1 108
byte 1 100
byte 1 82
byte 1 97
byte 1 105
byte 1 108
byte 1 0
align 1
LABELV $188
byte 1 117
byte 1 105
byte 1 95
byte 1 98
byte 1 105
byte 1 103
byte 1 70
byte 1 111
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $187
byte 1 48
byte 1 46
byte 1 50
byte 1 53
byte 1 0
align 1
LABELV $186
byte 1 117
byte 1 105
byte 1 95
byte 1 115
byte 1 109
byte 1 97
byte 1 108
byte 1 108
byte 1 70
byte 1 111
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $185
byte 1 99
byte 1 103
byte 1 95
byte 1 110
byte 1 111
byte 1 80
byte 1 114
byte 1 111
byte 1 106
byte 1 101
byte 1 99
byte 1 116
byte 1 105
byte 1 108
byte 1 101
byte 1 84
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 0
align 1
LABELV $184
byte 1 99
byte 1 103
byte 1 95
byte 1 110
byte 1 111
byte 1 84
byte 1 97
byte 1 117
byte 1 110
byte 1 116
byte 1 0
align 1
LABELV $183
byte 1 56
byte 1 0
align 1
LABELV $182
byte 1 112
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 95
byte 1 109
byte 1 115
byte 1 101
byte 1 99
byte 1 0
align 1
LABELV $181
byte 1 112
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 95
byte 1 102
byte 1 105
byte 1 120
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $180
byte 1 99
byte 1 111
byte 1 109
byte 1 95
byte 1 99
byte 1 97
byte 1 109
byte 1 101
byte 1 114
byte 1 97
byte 1 77
byte 1 111
byte 1 100
byte 1 101
byte 1 0
align 1
LABELV $179
byte 1 99
byte 1 103
byte 1 95
byte 1 115
byte 1 109
byte 1 111
byte 1 111
byte 1 116
byte 1 104
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $178
byte 1 99
byte 1 103
byte 1 95
byte 1 115
byte 1 99
byte 1 111
byte 1 114
byte 1 101
byte 1 80
byte 1 108
byte 1 117
byte 1 109
byte 1 115
byte 1 0
align 1
LABELV $177
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 115
byte 1 99
byte 1 97
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $176
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 115
byte 1 99
byte 1 97
byte 1 108
byte 1 101
byte 1 70
byte 1 97
byte 1 100
byte 1 101
byte 1 83
byte 1 112
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $175
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 115
byte 1 99
byte 1 97
byte 1 108
byte 1 101
byte 1 70
byte 1 97
byte 1 100
byte 1 101
byte 1 69
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $174
byte 1 53
byte 1 48
byte 1 0
align 1
LABELV $173
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 97
byte 1 109
byte 1 101
byte 1 114
byte 1 97
byte 1 79
byte 1 114
byte 1 98
byte 1 105
byte 1 116
byte 1 68
byte 1 101
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $172
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 97
byte 1 109
byte 1 101
byte 1 114
byte 1 97
byte 1 79
byte 1 114
byte 1 98
byte 1 105
byte 1 116
byte 1 0
align 1
LABELV $171
byte 1 103
byte 1 95
byte 1 115
byte 1 121
byte 1 110
byte 1 99
byte 1 104
byte 1 114
byte 1 111
byte 1 110
byte 1 111
byte 1 117
byte 1 115
byte 1 67
byte 1 108
byte 1 105
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $170
byte 1 99
byte 1 111
byte 1 109
byte 1 95
byte 1 98
byte 1 108
byte 1 111
byte 1 111
byte 1 100
byte 1 0
align 1
LABELV $169
byte 1 99
byte 1 108
byte 1 95
byte 1 112
byte 1 97
byte 1 117
byte 1 115
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $168
byte 1 99
byte 1 111
byte 1 109
byte 1 95
byte 1 98
byte 1 117
byte 1 105
byte 1 108
byte 1 100
byte 1 83
byte 1 99
byte 1 114
byte 1 105
byte 1 112
byte 1 116
byte 1 0
align 1
LABELV $167
byte 1 99
byte 1 103
byte 1 95
byte 1 110
byte 1 111
byte 1 86
byte 1 111
byte 1 105
byte 1 99
byte 1 101
byte 1 84
byte 1 101
byte 1 120
byte 1 116
byte 1 0
align 1
LABELV $166
byte 1 99
byte 1 103
byte 1 95
byte 1 110
byte 1 111
byte 1 86
byte 1 111
byte 1 105
byte 1 99
byte 1 101
byte 1 67
byte 1 104
byte 1 97
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $165
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 67
byte 1 104
byte 1 97
byte 1 116
byte 1 115
byte 1 79
byte 1 110
byte 1 108
byte 1 121
byte 1 0
align 1
LABELV $164
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 70
byte 1 114
byte 1 105
byte 1 101
byte 1 110
byte 1 100
byte 1 0
align 1
LABELV $163
byte 1 99
byte 1 103
byte 1 95
byte 1 115
byte 1 116
byte 1 97
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $162
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 111
byte 1 118
byte 1 101
byte 1 114
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $161
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 84
byte 1 101
byte 1 97
byte 1 109
byte 1 79
byte 1 118
byte 1 101
byte 1 114
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $160
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 101
byte 1 102
byte 1 101
byte 1 114
byte 1 80
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $159
byte 1 99
byte 1 103
byte 1 95
byte 1 112
byte 1 114
byte 1 101
byte 1 100
byte 1 105
byte 1 99
byte 1 116
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 0
align 1
LABELV $158
byte 1 99
byte 1 103
byte 1 95
byte 1 102
byte 1 111
byte 1 114
byte 1 99
byte 1 101
byte 1 77
byte 1 111
byte 1 100
byte 1 101
byte 1 108
byte 1 0
align 1
LABELV $157
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 67
byte 1 104
byte 1 97
byte 1 116
byte 1 72
byte 1 101
byte 1 105
byte 1 103
byte 1 104
byte 1 116
byte 1 0
align 1
LABELV $156
byte 1 51
byte 1 48
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $155
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 101
byte 1 97
byte 1 109
byte 1 67
byte 1 104
byte 1 97
byte 1 116
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $154
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 104
byte 1 105
byte 1 114
byte 1 100
byte 1 80
byte 1 101
byte 1 114
byte 1 115
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $153
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 104
byte 1 105
byte 1 114
byte 1 100
byte 1 80
byte 1 101
byte 1 114
byte 1 115
byte 1 111
byte 1 110
byte 1 65
byte 1 110
byte 1 103
byte 1 108
byte 1 101
byte 1 0
align 1
LABELV $152
byte 1 52
byte 1 48
byte 1 0
align 1
LABELV $151
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 104
byte 1 105
byte 1 114
byte 1 100
byte 1 80
byte 1 101
byte 1 114
byte 1 115
byte 1 111
byte 1 110
byte 1 82
byte 1 97
byte 1 110
byte 1 103
byte 1 101
byte 1 0
align 1
LABELV $150
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 114
byte 1 97
byte 1 99
byte 1 101
byte 1 114
byte 1 108
byte 1 101
byte 1 110
byte 1 103
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $149
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 114
byte 1 97
byte 1 99
byte 1 101
byte 1 114
byte 1 119
byte 1 105
byte 1 100
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $148
byte 1 99
byte 1 103
byte 1 95
byte 1 116
byte 1 114
byte 1 97
byte 1 99
byte 1 101
byte 1 114
byte 1 99
byte 1 104
byte 1 97
byte 1 110
byte 1 99
byte 1 101
byte 1 0
align 1
LABELV $147
byte 1 99
byte 1 103
byte 1 95
byte 1 102
byte 1 111
byte 1 111
byte 1 116
byte 1 115
byte 1 116
byte 1 101
byte 1 112
byte 1 115
byte 1 0
align 1
LABELV $146
byte 1 99
byte 1 103
byte 1 95
byte 1 115
byte 1 104
byte 1 111
byte 1 119
byte 1 109
byte 1 105
byte 1 115
byte 1 115
byte 1 0
align 1
LABELV $145
byte 1 99
byte 1 103
byte 1 95
byte 1 110
byte 1 111
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 97
byte 1 110
byte 1 105
byte 1 109
byte 1 115
byte 1 0
align 1
LABELV $144
byte 1 99
byte 1 103
byte 1 95
byte 1 110
byte 1 111
byte 1 112
byte 1 114
byte 1 101
byte 1 100
byte 1 105
byte 1 99
byte 1 116
byte 1 0
align 1
LABELV $143
byte 1 99
byte 1 103
byte 1 95
byte 1 101
byte 1 114
byte 1 114
byte 1 111
byte 1 114
byte 1 100
byte 1 101
byte 1 99
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $142
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 101
byte 1 98
byte 1 117
byte 1 103
byte 1 101
byte 1 118
byte 1 101
byte 1 110
byte 1 116
byte 1 115
byte 1 0
align 1
LABELV $141
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 101
byte 1 98
byte 1 117
byte 1 103
byte 1 112
byte 1 111
byte 1 115
byte 1 105
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $140
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 101
byte 1 98
byte 1 117
byte 1 103
byte 1 97
byte 1 110
byte 1 105
byte 1 109
byte 1 0
align 1
LABELV $139
byte 1 99
byte 1 103
byte 1 95
byte 1 97
byte 1 110
byte 1 105
byte 1 109
byte 1 115
byte 1 112
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $138
byte 1 48
byte 1 46
byte 1 51
byte 1 0
align 1
LABELV $137
byte 1 99
byte 1 103
byte 1 95
byte 1 115
byte 1 119
byte 1 105
byte 1 110
byte 1 103
byte 1 83
byte 1 112
byte 1 101
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $136
byte 1 99
byte 1 103
byte 1 95
byte 1 98
byte 1 111
byte 1 98
byte 1 114
byte 1 111
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $135
byte 1 99
byte 1 103
byte 1 95
byte 1 98
byte 1 111
byte 1 98
byte 1 112
byte 1 105
byte 1 116
byte 1 99
byte 1 104
byte 1 0
align 1
LABELV $134
byte 1 99
byte 1 103
byte 1 95
byte 1 98
byte 1 111
byte 1 98
byte 1 117
byte 1 112
byte 1 0
align 1
LABELV $133
byte 1 48
byte 1 46
byte 1 48
byte 1 48
byte 1 53
byte 1 0
align 1
LABELV $132
byte 1 99
byte 1 103
byte 1 95
byte 1 114
byte 1 117
byte 1 110
byte 1 114
byte 1 111
byte 1 108
byte 1 108
byte 1 0
align 1
LABELV $131
byte 1 48
byte 1 46
byte 1 48
byte 1 48
byte 1 50
byte 1 0
align 1
LABELV $130
byte 1 99
byte 1 103
byte 1 95
byte 1 114
byte 1 117
byte 1 110
byte 1 112
byte 1 105
byte 1 116
byte 1 99
byte 1 104
byte 1 0
align 1
LABELV $129
byte 1 51
byte 1 0
align 1
LABELV $128
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 101
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $127
byte 1 99
byte 1 103
byte 1 95
byte 1 103
byte 1 117
byte 1 110
byte 1 90
byte 1 0
align 1
LABELV $126
byte 1 99
byte 1 103
byte 1 95
byte 1 103
byte 1 117
byte 1 110
byte 1 89
byte 1 0
align 1
LABELV $125
byte 1 99
byte 1 103
byte 1 95
byte 1 103
byte 1 117
byte 1 110
byte 1 88
byte 1 0
align 1
LABELV $124
byte 1 52
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $123
byte 1 99
byte 1 103
byte 1 95
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 84
byte 1 114
byte 1 97
byte 1 105
byte 1 108
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $122
byte 1 99
byte 1 103
byte 1 95
byte 1 108
byte 1 97
byte 1 103
byte 1 111
byte 1 109
byte 1 101
byte 1 116
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $121
byte 1 99
byte 1 103
byte 1 95
byte 1 109
byte 1 97
byte 1 114
byte 1 107
byte 1 115
byte 1 0
align 1
LABELV $120
byte 1 99
byte 1 103
byte 1 95
byte 1 115
byte 1 105
byte 1 109
byte 1 112
byte 1 108
byte 1 101
byte 1 73
byte 1 116
byte 1 101
byte 1 109
byte 1 115
byte 1 0
align 1
LABELV $119
byte 1 50
byte 1 53
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $118
byte 1 99
byte 1 103
byte 1 95
byte 1 98
byte 1 114
byte 1 97
byte 1 115
byte 1 115
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 0
align 1
LABELV $117
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 114
byte 1 111
byte 1 115
byte 1 115
byte 1 104
byte 1 97
byte 1 105
byte 1 114
byte 1 89
byte 1 0
align 1
LABELV $116
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 114
byte 1 111
byte 1 115
byte 1 115
byte 1 104
byte 1 97
byte 1 105
byte 1 114
byte 1 88
byte 1 0
align 1
LABELV $115
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 114
byte 1 111
byte 1 115
byte 1 115
byte 1 104
byte 1 97
byte 1 105
byte 1 114
byte 1 72
byte 1 101
byte 1 97
byte 1 108
byte 1 116
byte 1 104
byte 1 0
align 1
LABELV $114
byte 1 50
byte 1 52
byte 1 0
align 1
LABELV $113
byte 1 99
byte 1 103
byte 1 95
byte 1 99
byte 1 114
byte 1 111
byte 1 115
byte 1 115
byte 1 104
byte 1 97
byte 1 105
byte 1 114
byte 1 83
byte 1 105
byte 1 122
byte 1 101
byte 1 0
align 1
LABELV $112
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 82
byte 1 101
byte 1 119
byte 1 97
byte 1 114
byte 1 100
byte 1 115
byte 1 0
align 1
LABELV $111
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 67
byte 1 114
byte 1 111
byte 1 115
byte 1 115
byte 1 104
byte 1 97
byte 1 105
byte 1 114
byte 1 78
byte 1 97
byte 1 109
byte 1 101
byte 1 115
byte 1 0
align 1
LABELV $110
byte 1 52
byte 1 0
align 1
LABELV $109
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 67
byte 1 114
byte 1 111
byte 1 115
byte 1 115
byte 1 104
byte 1 97
byte 1 105
byte 1 114
byte 1 0
align 1
LABELV $108
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 65
byte 1 116
byte 1 116
byte 1 97
byte 1 99
byte 1 107
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $107
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 65
byte 1 109
byte 1 109
byte 1 111
byte 1 87
byte 1 97
byte 1 114
byte 1 110
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $106
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 73
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 0
align 1
LABELV $105
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 51
byte 1 100
byte 1 73
byte 1 99
byte 1 111
byte 1 110
byte 1 115
byte 1 0
align 1
LABELV $104
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 83
byte 1 110
byte 1 97
byte 1 112
byte 1 115
byte 1 104
byte 1 111
byte 1 116
byte 1 0
align 1
LABELV $103
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 70
byte 1 80
byte 1 83
byte 1 0
align 1
LABELV $102
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 84
byte 1 105
byte 1 109
byte 1 101
byte 1 114
byte 1 0
align 1
LABELV $101
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 83
byte 1 116
byte 1 97
byte 1 116
byte 1 117
byte 1 115
byte 1 0
align 1
LABELV $100
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 50
byte 1 68
byte 1 0
align 1
LABELV $99
byte 1 99
byte 1 103
byte 1 95
byte 1 103
byte 1 105
byte 1 98
byte 1 115
byte 1 0
align 1
LABELV $98
byte 1 99
byte 1 103
byte 1 95
byte 1 115
byte 1 104
byte 1 97
byte 1 100
byte 1 111
byte 1 119
byte 1 115
byte 1 0
align 1
LABELV $97
byte 1 48
byte 1 46
byte 1 52
byte 1 0
align 1
LABELV $96
byte 1 99
byte 1 103
byte 1 95
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 101
byte 1 111
byte 1 83
byte 1 101
byte 1 112
byte 1 97
byte 1 114
byte 1 97
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 0
align 1
LABELV $95
byte 1 49
byte 1 48
byte 1 48
byte 1 0
align 1
LABELV $94
byte 1 99
byte 1 103
byte 1 95
byte 1 118
byte 1 105
byte 1 101
byte 1 119
byte 1 115
byte 1 105
byte 1 122
byte 1 101
byte 1 0
align 1
LABELV $93
byte 1 57
byte 1 48
byte 1 0
align 1
LABELV $92
byte 1 99
byte 1 103
byte 1 95
byte 1 102
byte 1 111
byte 1 118
byte 1 0
align 1
LABELV $91
byte 1 50
byte 1 50
byte 1 46
byte 1 53
byte 1 0
align 1
LABELV $90
byte 1 99
byte 1 103
byte 1 95
byte 1 122
byte 1 111
byte 1 111
byte 1 109
byte 1 102
byte 1 111
byte 1 118
byte 1 0
align 1
LABELV $89
byte 1 99
byte 1 103
byte 1 95
byte 1 100
byte 1 114
byte 1 97
byte 1 119
byte 1 71
byte 1 117
byte 1 110
byte 1 0
align 1
LABELV $88
byte 1 49
byte 1 0
align 1
LABELV $87
byte 1 99
byte 1 103
byte 1 95
byte 1 97
byte 1 117
byte 1 116
byte 1 111
byte 1 115
byte 1 119
byte 1 105
byte 1 116
byte 1 99
byte 1 104
byte 1 0
align 1
LABELV $86
byte 1 48
byte 1 0
align 1
LABELV $85
byte 1 99
byte 1 103
byte 1 95
byte 1 105
byte 1 103
byte 1 110
byte 1 111
byte 1 114
byte 1 101
byte 1 0
align 1
LABELV $82
byte 1 118
byte 1 109
byte 1 77
byte 1 97
byte 1 105
byte 1 110
byte 1 58
byte 1 32
byte 1 117
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 32
byte 1 99
byte 1 111
byte 1 109
byte 1 109
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 37
byte 1 105
byte 1 0
