data
export drawTeamOverlayModificationCount
align 4
LABELV drawTeamOverlayModificationCount
byte 4 -1
code
proc CG_DrawField 64 20
file "../cg_draw.c"
line 212
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
;23:// cg_draw.c -- draw all of the graphical elements during
;24:// active (after loading) gameplay
;25:
;26:#include "cg_local.h"
;27:
;28:#ifdef MISSIONPACK
;29:#include "../ui/ui_shared.h"
;30:
;31:// used for scoreboard
;32:extern displayContextDef_t cgDC;
;33:menuDef_t *menuScoreboard = NULL;
;34:#else
;35:int drawTeamOverlayModificationCount = -1;
;36:#endif
;37:
;38:int sortedTeamPlayers[TEAM_MAXOVERLAY];
;39:int	numSortedTeamPlayers;
;40:
;41:char systemChat[256];
;42:char teamChat1[256];
;43:char teamChat2[256];
;44:
;45:#ifdef MISSIONPACK
;46:
;47:int CG_Text_Width(const char *text, float scale, int limit) {
;48:  int count,len;
;49:	float out;
;50:	glyphInfo_t *glyph;
;51:	float useScale;
;52:// FIXME: see ui_main.c, same problem
;53://	const unsigned char *s = text;
;54:	const char *s = text;
;55:	fontInfo_t *font = &cgDC.Assets.textFont;
;56:	if (scale <= cg_smallFont.value) {
;57:		font = &cgDC.Assets.smallFont;
;58:	} else if (scale > cg_bigFont.value) {
;59:		font = &cgDC.Assets.bigFont;
;60:	}
;61:	useScale = scale * font->glyphScale;
;62:  out = 0;
;63:  if (text) {
;64:    len = strlen(text);
;65:		if (limit > 0 && len > limit) {
;66:			len = limit;
;67:		}
;68:		count = 0;
;69:		while (s && *s && count < len) {
;70:			if ( Q_IsColorString(s) ) {
;71:				s += 2;
;72:				continue;
;73:			} else {
;74:				glyph = &font->glyphs[(int)*s]; // TTimo: FIXME: getting nasty warnings without the cast, hopefully this doesn't break the VM build
;75:				out += glyph->xSkip;
;76:				s++;
;77:				count++;
;78:			}
;79:    }
;80:  }
;81:  return out * useScale;
;82:}
;83:
;84:int CG_Text_Height(const char *text, float scale, int limit) {
;85:  int len, count;
;86:	float max;
;87:	glyphInfo_t *glyph;
;88:	float useScale;
;89:// TTimo: FIXME
;90://	const unsigned char *s = text;
;91:	const char *s = text;
;92:	fontInfo_t *font = &cgDC.Assets.textFont;
;93:	if (scale <= cg_smallFont.value) {
;94:		font = &cgDC.Assets.smallFont;
;95:	} else if (scale > cg_bigFont.value) {
;96:		font = &cgDC.Assets.bigFont;
;97:	}
;98:	useScale = scale * font->glyphScale;
;99:  max = 0;
;100:  if (text) {
;101:    len = strlen(text);
;102:		if (limit > 0 && len > limit) {
;103:			len = limit;
;104:		}
;105:		count = 0;
;106:		while (s && *s && count < len) {
;107:			if ( Q_IsColorString(s) ) {
;108:				s += 2;
;109:				continue;
;110:			} else {
;111:				glyph = &font->glyphs[(int)*s]; // TTimo: FIXME: getting nasty warnings without the cast, hopefully this doesn't break the VM build
;112:	      if (max < glyph->height) {
;113:		      max = glyph->height;
;114:			  }
;115:				s++;
;116:				count++;
;117:			}
;118:    }
;119:  }
;120:  return max * useScale;
;121:}
;122:
;123:void CG_Text_PaintChar(float x, float y, float width, float height, float scale, float s, float t, float s2, float t2, qhandle_t hShader) {
;124:  float w, h;
;125:  w = width * scale;
;126:  h = height * scale;
;127:  CG_AdjustFrom640( &x, &y, &w, &h );
;128:  trap_R_DrawStretchPic( x, y, w, h, s, t, s2, t2, hShader );
;129:}
;130:
;131:void CG_Text_Paint(float x, float y, float scale, vec4_t color, const char *text, float adjust, int limit, int style) {
;132:  int len, count;
;133:	vec4_t newColor;
;134:	glyphInfo_t *glyph;
;135:	float useScale;
;136:	fontInfo_t *font = &cgDC.Assets.textFont;
;137:	if (scale <= cg_smallFont.value) {
;138:		font = &cgDC.Assets.smallFont;
;139:	} else if (scale > cg_bigFont.value) {
;140:		font = &cgDC.Assets.bigFont;
;141:	}
;142:	useScale = scale * font->glyphScale;
;143:  if (text) {
;144:// TTimo: FIXME
;145://		const unsigned char *s = text;
;146:		const char *s = text;
;147:		trap_R_SetColor( color );
;148:		memcpy(&newColor[0], &color[0], sizeof(vec4_t));
;149:    len = strlen(text);
;150:		if (limit > 0 && len > limit) {
;151:			len = limit;
;152:		}
;153:		count = 0;
;154:		while (s && *s && count < len) {
;155:			glyph = &font->glyphs[(int)*s]; // TTimo: FIXME: getting nasty warnings without the cast, hopefully this doesn't break the VM build
;156:      //int yadj = Assets.textFont.glyphs[text[i]].bottom + Assets.textFont.glyphs[text[i]].top;
;157:      //float yadj = scale * (Assets.textFont.glyphs[text[i]].imageHeight - Assets.textFont.glyphs[text[i]].height);
;158:			if ( Q_IsColorString( s ) ) {
;159:				memcpy( newColor, g_color_table[ColorIndex(*(s+1))], sizeof( newColor ) );
;160:				newColor[3] = color[3];
;161:				trap_R_SetColor( newColor );
;162:				s += 2;
;163:				continue;
;164:			} else {
;165:				float yadj = useScale * glyph->top;
;166:				if (style == ITEM_TEXTSTYLE_SHADOWED || style == ITEM_TEXTSTYLE_SHADOWEDMORE) {
;167:					int ofs = style == ITEM_TEXTSTYLE_SHADOWED ? 1 : 2;
;168:					colorBlack[3] = newColor[3];
;169:					trap_R_SetColor( colorBlack );
;170:					CG_Text_PaintChar(x + ofs, y - yadj + ofs, 
;171:														glyph->imageWidth,
;172:														glyph->imageHeight,
;173:														useScale, 
;174:														glyph->s,
;175:														glyph->t,
;176:														glyph->s2,
;177:														glyph->t2,
;178:														glyph->glyph);
;179:					colorBlack[3] = 1.0;
;180:					trap_R_SetColor( newColor );
;181:				}
;182:				CG_Text_PaintChar(x, y - yadj, 
;183:													glyph->imageWidth,
;184:													glyph->imageHeight,
;185:													useScale, 
;186:													glyph->s,
;187:													glyph->t,
;188:													glyph->s2,
;189:													glyph->t2,
;190:													glyph->glyph);
;191:				// CG_DrawPic(x, y - yadj, scale * cgDC.Assets.textFont.glyphs[text[i]].imageWidth, scale * cgDC.Assets.textFont.glyphs[text[i]].imageHeight, cgDC.Assets.textFont.glyphs[text[i]].glyph);
;192:				x += (glyph->xSkip * useScale) + adjust;
;193:				s++;
;194:				count++;
;195:			}
;196:    }
;197:	  trap_R_SetColor( NULL );
;198:  }
;199:}
;200:
;201:
;202:#endif
;203:
;204:/*
;205:==============
;206:CG_DrawField
;207:
;208:Draws large numbers for status bar and powerups
;209:==============
;210:*/
;211:#ifndef MISSIONPACK
;212:static void CG_DrawField (int x, int y, int width, int value) {
line 217
;213:	char	num[16], *ptr;
;214:	int		l;
;215:	int		frame;
;216:
;217:	if ( width < 1 ) {
ADDRFP4 8
INDIRI4
CNSTI4 1
GEI4 $71
line 218
;218:		return;
ADDRGP4 $70
JUMPV
LABELV $71
line 222
;219:	}
;220:
;221:	// draw number string
;222:	if ( width > 5 ) {
ADDRFP4 8
INDIRI4
CNSTI4 5
LEI4 $73
line 223
;223:		width = 5;
ADDRFP4 8
CNSTI4 5
ASGNI4
line 224
;224:	}
LABELV $73
line 226
;225:
;226:	switch ( width ) {
ADDRLP4 28
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 1
LTI4 $75
ADDRLP4 28
INDIRI4
CNSTI4 4
GTI4 $75
ADDRLP4 28
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $105-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $105
address $77
address $84
address $91
address $98
code
LABELV $77
line 228
;227:	case 1:
;228:		value = value > 9 ? 9 : value;
ADDRFP4 12
INDIRI4
CNSTI4 9
LEI4 $79
ADDRLP4 32
CNSTI4 9
ASGNI4
ADDRGP4 $80
JUMPV
LABELV $79
ADDRLP4 32
ADDRFP4 12
INDIRI4
ASGNI4
LABELV $80
ADDRFP4 12
ADDRLP4 32
INDIRI4
ASGNI4
line 229
;229:		value = value < 0 ? 0 : value;
ADDRFP4 12
INDIRI4
CNSTI4 0
GEI4 $82
ADDRLP4 36
CNSTI4 0
ASGNI4
ADDRGP4 $83
JUMPV
LABELV $82
ADDRLP4 36
ADDRFP4 12
INDIRI4
ASGNI4
LABELV $83
ADDRFP4 12
ADDRLP4 36
INDIRI4
ASGNI4
line 230
;230:		break;
ADDRGP4 $76
JUMPV
LABELV $84
line 232
;231:	case 2:
;232:		value = value > 99 ? 99 : value;
ADDRFP4 12
INDIRI4
CNSTI4 99
LEI4 $86
ADDRLP4 40
CNSTI4 99
ASGNI4
ADDRGP4 $87
JUMPV
LABELV $86
ADDRLP4 40
ADDRFP4 12
INDIRI4
ASGNI4
LABELV $87
ADDRFP4 12
ADDRLP4 40
INDIRI4
ASGNI4
line 233
;233:		value = value < -9 ? -9 : value;
ADDRFP4 12
INDIRI4
CNSTI4 -9
GEI4 $89
ADDRLP4 44
CNSTI4 -9
ASGNI4
ADDRGP4 $90
JUMPV
LABELV $89
ADDRLP4 44
ADDRFP4 12
INDIRI4
ASGNI4
LABELV $90
ADDRFP4 12
ADDRLP4 44
INDIRI4
ASGNI4
line 234
;234:		break;
ADDRGP4 $76
JUMPV
LABELV $91
line 236
;235:	case 3:
;236:		value = value > 999 ? 999 : value;
ADDRFP4 12
INDIRI4
CNSTI4 999
LEI4 $93
ADDRLP4 48
CNSTI4 999
ASGNI4
ADDRGP4 $94
JUMPV
LABELV $93
ADDRLP4 48
ADDRFP4 12
INDIRI4
ASGNI4
LABELV $94
ADDRFP4 12
ADDRLP4 48
INDIRI4
ASGNI4
line 237
;237:		value = value < -99 ? -99 : value;
ADDRFP4 12
INDIRI4
CNSTI4 -99
GEI4 $96
ADDRLP4 52
CNSTI4 -99
ASGNI4
ADDRGP4 $97
JUMPV
LABELV $96
ADDRLP4 52
ADDRFP4 12
INDIRI4
ASGNI4
LABELV $97
ADDRFP4 12
ADDRLP4 52
INDIRI4
ASGNI4
line 238
;238:		break;
ADDRGP4 $76
JUMPV
LABELV $98
line 240
;239:	case 4:
;240:		value = value > 9999 ? 9999 : value;
ADDRFP4 12
INDIRI4
CNSTI4 9999
LEI4 $100
ADDRLP4 56
CNSTI4 9999
ASGNI4
ADDRGP4 $101
JUMPV
LABELV $100
ADDRLP4 56
ADDRFP4 12
INDIRI4
ASGNI4
LABELV $101
ADDRFP4 12
ADDRLP4 56
INDIRI4
ASGNI4
line 241
;241:		value = value < -999 ? -999 : value;
ADDRFP4 12
INDIRI4
CNSTI4 -999
GEI4 $103
ADDRLP4 60
CNSTI4 -999
ASGNI4
ADDRGP4 $104
JUMPV
LABELV $103
ADDRLP4 60
ADDRFP4 12
INDIRI4
ASGNI4
LABELV $104
ADDRFP4 12
ADDRLP4 60
INDIRI4
ASGNI4
line 242
;242:		break;
LABELV $75
LABELV $76
line 245
;243:	}
;244:
;245:	Com_sprintf (num, sizeof(num), "%i", value);
ADDRLP4 12
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 $107
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 246
;246:	l = strlen(num);
ADDRLP4 12
ARGP4
ADDRLP4 32
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 32
INDIRI4
ASGNI4
line 247
;247:	if (l > width)
ADDRLP4 4
INDIRI4
ADDRFP4 8
INDIRI4
LEI4 $108
line 248
;248:		l = width;
ADDRLP4 4
ADDRFP4 8
INDIRI4
ASGNI4
LABELV $108
line 249
;249:	x += 2 + CHAR_WIDTH*(width - l);
ADDRFP4 0
ADDRFP4 0
INDIRI4
ADDRFP4 8
INDIRI4
ADDRLP4 4
INDIRI4
SUBI4
CNSTI4 5
LSHI4
CNSTI4 2
ADDI4
ADDI4
ASGNI4
line 251
;250:
;251:	ptr = num;
ADDRLP4 0
ADDRLP4 12
ASGNP4
ADDRGP4 $111
JUMPV
LABELV $110
line 253
;252:	while (*ptr && l)
;253:	{
line 254
;254:		if (*ptr == '-')
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 45
NEI4 $113
line 255
;255:			frame = STAT_MINUS;
ADDRLP4 8
CNSTI4 10
ASGNI4
ADDRGP4 $114
JUMPV
LABELV $113
line 257
;256:		else
;257:			frame = *ptr -'0';
ADDRLP4 8
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 48
SUBI4
ASGNI4
LABELV $114
line 259
;258:
;259:		CG_DrawPic( x,y, CHAR_WIDTH, CHAR_HEIGHT, cgs.media.numberShaders[frame] );
ADDRFP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 4
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1107296256
ARGF4
CNSTF4 1111490560
ARGF4
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+152340+300
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 260
;260:		x += CHAR_WIDTH;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 32
ADDI4
ASGNI4
line 261
;261:		ptr++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 262
;262:		l--;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 263
;263:	}
LABELV $111
line 252
ADDRLP4 36
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ADDRLP4 36
INDIRI4
EQI4 $117
ADDRLP4 4
INDIRI4
ADDRLP4 36
INDIRI4
NEI4 $110
LABELV $117
line 264
;264:}
LABELV $70
endproc CG_DrawField 64 20
export CG_Draw3DModel
proc CG_Draw3DModel 512 16
line 268
;265:#endif // MISSIONPACK
;266:
;267:
;268:void CG_Draw3DModel( float x, float y, float w, float h, qhandle_t model, qhandle_t skin, vec3_t origin, vec3_t angles ) {
line 272
;269:	refdef_t		refdef;
;270:	refEntity_t		ent;
;271:
;272:	if ( !cg_draw3dIcons.integer || !cg_drawIcons.integer ) {
ADDRLP4 508
CNSTI4 0
ASGNI4
ADDRGP4 cg_draw3dIcons+12
INDIRI4
ADDRLP4 508
INDIRI4
EQI4 $123
ADDRGP4 cg_drawIcons+12
INDIRI4
ADDRLP4 508
INDIRI4
NEI4 $119
LABELV $123
line 273
;273:		return;
ADDRGP4 $118
JUMPV
LABELV $119
line 276
;274:	}
;275:
;276:	CG_AdjustFrom640( &x, &y, &w, &h );
ADDRFP4 0
ARGP4
ADDRFP4 4
ARGP4
ADDRFP4 8
ARGP4
ADDRFP4 12
ARGP4
ADDRGP4 CG_AdjustFrom640
CALLV
pop
line 278
;277:
;278:	memset( &refdef, 0, sizeof( refdef ) );
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 368
ARGI4
ADDRGP4 memset
CALLP4
pop
line 280
;279:
;280:	memset( &ent, 0, sizeof( ent ) );
ADDRLP4 368
ARGP4
CNSTI4 0
ARGI4
CNSTI4 140
ARGI4
ADDRGP4 memset
CALLP4
pop
line 281
;281:	AnglesToAxis( angles, ent.axis );
ADDRFP4 28
INDIRP4
ARGP4
ADDRLP4 368+28
ARGP4
ADDRGP4 AnglesToAxis
CALLV
pop
line 282
;282:	VectorCopy( origin, ent.origin );
ADDRLP4 368+68
ADDRFP4 24
INDIRP4
INDIRB
ASGNB 12
line 283
;283:	ent.hModel = model;
ADDRLP4 368+8
ADDRFP4 16
INDIRI4
ASGNI4
line 284
;284:	ent.customSkin = skin;
ADDRLP4 368+108
ADDRFP4 20
INDIRI4
ASGNI4
line 285
;285:	ent.renderfx = RF_NOSHADOW;		// no stencil shadows
ADDRLP4 368+4
CNSTI4 64
ASGNI4
line 287
;286:
;287:	refdef.rdflags = RDF_NOWORLDMODEL;
ADDRLP4 0+76
CNSTI4 1
ASGNI4
line 289
;288:
;289:	AxisClear( refdef.viewaxis );
ADDRLP4 0+36
ARGP4
ADDRGP4 AxisClear
CALLV
pop
line 291
;290:
;291:	refdef.fov_x = 30;
ADDRLP4 0+16
CNSTF4 1106247680
ASGNF4
line 292
;292:	refdef.fov_y = 30;
ADDRLP4 0+20
CNSTF4 1106247680
ASGNF4
line 294
;293:
;294:	refdef.x = x;
ADDRLP4 0
ADDRFP4 0
INDIRF4
CVFI4 4
ASGNI4
line 295
;295:	refdef.y = y;
ADDRLP4 0+4
ADDRFP4 4
INDIRF4
CVFI4 4
ASGNI4
line 296
;296:	refdef.width = w;
ADDRLP4 0+8
ADDRFP4 8
INDIRF4
CVFI4 4
ASGNI4
line 297
;297:	refdef.height = h;
ADDRLP4 0+12
ADDRFP4 12
INDIRF4
CVFI4 4
ASGNI4
line 299
;298:
;299:	refdef.time = cg.time;
ADDRLP4 0+72
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 301
;300:
;301:	trap_R_ClearScene();
ADDRGP4 trap_R_ClearScene
CALLV
pop
line 302
;302:	trap_R_AddRefEntityToScene( &ent );
ADDRLP4 368
ARGP4
ADDRGP4 trap_R_AddRefEntityToScene
CALLV
pop
line 303
;303:	trap_R_RenderScene( &refdef );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_RenderScene
CALLV
pop
line 304
;304:}
LABELV $118
endproc CG_Draw3DModel 512 16
export CG_DrawHead
proc CG_DrawHead 56 32
line 309
;305:
;306:/*
;307:Used for both the status bar and the scoreboard
;308:*/
;309:void CG_DrawHead( float x, float y, float w, float h, int clientNum, vec3_t headAngles ) {
line 316
;310:	clipHandle_t	cm;
;311:	clientInfo_t	*ci;
;312:	float			len;
;313:	vec3_t			origin;
;314:	vec3_t			mins, maxs;
;315:
;316:	ci = &cgs.clientinfo[ clientNum ];
ADDRLP4 0
CNSTI4 1708
ADDRFP4 16
INDIRI4
MULI4
ADDRGP4 cgs+40972
ADDP4
ASGNP4
line 318
;317:
;318:	if ( cg_draw3dIcons.integer ) {
ADDRGP4 cg_draw3dIcons+12
INDIRI4
CNSTI4 0
EQI4 $140
line 319
;319:		cm = ci->headModel;
ADDRLP4 40
ADDRLP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ASGNI4
line 320
;320:		if ( !cm ) {
ADDRLP4 40
INDIRI4
CNSTI4 0
NEI4 $143
line 321
;321:			return;
ADDRGP4 $138
JUMPV
LABELV $143
line 325
;322:		}
;323:
;324:		// offset the origin y and z to center the head
;325:		trap_R_ModelBounds( cm, mins, maxs );
ADDRLP4 40
INDIRI4
ARGI4
ADDRLP4 16
ARGP4
ADDRLP4 28
ARGP4
ADDRGP4 trap_R_ModelBounds
CALLV
pop
line 327
;326:
;327:		origin[2] = -0.5 * ( mins[2] + maxs[2] );
ADDRLP4 4+8
CNSTF4 3204448256
ADDRLP4 16+8
INDIRF4
ADDRLP4 28+8
INDIRF4
ADDF4
MULF4
ASGNF4
line 328
;328:		origin[1] = 0.5 * ( mins[1] + maxs[1] );
ADDRLP4 4+4
CNSTF4 1056964608
ADDRLP4 16+4
INDIRF4
ADDRLP4 28+4
INDIRF4
ADDF4
MULF4
ASGNF4
line 332
;329:
;330:		// calculate distance so the head nearly fills the box
;331:		// assume heads are taller than wide
;332:		len = 0.7 * ( maxs[2] - mins[2] );		
ADDRLP4 44
CNSTF4 1060320051
ADDRLP4 28+8
INDIRF4
ADDRLP4 16+8
INDIRF4
SUBF4
MULF4
ASGNF4
line 333
;333:		origin[0] = len / 0.268;	// len / tan( fov/2 )
ADDRLP4 4
ADDRLP4 44
INDIRF4
CNSTF4 1049179980
DIVF4
ASGNF4
line 336
;334:
;335:		// allow per-model tweaking
;336:		VectorAdd( origin, ci->headOffset, origin );
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 496
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 4+4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 500
ADDP4
INDIRF4
ADDF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 4+8
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 504
ADDP4
INDIRF4
ADDF4
ASGNF4
line 338
;337:
;338:		CG_Draw3DModel( x, y, w, h, ci->headModel, ci->headSkin, origin, headAngles );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRGP4 CG_Draw3DModel
CALLV
pop
line 339
;339:	} else if ( cg_drawIcons.integer ) {
ADDRGP4 $141
JUMPV
LABELV $140
ADDRGP4 cg_drawIcons+12
INDIRI4
CNSTI4 0
EQI4 $157
line 340
;340:		CG_DrawPic( x, y, w, h, ci->modelIcon );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 540
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 341
;341:	}
LABELV $157
LABELV $141
line 344
;342:
;343:	// if they are deferred, draw a cross out
;344:	if ( ci->deferred ) {
ADDRLP4 0
INDIRP4
CNSTI4 480
ADDP4
INDIRI4
CNSTI4 0
EQI4 $160
line 345
;345:		CG_DrawPic( x, y, w, h, cgs.media.deferShader );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRGP4 cgs+152340+132
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 346
;346:	}
LABELV $160
line 347
;347:}
LABELV $138
endproc CG_DrawHead 56 32
export CG_DrawFlagModel
proc CG_DrawFlagModel 72 32
line 352
;348:
;349:/*
;350:Used for both the status bar and the scoreboard
;351:*/
;352:void CG_DrawFlagModel( float x, float y, float w, float h, int team, qboolean force2D ) {
line 359
;353:	qhandle_t		cm;
;354:	float			len;
;355:	vec3_t			origin, angles;
;356:	vec3_t			mins, maxs;
;357:	qhandle_t		handle;
;358:
;359:	if ( !force2D && cg_draw3dIcons.integer ) {
ADDRLP4 60
CNSTI4 0
ASGNI4
ADDRFP4 20
INDIRI4
ADDRLP4 60
INDIRI4
NEI4 $165
ADDRGP4 cg_draw3dIcons+12
INDIRI4
ADDRLP4 60
INDIRI4
EQI4 $165
line 361
;360:
;361:		VectorClear( angles );
ADDRLP4 64
CNSTF4 0
ASGNF4
ADDRLP4 0+8
ADDRLP4 64
INDIRF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 64
INDIRF4
ASGNF4
ADDRLP4 0
ADDRLP4 64
INDIRF4
ASGNF4
line 363
;362:
;363:		cm = cgs.media.redFlagModel;
ADDRLP4 48
ADDRGP4 cgs+152340+36
INDIRI4
ASGNI4
line 366
;364:
;365:		// offset the origin y and z to center the flag
;366:		trap_R_ModelBounds( cm, mins, maxs );
ADDRLP4 48
INDIRI4
ARGI4
ADDRLP4 24
ARGP4
ADDRLP4 36
ARGP4
ADDRGP4 trap_R_ModelBounds
CALLV
pop
line 368
;367:
;368:		origin[2] = -0.5 * ( mins[2] + maxs[2] );
ADDRLP4 12+8
CNSTF4 3204448256
ADDRLP4 24+8
INDIRF4
ADDRLP4 36+8
INDIRF4
ADDF4
MULF4
ASGNF4
line 369
;369:		origin[1] = 0.5 * ( mins[1] + maxs[1] );
ADDRLP4 12+4
CNSTF4 1056964608
ADDRLP4 24+4
INDIRF4
ADDRLP4 36+4
INDIRF4
ADDF4
MULF4
ASGNF4
line 373
;370:
;371:		// calculate distance so the flag nearly fills the box
;372:		// assume heads are taller than wide
;373:		len = 0.5 * ( maxs[2] - mins[2] );		
ADDRLP4 52
CNSTF4 1056964608
ADDRLP4 36+8
INDIRF4
ADDRLP4 24+8
INDIRF4
SUBF4
MULF4
ASGNF4
line 374
;374:		origin[0] = len / 0.268;	// len / tan( fov/2 )
ADDRLP4 12
ADDRLP4 52
INDIRF4
CNSTF4 1049179980
DIVF4
ASGNF4
line 376
;375:
;376:		angles[YAW] = 60 * sin( cg.time / 2000.0 );;
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
CNSTF4 1157234688
DIVF4
ARGF4
ADDRLP4 68
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 0+4
CNSTF4 1114636288
ADDRLP4 68
INDIRF4
MULF4
ASGNF4
line 378
;377:
;378:		if( team == TEAM_RED ) {
ADDRFP4 16
INDIRI4
CNSTI4 1
NEI4 $182
line 379
;379:			handle = cgs.media.redFlagModel;
ADDRLP4 56
ADDRGP4 cgs+152340+36
INDIRI4
ASGNI4
line 380
;380:		} else if( team == TEAM_BLUE ) {
ADDRGP4 $183
JUMPV
LABELV $182
ADDRFP4 16
INDIRI4
CNSTI4 2
NEI4 $186
line 381
;381:			handle = cgs.media.blueFlagModel;
ADDRLP4 56
ADDRGP4 cgs+152340+40
INDIRI4
ASGNI4
line 382
;382:		} else if( team == TEAM_FREE ) {
ADDRGP4 $187
JUMPV
LABELV $186
ADDRFP4 16
INDIRI4
CNSTI4 0
NEI4 $164
line 383
;383:			handle = cgs.media.neutralFlagModel;
ADDRLP4 56
ADDRGP4 cgs+152340+44
INDIRI4
ASGNI4
line 384
;384:		} else {
line 385
;385:			return;
LABELV $191
LABELV $187
LABELV $183
line 387
;386:		}
;387:		CG_Draw3DModel( x, y, w, h, handle, 0, origin, angles );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRLP4 56
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 12
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 CG_Draw3DModel
CALLV
pop
line 388
;388:	} else if ( cg_drawIcons.integer ) {
ADDRGP4 $166
JUMPV
LABELV $165
ADDRGP4 cg_drawIcons+12
INDIRI4
CNSTI4 0
EQI4 $194
line 391
;389:		gitem_t *item;
;390:
;391:		if( team == TEAM_RED ) {
ADDRFP4 16
INDIRI4
CNSTI4 1
NEI4 $197
line 392
;392:			item = BG_FindItemForPowerup( PW_REDFLAG );
CNSTI4 7
ARGI4
ADDRLP4 68
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 64
ADDRLP4 68
INDIRP4
ASGNP4
line 393
;393:		} else if( team == TEAM_BLUE ) {
ADDRGP4 $198
JUMPV
LABELV $197
ADDRFP4 16
INDIRI4
CNSTI4 2
NEI4 $199
line 394
;394:			item = BG_FindItemForPowerup( PW_BLUEFLAG );
CNSTI4 8
ARGI4
ADDRLP4 68
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 64
ADDRLP4 68
INDIRP4
ASGNP4
line 395
;395:		} else if( team == TEAM_FREE ) {
ADDRGP4 $200
JUMPV
LABELV $199
ADDRFP4 16
INDIRI4
CNSTI4 0
NEI4 $164
line 396
;396:			item = BG_FindItemForPowerup( PW_NEUTRALFLAG );
CNSTI4 9
ARGI4
ADDRLP4 68
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 64
ADDRLP4 68
INDIRP4
ASGNP4
line 397
;397:		} else {
line 398
;398:			return;
LABELV $202
LABELV $200
LABELV $198
line 400
;399:		}
;400:		if (item) {
ADDRLP4 64
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $203
line 401
;401:		  CG_DrawPic( x, y, w, h, cg_items[ ITEM_INDEX(item) ].icon );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
CNSTI4 24
ADDRLP4 64
INDIRP4
CVPU4 4
ADDRGP4 bg_itemlist
CVPU4 4
SUBU4
CVUI4 4
CNSTI4 52
DIVI4
MULI4
ADDRGP4 cg_items+20
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 402
;402:		}
LABELV $203
line 403
;403:	}
LABELV $194
LABELV $166
line 404
;404:}
LABELV $164
endproc CG_DrawFlagModel 72 32
proc CG_DrawStatusBarHead 56 24
line 408
;405:
;406:#ifndef MISSIONPACK
;407:
;408:static void CG_DrawStatusBarHead( float x ) {
line 413
;409:	vec3_t		angles;
;410:	float		size, stretch;
;411:	float		frac;
;412:
;413:	VectorClear( angles );
ADDRLP4 24
CNSTF4 0
ASGNF4
ADDRLP4 4+8
ADDRLP4 24
INDIRF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 24
INDIRF4
ASGNF4
ADDRLP4 4
ADDRLP4 24
INDIRF4
ASGNF4
line 415
;414:
;415:	if ( cg.damageTime && cg.time - cg.damageTime < DAMAGE_TIME ) {
ADDRGP4 cg+124688
INDIRF4
CNSTF4 0
EQF4 $209
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
ADDRGP4 cg+124688
INDIRF4
SUBF4
CNSTF4 1140457472
GEF4 $209
line 416
;416:		frac = (float)(cg.time - cg.damageTime ) / DAMAGE_TIME;
ADDRLP4 0
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
ADDRGP4 cg+124688
INDIRF4
SUBF4
CNSTF4 1140457472
DIVF4
ASGNF4
line 417
;417:		size = ICON_SIZE * 1.25 * ( 1.5 - frac * 0.5 );
ADDRLP4 16
CNSTF4 1114636288
CNSTF4 1069547520
CNSTF4 1056964608
ADDRLP4 0
INDIRF4
MULF4
SUBF4
MULF4
ASGNF4
line 419
;418:
;419:		stretch = size - ICON_SIZE * 1.25;
ADDRLP4 20
ADDRLP4 16
INDIRF4
CNSTF4 1114636288
SUBF4
ASGNF4
line 421
;420:		// kick in the direction of damage
;421:		x -= stretch * 0.5 + cg.damageX * stretch * 0.5;
ADDRLP4 28
CNSTF4 1056964608
ASGNF4
ADDRLP4 32
ADDRLP4 20
INDIRF4
ASGNF4
ADDRFP4 0
ADDRFP4 0
INDIRF4
ADDRLP4 28
INDIRF4
ADDRLP4 32
INDIRF4
MULF4
ADDRLP4 28
INDIRF4
ADDRGP4 cg+124692
INDIRF4
ADDRLP4 32
INDIRF4
MULF4
MULF4
ADDF4
SUBF4
ASGNF4
line 423
;422:
;423:		cg.headStartYaw = 180 + cg.damageX * 45;
ADDRGP4 cg+124724
CNSTF4 1110704128
ADDRGP4 cg+124692
INDIRF4
MULF4
CNSTF4 1127481344
ADDF4
ASGNF4
line 425
;424:
;425:		cg.headEndYaw = 180 + 20 * cos( crandom()*M_PI );
ADDRLP4 36
ADDRGP4 rand
CALLI4
ASGNI4
CNSTF4 1078530011
CNSTF4 1073741824
ADDRLP4 36
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
SUBF4
MULF4
MULF4
ARGF4
ADDRLP4 40
ADDRGP4 cos
CALLF4
ASGNF4
ADDRGP4 cg+124712
CNSTF4 1101004800
ADDRLP4 40
INDIRF4
MULF4
CNSTF4 1127481344
ADDF4
ASGNF4
line 426
;426:		cg.headEndPitch = 5 * cos( crandom()*M_PI );
ADDRLP4 44
ADDRGP4 rand
CALLI4
ASGNI4
CNSTF4 1078530011
CNSTF4 1073741824
ADDRLP4 44
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
SUBF4
MULF4
MULF4
ARGF4
ADDRLP4 48
ADDRGP4 cos
CALLF4
ASGNF4
ADDRGP4 cg+124708
CNSTF4 1084227584
ADDRLP4 48
INDIRF4
MULF4
ASGNF4
line 428
;427:
;428:		cg.headStartTime = cg.time;
ADDRGP4 cg+124728
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 429
;429:		cg.headEndTime = cg.time + 100 + random() * 2000;
ADDRLP4 52
ADDRGP4 rand
CALLI4
ASGNI4
ADDRGP4 cg+124716
ADDRGP4 cg+107604
INDIRI4
CNSTI4 100
ADDI4
CVIF4 4
CNSTF4 1157234688
ADDRLP4 52
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ADDF4
CVFI4 4
ASGNI4
line 430
;430:	} else {
ADDRGP4 $210
JUMPV
LABELV $209
line 431
;431:		if ( cg.time >= cg.headEndTime ) {
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+124716
INDIRI4
LTI4 $225
line 433
;432:			// select a new head angle
;433:			cg.headStartYaw = cg.headEndYaw;
ADDRGP4 cg+124724
ADDRGP4 cg+124712
INDIRF4
ASGNF4
line 434
;434:			cg.headStartPitch = cg.headEndPitch;
ADDRGP4 cg+124720
ADDRGP4 cg+124708
INDIRF4
ASGNF4
line 435
;435:			cg.headStartTime = cg.headEndTime;
ADDRGP4 cg+124728
ADDRGP4 cg+124716
INDIRI4
ASGNI4
line 436
;436:			cg.headEndTime = cg.time + 100 + random() * 2000;
ADDRLP4 28
ADDRGP4 rand
CALLI4
ASGNI4
ADDRGP4 cg+124716
ADDRGP4 cg+107604
INDIRI4
CNSTI4 100
ADDI4
CVIF4 4
CNSTF4 1157234688
ADDRLP4 28
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
MULF4
ADDF4
CVFI4 4
ASGNI4
line 438
;437:
;438:			cg.headEndYaw = 180 + 20 * cos( crandom()*M_PI );
ADDRLP4 32
ADDRGP4 rand
CALLI4
ASGNI4
CNSTF4 1078530011
CNSTF4 1073741824
ADDRLP4 32
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
SUBF4
MULF4
MULF4
ARGF4
ADDRLP4 36
ADDRGP4 cos
CALLF4
ASGNF4
ADDRGP4 cg+124712
CNSTF4 1101004800
ADDRLP4 36
INDIRF4
MULF4
CNSTF4 1127481344
ADDF4
ASGNF4
line 439
;439:			cg.headEndPitch = 5 * cos( crandom()*M_PI );
ADDRLP4 40
ADDRGP4 rand
CALLI4
ASGNI4
CNSTF4 1078530011
CNSTF4 1073741824
ADDRLP4 40
INDIRI4
CNSTI4 32767
BANDI4
CVIF4 4
CNSTF4 1191181824
DIVF4
CNSTF4 1056964608
SUBF4
MULF4
MULF4
ARGF4
ADDRLP4 44
ADDRGP4 cos
CALLF4
ASGNF4
ADDRGP4 cg+124708
CNSTF4 1084227584
ADDRLP4 44
INDIRF4
MULF4
ASGNF4
line 440
;440:		}
LABELV $225
line 442
;441:
;442:		size = ICON_SIZE * 1.25;
ADDRLP4 16
CNSTF4 1114636288
ASGNF4
line 443
;443:	}
LABELV $210
line 446
;444:
;445:	// if the server was frozen for a while we may have a bad head start time
;446:	if ( cg.headStartTime > cg.time ) {
ADDRGP4 cg+124728
INDIRI4
ADDRGP4 cg+107604
INDIRI4
LEI4 $239
line 447
;447:		cg.headStartTime = cg.time;
ADDRGP4 cg+124728
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 448
;448:	}
LABELV $239
line 450
;449:
;450:	frac = ( cg.time - cg.headStartTime ) / (float)( cg.headEndTime - cg.headStartTime );
ADDRLP4 0
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+124728
INDIRI4
SUBI4
CVIF4 4
ADDRGP4 cg+124716
INDIRI4
ADDRGP4 cg+124728
INDIRI4
SUBI4
CVIF4 4
DIVF4
ASGNF4
line 451
;451:	frac = frac * frac * ( 3 - 2 * frac );
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 0
INDIRF4
MULF4
CNSTF4 1077936128
CNSTF4 1073741824
ADDRLP4 0
INDIRF4
MULF4
SUBF4
MULF4
ASGNF4
line 452
;452:	angles[YAW] = cg.headStartYaw + ( cg.headEndYaw - cg.headStartYaw ) * frac;
ADDRLP4 4+4
ADDRGP4 cg+124724
INDIRF4
ADDRGP4 cg+124712
INDIRF4
ADDRGP4 cg+124724
INDIRF4
SUBF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
line 453
;453:	angles[PITCH] = cg.headStartPitch + ( cg.headEndPitch - cg.headStartPitch ) * frac;
ADDRLP4 4
ADDRGP4 cg+124720
INDIRF4
ADDRGP4 cg+124708
INDIRF4
ADDRGP4 cg+124720
INDIRF4
SUBF4
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
line 455
;454:
;455:	CG_DrawHead( x, 480 - size, size, size, 
ADDRFP4 0
INDIRF4
ARGF4
CNSTF4 1139802112
ADDRLP4 16
INDIRF4
SUBF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 CG_DrawHead
CALLV
pop
line 457
;456:				cg.snap->ps.clientNum, angles );
;457:}
LABELV $206
endproc CG_DrawStatusBarHead 56 24
proc CG_DrawStatusBarFlag 4 24
line 461
;458:#endif // MISSIONPACK
;459:
;460:#ifndef MISSIONPACK
;461:static void CG_DrawStatusBarFlag( float x, int team ) {
line 462
;462:	CG_DrawFlagModel( x, 480 - ICON_SIZE, ICON_SIZE, ICON_SIZE, team, qfalse );
ADDRFP4 0
INDIRF4
ARGF4
CNSTF4 1138229248
ARGF4
ADDRLP4 0
CNSTF4 1111490560
ASGNF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawFlagModel
CALLV
pop
line 463
;463:}
LABELV $257
endproc CG_DrawStatusBarFlag 4 24
export CG_DrawTeamBackground
proc CG_DrawTeamBackground 16 20
line 467
;464:#endif // MISSIONPACK
;465:
;466:void CG_DrawTeamBackground( int x, int y, int w, int h, float alpha, int team )
;467:{
line 470
;468:	vec4_t		hcolor;
;469:
;470:	hcolor[3] = alpha;
ADDRLP4 0+12
ADDRFP4 16
INDIRF4
ASGNF4
line 471
;471:	if ( team == TEAM_RED ) {
ADDRFP4 20
INDIRI4
CNSTI4 1
NEI4 $260
line 472
;472:		hcolor[0] = 1;
ADDRLP4 0
CNSTF4 1065353216
ASGNF4
line 473
;473:		hcolor[1] = 0;
ADDRLP4 0+4
CNSTF4 0
ASGNF4
line 474
;474:		hcolor[2] = 0;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 475
;475:	} else if ( team == TEAM_BLUE ) {
ADDRGP4 $261
JUMPV
LABELV $260
ADDRFP4 20
INDIRI4
CNSTI4 2
NEI4 $258
line 476
;476:		hcolor[0] = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 477
;477:		hcolor[1] = 0;
ADDRLP4 0+4
CNSTF4 0
ASGNF4
line 478
;478:		hcolor[2] = 1;
ADDRLP4 0+8
CNSTF4 1065353216
ASGNF4
line 479
;479:	} else {
line 480
;480:		return;
LABELV $265
LABELV $261
line 482
;481:	}
;482:	trap_R_SetColor( hcolor );
ADDRLP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 483
;483:	CG_DrawPic( x, y, w, h, cgs.media.teamStatusBar );
ADDRFP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 12
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 cgs+152340+128
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 484
;484:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 485
;485:}
LABELV $258
endproc CG_DrawTeamBackground 16 20
data
align 4
LABELV $271
byte 4 1065353216
byte 4 1060152279
byte 4 0
byte 4 1065353216
byte 4 1065353216
byte 4 1045220557
byte 4 1045220557
byte 4 1065353216
byte 4 1056964608
byte 4 1056964608
byte 4 1056964608
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
code
proc CG_DrawStatusBar 80 32
line 488
;486:
;487:#ifndef MISSIONPACK
;488:static void CG_DrawStatusBar( void ) {
line 505
;489:	int			color;
;490:	centity_t	*cent;
;491:	playerState_t	*ps;
;492:	int			value;
;493:	vec4_t		hcolor;
;494:	vec3_t		angles;
;495:	vec3_t		origin;
;496:#ifdef MISSIONPACK
;497:	qhandle_t	handle;
;498:#endif
;499:	static float colors[4][4] = { 
;500:		{ 1.0f, 0.69f, 0.0f, 1.0f },    // normal
;501:		{ 1.0f, 0.2f, 0.2f, 1.0f },     // low health
;502:		{ 0.5f, 0.5f, 0.5f, 1.0f },     // weapon firing
;503:		{ 1.0f, 1.0f, 1.0f, 1.0f } };   // health > 100
;504:
;505:	if ( cg_drawStatus.integer == 0 ) {
ADDRGP4 cg_drawStatus+12
INDIRI4
CNSTI4 0
NEI4 $272
line 506
;506:		return;
ADDRGP4 $270
JUMPV
LABELV $272
line 510
;507:	}
;508:
;509:	// draw the team background
;510:	CG_DrawTeamBackground( 0, 420, 640, 60, 0.33f, cg.snap->ps.persistant[PERS_TEAM] );
CNSTI4 0
ARGI4
CNSTI4 420
ARGI4
CNSTI4 640
ARGI4
CNSTI4 60
ARGI4
CNSTF4 1051260355
ARGF4
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawTeamBackground
CALLV
pop
line 512
;511:
;512:	cent = &cg_entities[cg.snap->ps.clientNum];
ADDRLP4 4
CNSTI4 728
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_entities
ADDP4
ASGNP4
line 513
;513:	ps = &cg.snap->ps;
ADDRLP4 20
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
line 515
;514:
;515:	VectorClear( angles );
ADDRLP4 56
CNSTF4 0
ASGNF4
ADDRLP4 8+8
ADDRLP4 56
INDIRF4
ASGNF4
ADDRLP4 8+4
ADDRLP4 56
INDIRF4
ASGNF4
ADDRLP4 8
ADDRLP4 56
INDIRF4
ASGNF4
line 518
;516:
;517:	// draw any 3D icons first, so the changes back to 2D are minimized
;518:	if ( cent->currentState.weapon && cg_weapons[ cent->currentState.weapon ].ammoModel ) {
ADDRLP4 60
ADDRLP4 4
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
ASGNI4
ADDRLP4 64
CNSTI4 0
ASGNI4
ADDRLP4 60
INDIRI4
ADDRLP4 64
INDIRI4
EQI4 $280
CNSTI4 136
ADDRLP4 60
INDIRI4
MULI4
ADDRGP4 cg_weapons+76
ADDP4
INDIRI4
ADDRLP4 64
INDIRI4
EQI4 $280
line 519
;519:		origin[0] = 70;
ADDRLP4 24
CNSTF4 1116471296
ASGNF4
line 520
;520:		origin[1] = 0;
ADDRLP4 24+4
CNSTF4 0
ASGNF4
line 521
;521:		origin[2] = 0;
ADDRLP4 24+8
CNSTF4 0
ASGNF4
line 522
;522:		angles[YAW] = 90 + 20 * sin( cg.time / 1000.0 );
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
CNSTF4 1148846080
DIVF4
ARGF4
ADDRLP4 68
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 8+4
CNSTF4 1101004800
ADDRLP4 68
INDIRF4
MULF4
CNSTF4 1119092736
ADDF4
ASGNF4
line 523
;523:		CG_Draw3DModel( CHAR_WIDTH*3 + TEXT_ICON_SPACE, 432, ICON_SIZE, ICON_SIZE,
CNSTF4 1120403456
ARGF4
CNSTF4 1138229248
ARGF4
ADDRLP4 72
CNSTF4 1111490560
ASGNF4
ADDRLP4 72
INDIRF4
ARGF4
ADDRLP4 72
INDIRF4
ARGF4
CNSTI4 136
ADDRLP4 4
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_weapons+76
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 24
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 CG_Draw3DModel
CALLV
pop
line 525
;524:					   cg_weapons[ cent->currentState.weapon ].ammoModel, 0, origin, angles );
;525:	}
LABELV $280
line 527
;526:
;527:	CG_DrawStatusBarHead( 185 + CHAR_WIDTH*3 + TEXT_ICON_SPACE );
CNSTF4 1133412352
ARGF4
ADDRGP4 CG_DrawStatusBarHead
CALLV
pop
line 529
;528:
;529:	if( cg.predictedPlayerState.powerups[PW_REDFLAG] ) {
ADDRGP4 cg+107636+312+28
INDIRI4
CNSTI4 0
EQI4 $288
line 530
;530:		CG_DrawStatusBarFlag( 185 + CHAR_WIDTH*3 + TEXT_ICON_SPACE + ICON_SIZE, TEAM_RED );
CNSTF4 1134985216
ARGF4
CNSTI4 1
ARGI4
ADDRGP4 CG_DrawStatusBarFlag
CALLV
pop
line 531
;531:	} else if( cg.predictedPlayerState.powerups[PW_BLUEFLAG] ) {
ADDRGP4 $289
JUMPV
LABELV $288
ADDRGP4 cg+107636+312+32
INDIRI4
CNSTI4 0
EQI4 $293
line 532
;532:		CG_DrawStatusBarFlag( 185 + CHAR_WIDTH*3 + TEXT_ICON_SPACE + ICON_SIZE, TEAM_BLUE );
CNSTF4 1134985216
ARGF4
CNSTI4 2
ARGI4
ADDRGP4 CG_DrawStatusBarFlag
CALLV
pop
line 533
;533:	} else if( cg.predictedPlayerState.powerups[PW_NEUTRALFLAG] ) {
ADDRGP4 $294
JUMPV
LABELV $293
ADDRGP4 cg+107636+312+36
INDIRI4
CNSTI4 0
EQI4 $298
line 534
;534:		CG_DrawStatusBarFlag( 185 + CHAR_WIDTH*3 + TEXT_ICON_SPACE + ICON_SIZE, TEAM_FREE );
CNSTF4 1134985216
ARGF4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawStatusBarFlag
CALLV
pop
line 535
;535:	}
LABELV $298
LABELV $294
LABELV $289
line 537
;536:
;537:	if ( ps->stats[ STAT_ARMOR ] ) {
ADDRLP4 20
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
CNSTI4 0
EQI4 $303
line 538
;538:		origin[0] = 90;
ADDRLP4 24
CNSTF4 1119092736
ASGNF4
line 539
;539:		origin[1] = 0;
ADDRLP4 24+4
CNSTF4 0
ASGNF4
line 540
;540:		origin[2] = -10;
ADDRLP4 24+8
CNSTF4 3240099840
ASGNF4
line 541
;541:		angles[YAW] = ( cg.time & 2047 ) * 360 / 2048.0;
ADDRLP4 8+4
CNSTI4 360
ADDRGP4 cg+107604
INDIRI4
CNSTI4 2047
BANDI4
MULI4
CVIF4 4
CNSTF4 1157627904
DIVF4
ASGNF4
line 542
;542:		CG_Draw3DModel( 370 + CHAR_WIDTH*3 + TEXT_ICON_SPACE, 432, ICON_SIZE, ICON_SIZE,
CNSTF4 1139474432
ARGF4
CNSTF4 1138229248
ARGF4
ADDRLP4 68
CNSTF4 1111490560
ASGNF4
ADDRLP4 68
INDIRF4
ARGF4
ADDRLP4 68
INDIRF4
ARGF4
ADDRGP4 cgs+152340+120
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 24
ARGP4
ADDRLP4 8
ARGP4
ADDRGP4 CG_Draw3DModel
CALLV
pop
line 544
;543:					   cgs.media.armorModel, 0, origin, angles );
;544:	}
LABELV $303
line 562
;545:#ifdef MISSIONPACK
;546:	if( cgs.gametype == GT_HARVESTER ) {
;547:		origin[0] = 90;
;548:		origin[1] = 0;
;549:		origin[2] = -10;
;550:		angles[YAW] = ( cg.time & 2047 ) * 360 / 2048.0;
;551:		if( cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE ) {
;552:			handle = cgs.media.redCubeModel;
;553:		} else {
;554:			handle = cgs.media.blueCubeModel;
;555:		}
;556:		CG_Draw3DModel( 640 - (TEXT_ICON_SPACE + ICON_SIZE), 416, ICON_SIZE, ICON_SIZE, handle, 0, origin, angles );
;557:	}
;558:#endif
;559:	//
;560:	// ammo
;561:	//
;562:	if ( cent->currentState.weapon ) {
ADDRLP4 4
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 0
EQI4 $311
line 563
;563:		value = ps->ammo[cent->currentState.weapon];
ADDRLP4 0
ADDRLP4 4
INDIRP4
CNSTI4 192
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 20
INDIRP4
CNSTI4 376
ADDP4
ADDP4
INDIRI4
ASGNI4
line 564
;564:		if ( value > -1 ) {
ADDRLP4 0
INDIRI4
CNSTI4 -1
LEI4 $313
line 565
;565:			if ( cg.predictedPlayerState.weaponstate == WEAPON_FIRING
ADDRGP4 cg+107636+148
INDIRI4
CNSTI4 3
NEI4 $315
ADDRGP4 cg+107636+44
INDIRI4
CNSTI4 100
LEI4 $315
line 566
;566:				&& cg.predictedPlayerState.weaponTime > 100 ) {
line 568
;567:				// draw as dark grey when reloading
;568:				color = 2;	// dark grey
ADDRLP4 52
CNSTI4 2
ASGNI4
line 569
;569:			} else {
ADDRGP4 $316
JUMPV
LABELV $315
line 570
;570:				if ( value >= 0 ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $321
line 571
;571:					color = 0;	// green
ADDRLP4 52
CNSTI4 0
ASGNI4
line 572
;572:				} else {
ADDRGP4 $322
JUMPV
LABELV $321
line 573
;573:					color = 1;	// red
ADDRLP4 52
CNSTI4 1
ASGNI4
line 574
;574:				}
LABELV $322
line 575
;575:			}
LABELV $316
line 576
;576:			trap_R_SetColor( colors[color] );
ADDRLP4 52
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 $271
ADDP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 578
;577:			
;578:			CG_DrawField (0, 432, 3, value);
CNSTI4 0
ARGI4
CNSTI4 432
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_DrawField
CALLV
pop
line 579
;579:			trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 582
;580:
;581:			// if we didn't draw a 3D icon, draw a 2D icon for ammo
;582:			if ( !cg_draw3dIcons.integer && cg_drawIcons.integer ) {
ADDRLP4 68
CNSTI4 0
ASGNI4
ADDRGP4 cg_draw3dIcons+12
INDIRI4
ADDRLP4 68
INDIRI4
NEI4 $323
ADDRGP4 cg_drawIcons+12
INDIRI4
ADDRLP4 68
INDIRI4
EQI4 $323
line 585
;583:				qhandle_t	icon;
;584:
;585:				icon = cg_weapons[ cg.predictedPlayerState.weapon ].ammoIcon;
ADDRLP4 72
CNSTI4 136
ADDRGP4 cg+107636+144
INDIRI4
MULI4
ADDRGP4 cg_weapons+72
ADDP4
INDIRI4
ASGNI4
line 586
;586:				if ( icon ) {
ADDRLP4 72
INDIRI4
CNSTI4 0
EQI4 $330
line 587
;587:					CG_DrawPic( CHAR_WIDTH*3 + TEXT_ICON_SPACE, 432, ICON_SIZE, ICON_SIZE, icon );
CNSTF4 1120403456
ARGF4
CNSTF4 1138229248
ARGF4
ADDRLP4 76
CNSTF4 1111490560
ASGNF4
ADDRLP4 76
INDIRF4
ARGF4
ADDRLP4 76
INDIRF4
ARGF4
ADDRLP4 72
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 588
;588:				}
LABELV $330
line 589
;589:			}
LABELV $323
line 590
;590:		}
LABELV $313
line 591
;591:	}
LABELV $311
line 596
;592:
;593:	//
;594:	// health
;595:	//
;596:	value = ps->stats[STAT_HEALTH];
ADDRLP4 0
ADDRLP4 20
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ASGNI4
line 597
;597:	if ( value > 100 ) {
ADDRLP4 0
INDIRI4
CNSTI4 100
LEI4 $332
line 598
;598:		trap_R_SetColor( colors[3] );		// white
ADDRGP4 $271+48
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 599
;599:	} else if (value > 25) {
ADDRGP4 $333
JUMPV
LABELV $332
ADDRLP4 0
INDIRI4
CNSTI4 25
LEI4 $335
line 600
;600:		trap_R_SetColor( colors[0] );	// green
ADDRGP4 $271
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 601
;601:	} else if (value > 0) {
ADDRGP4 $336
JUMPV
LABELV $335
ADDRLP4 0
INDIRI4
CNSTI4 0
LEI4 $337
line 602
;602:		color = (cg.time >> 8) & 1;	// flash
ADDRLP4 52
ADDRGP4 cg+107604
INDIRI4
CNSTI4 8
RSHI4
CNSTI4 1
BANDI4
ASGNI4
line 603
;603:		trap_R_SetColor( colors[color] );
ADDRLP4 52
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 $271
ADDP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 604
;604:	} else {
ADDRGP4 $338
JUMPV
LABELV $337
line 605
;605:		trap_R_SetColor( colors[1] );	// red
ADDRGP4 $271+16
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 606
;606:	}
LABELV $338
LABELV $336
LABELV $333
line 609
;607:
;608:	// stretch the health up when taking damage
;609:	CG_DrawField ( 185, 432, 3, value);
CNSTI4 185
ARGI4
CNSTI4 432
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_DrawField
CALLV
pop
line 610
;610:	CG_ColorForHealth( hcolor );
ADDRLP4 36
ARGP4
ADDRGP4 CG_ColorForHealth
CALLV
pop
line 611
;611:	trap_R_SetColor( hcolor );
ADDRLP4 36
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 617
;612:
;613:
;614:	//
;615:	// armor
;616:	//
;617:	value = ps->stats[STAT_ARMOR];
ADDRLP4 0
ADDRLP4 20
INDIRP4
CNSTI4 196
ADDP4
INDIRI4
ASGNI4
line 618
;618:	if (value > 0 ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LEI4 $341
line 619
;619:		trap_R_SetColor( colors[0] );
ADDRGP4 $271
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 620
;620:		CG_DrawField (370, 432, 3, value);
CNSTI4 370
ARGI4
CNSTI4 432
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_DrawField
CALLV
pop
line 621
;621:		trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 623
;622:		// if we didn't draw a 3D icon, draw a 2D icon for armor
;623:		if ( !cg_draw3dIcons.integer && cg_drawIcons.integer ) {
ADDRLP4 68
CNSTI4 0
ASGNI4
ADDRGP4 cg_draw3dIcons+12
INDIRI4
ADDRLP4 68
INDIRI4
NEI4 $343
ADDRGP4 cg_drawIcons+12
INDIRI4
ADDRLP4 68
INDIRI4
EQI4 $343
line 624
;624:			CG_DrawPic( 370 + CHAR_WIDTH*3 + TEXT_ICON_SPACE, 432, ICON_SIZE, ICON_SIZE, cgs.media.armorIcon );
CNSTF4 1139474432
ARGF4
CNSTF4 1138229248
ARGF4
ADDRLP4 72
CNSTF4 1111490560
ASGNF4
ADDRLP4 72
INDIRF4
ARGF4
ADDRLP4 72
INDIRF4
ARGF4
ADDRGP4 cgs+152340+124
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 625
;625:		}
LABELV $343
line 627
;626:
;627:	}
LABELV $341
line 651
;628:#ifdef MISSIONPACK
;629:	//
;630:	// cubes
;631:	//
;632:	if( cgs.gametype == GT_HARVESTER ) {
;633:		value = ps->generic1;
;634:		if( value > 99 ) {
;635:			value = 99;
;636:		}
;637:		trap_R_SetColor( colors[0] );
;638:		CG_DrawField (640 - (CHAR_WIDTH*2 + TEXT_ICON_SPACE + ICON_SIZE), 432, 2, value);
;639:		trap_R_SetColor( NULL );
;640:		// if we didn't draw a 3D icon, draw a 2D icon for armor
;641:		if ( !cg_draw3dIcons.integer && cg_drawIcons.integer ) {
;642:			if( cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE ) {
;643:				handle = cgs.media.redCubeIcon;
;644:			} else {
;645:				handle = cgs.media.blueCubeIcon;
;646:			}
;647:			CG_DrawPic( 640 - (TEXT_ICON_SPACE + ICON_SIZE), 432, ICON_SIZE, ICON_SIZE, handle );
;648:		}
;649:	}
;650:#endif
;651:}
LABELV $270
endproc CG_DrawStatusBar 80 32
proc CG_DrawAttacker 52 24
line 663
;652:#endif
;653:
;654:/*
;655:===========================================================================================
;656:
;657:  UPPER RIGHT CORNER
;658:
;659:===========================================================================================
;660:*/
;661:
;662:
;663:static float CG_DrawAttacker( float y ) {
line 671
;664:	int			t;
;665:	float		size;
;666:	vec3_t		angles;
;667:	const char	*info;
;668:	const char	*name;
;669:	int			clientNum;
;670:
;671:	if ( cg.predictedPlayerState.stats[STAT_HEALTH] <= 0 ) {
ADDRGP4 cg+107636+184
INDIRI4
CNSTI4 0
GTI4 $350
line 672
;672:		return y;
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $349
JUMPV
LABELV $350
line 675
;673:	}
;674:
;675:	if ( !cg.attackerTime ) {
ADDRGP4 cg+124416
INDIRI4
CNSTI4 0
NEI4 $354
line 676
;676:		return y;
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $349
JUMPV
LABELV $354
line 679
;677:	}
;678:
;679:	clientNum = cg.predictedPlayerState.persistant[PERS_ATTACKER];
ADDRLP4 0
ADDRGP4 cg+107636+248+24
INDIRI4
ASGNI4
line 680
;680:	if ( clientNum < 0 || clientNum >= MAX_CLIENTS || clientNum == cg.snap->ps.clientNum ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $364
ADDRLP4 0
INDIRI4
CNSTI4 64
GEI4 $364
ADDRLP4 0
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
NEI4 $360
LABELV $364
line 681
;681:		return y;
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $349
JUMPV
LABELV $360
line 684
;682:	}
;683:
;684:	t = cg.time - cg.attackerTime;
ADDRLP4 24
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+124416
INDIRI4
SUBI4
ASGNI4
line 685
;685:	if ( t > ATTACKER_HEAD_TIME ) {
ADDRLP4 24
INDIRI4
CNSTI4 10000
LEI4 $367
line 686
;686:		cg.attackerTime = 0;
ADDRGP4 cg+124416
CNSTI4 0
ASGNI4
line 687
;687:		return y;
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $349
JUMPV
LABELV $367
line 690
;688:	}
;689:
;690:	size = ICON_SIZE * 1.25;
ADDRLP4 4
CNSTF4 1114636288
ASGNF4
line 692
;691:
;692:	angles[PITCH] = 0;
ADDRLP4 8
CNSTF4 0
ASGNF4
line 693
;693:	angles[YAW] = 180;
ADDRLP4 8+4
CNSTF4 1127481344
ASGNF4
line 694
;694:	angles[ROLL] = 0;
ADDRLP4 8+8
CNSTF4 0
ASGNF4
line 695
;695:	CG_DrawHead( 640 - size, y, size, size, clientNum, angles );
CNSTF4 1142947840
ADDRLP4 4
INDIRF4
SUBF4
ARGF4
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
ADDRGP4 CG_DrawHead
CALLV
pop
line 697
;696:
;697:	info = CG_ConfigString( CS_PLAYERS + clientNum );
ADDRLP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 40
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 28
ADDRLP4 40
INDIRP4
ASGNP4
line 698
;698:	name = Info_ValueForKey(  info, "n" );
ADDRLP4 28
INDIRP4
ARGP4
ADDRGP4 $372
ARGP4
ADDRLP4 44
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 44
INDIRP4
ASGNP4
line 699
;699:	y += size;
ADDRFP4 0
ADDRFP4 0
INDIRF4
ADDRLP4 4
INDIRF4
ADDF4
ASGNF4
line 700
;700:	CG_DrawBigString( 640 - ( Q_PrintStrlen( name ) * BIGCHAR_WIDTH), y, name, 0.5 );
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 48
ADDRGP4 Q_PrintStrlen
CALLI4
ASGNI4
CNSTI4 640
ADDRLP4 48
INDIRI4
CNSTI4 4
LSHI4
SUBI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 20
INDIRP4
ARGP4
CNSTF4 1056964608
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 702
;701:
;702:	return y + BIGCHAR_HEIGHT + 2;
ADDRFP4 0
INDIRF4
CNSTF4 1098907648
ADDF4
CNSTF4 1073741824
ADDF4
RETF4
LABELV $349
endproc CG_DrawAttacker 52 24
proc CG_DrawSnapshot 16 16
line 706
;703:}
;704:
;705:
;706:static float CG_DrawSnapshot( float y ) {
line 710
;707:	char		*s;
;708:	int			w;
;709:
;710:	s = va( "time:%i snap:%i cmd:%i", cg.snap->serverTime, 
ADDRGP4 $374
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 cg+28
INDIRI4
ARGI4
ADDRGP4 cgs+31444
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 712
;711:		cg.latestSnapshotNum, cgs.serverCommandSequence );
;712:	w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH;
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 12
INDIRI4
CNSTI4 4
LSHI4
ASGNI4
line 714
;713:
;714:	CG_DrawBigString( 635 - w, y + 2, s, 1.0F);
CNSTI4 635
ADDRLP4 4
INDIRI4
SUBI4
ARGI4
ADDRFP4 0
INDIRF4
CNSTF4 1073741824
ADDF4
CVFI4 4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 716
;715:
;716:	return y + BIGCHAR_HEIGHT + 4;
ADDRFP4 0
INDIRF4
CNSTF4 1098907648
ADDF4
CNSTF4 1082130432
ADDF4
RETF4
LABELV $373
endproc CG_DrawSnapshot 16 16
bss
align 4
LABELV $379
skip 16
align 4
LABELV $380
skip 4
align 4
LABELV $381
skip 4
code
proc CG_DrawFPS 44 16
line 725
;717:}
;718:
;719:/*
;720:==================
;721:CG_DrawFPS
;722:==================
;723:*/
;724:#define	FPS_FRAMES	4	// 今回の1コマに要した時間ではなく、直近の4コマを描くのに要した時間から、FPSを計算する。
;725:static float CG_DrawFPS( float y ) {
line 737
;726:	char		*s;
;727:	int			w;
;728:	static int	previousTimes[FPS_FRAMES];
;729:	static int	index;
;730:	int		i, total;
;731:	int		fps;
;732:	static	int	previous;
;733:	int		t, frameTime;
;734:
;735:	// don't use serverTime, because that will be drifting to
;736:	// correct for internet lag changes, timescales, timedemos, etc
;737:	t = trap_Milliseconds();
ADDRLP4 28
ADDRGP4 trap_Milliseconds
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 28
INDIRI4
ASGNI4
line 738
;738:	frameTime = t - previous;
ADDRLP4 12
ADDRLP4 8
INDIRI4
ADDRGP4 $381
INDIRI4
SUBI4
ASGNI4
line 739
;739:	previous = t;
ADDRGP4 $381
ADDRLP4 8
INDIRI4
ASGNI4
line 741
;740:
;741:	previousTimes[index % FPS_FRAMES] = frameTime;
ADDRGP4 $380
INDIRI4
CNSTI4 4
MODI4
CNSTI4 2
LSHI4
ADDRGP4 $379
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
line 742
;742:	index++;
ADDRLP4 32
ADDRGP4 $380
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 743
;743:	if ( index > FPS_FRAMES ) {
ADDRGP4 $380
INDIRI4
CNSTI4 4
LEI4 $382
line 745
;744:		// average multiple frames together to smooth changes out a bit
;745:		total = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 746
;746:		for ( i = 0 ; i < FPS_FRAMES ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $384
line 747
;747:			total += previousTimes[i];
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $379
ADDP4
INDIRI4
ADDI4
ASGNI4
line 748
;748:		}
LABELV $385
line 746
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 4
LTI4 $384
line 749
;749:		if ( !total ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $388
line 750
;750:			total = 1;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 751
;751:		}
LABELV $388
line 752
;752:		fps = 1000 * FPS_FRAMES / total;
ADDRLP4 24
CNSTI4 4000
ADDRLP4 4
INDIRI4
DIVI4
ASGNI4
line 754
;753:
;754:		s = va( "%ifps", fps );
ADDRGP4 $390
ARGP4
ADDRLP4 24
INDIRI4
ARGI4
ADDRLP4 36
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 36
INDIRP4
ASGNP4
line 755
;755:		w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH;
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 40
INDIRI4
CNSTI4 4
LSHI4
ASGNI4
line 757
;756:
;757:		CG_DrawBigString( 635 - w, y + 2, s, 1.0F);
CNSTI4 635
ADDRLP4 20
INDIRI4
SUBI4
ARGI4
ADDRFP4 0
INDIRF4
CNSTF4 1073741824
ADDF4
CVFI4 4
ARGI4
ADDRLP4 16
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 758
;758:	}
LABELV $382
line 760
;759:
;760:	return y + BIGCHAR_HEIGHT + 4;
ADDRFP4 0
INDIRF4
CNSTF4 1098907648
ADDF4
CNSTF4 1082130432
ADDF4
RETF4
LABELV $378
endproc CG_DrawFPS 44 16
proc CG_DrawTimer 32 16
line 764
;761:}
;762:
;763:
;764:static float CG_DrawTimer( float y ) {
line 770
;765:	char		*s;
;766:	int			w;
;767:	int			mins, seconds, tens;
;768:	int			msec;
;769:
;770:	msec = cg.time - cgs.levelStartTime;
ADDRLP4 20
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cgs+34796
INDIRI4
SUBI4
ASGNI4
line 772
;771:
;772:	seconds = msec / 1000;
ADDRLP4 0
ADDRLP4 20
INDIRI4
CNSTI4 1000
DIVI4
ASGNI4
line 773
;773:	mins = seconds / 60;
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 60
DIVI4
ASGNI4
line 774
;774:	seconds -= mins * 60;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 60
ADDRLP4 8
INDIRI4
MULI4
SUBI4
ASGNI4
line 775
;775:	tens = seconds / 10;
ADDRLP4 12
ADDRLP4 0
INDIRI4
CNSTI4 10
DIVI4
ASGNI4
line 776
;776:	seconds -= tens * 10;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 10
ADDRLP4 12
INDIRI4
MULI4
SUBI4
ASGNI4
line 778
;777:
;778:	s = va( "%i:%i%i", mins, tens, seconds );
ADDRGP4 $394
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 24
INDIRP4
ASGNP4
line 779
;779:	w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH;
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 28
INDIRI4
CNSTI4 4
LSHI4
ASGNI4
line 781
;780:
;781:	CG_DrawBigString( 635 - w, y + 2, s, 1.0F);
CNSTI4 635
ADDRLP4 16
INDIRI4
SUBI4
ARGI4
ADDRFP4 0
INDIRF4
CNSTF4 1073741824
ADDF4
CVFI4 4
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 783
;782:
;783:	return y + BIGCHAR_HEIGHT + 4;
ADDRFP4 0
INDIRF4
CNSTF4 1098907648
ADDF4
CNSTF4 1082130432
ADDF4
RETF4
LABELV $391
endproc CG_DrawTimer 32 16
proc CG_DrawTeamOverlay 148 36
line 787
;784:}
;785:
;786:
;787:static float CG_DrawTeamOverlay( float y, qboolean right, qboolean upper ) {
line 799
;788:	int x, w, h, xx;
;789:	int i, j, len;
;790:	const char *p;
;791:	vec4_t		hcolor;
;792:	int pwidth, lwidth;
;793:	int plyrs;
;794:	char st[16];
;795:	clientInfo_t *ci;
;796:	gitem_t	*item;
;797:	int ret_y, count;
;798:
;799:	if ( !cg_drawTeamOverlay.integer ) {
ADDRGP4 cg_drawTeamOverlay+12
INDIRI4
CNSTI4 0
NEI4 $396
line 800
;800:		return y;
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $395
JUMPV
LABELV $396
line 803
;801:	}
;802:
;803:	if ( cg.snap->ps.persistant[PERS_TEAM] != TEAM_RED && cg.snap->ps.persistant[PERS_TEAM] != TEAM_BLUE ) {
ADDRLP4 92
CNSTI4 304
ASGNI4
ADDRGP4 cg+36
INDIRP4
ADDRLP4 92
INDIRI4
ADDP4
INDIRI4
CNSTI4 1
EQI4 $399
ADDRGP4 cg+36
INDIRP4
ADDRLP4 92
INDIRI4
ADDP4
INDIRI4
CNSTI4 2
EQI4 $399
line 804
;804:		return y; // Not on any team
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $395
JUMPV
LABELV $399
line 807
;805:	}
;806:
;807:	plyrs = 0;
ADDRLP4 76
CNSTI4 0
ASGNI4
line 810
;808:
;809:	// max player name width
;810:	pwidth = 0;
ADDRLP4 56
CNSTI4 0
ASGNI4
line 811
;811:	count = (numSortedTeamPlayers > 8) ? 8 : numSortedTeamPlayers;
ADDRGP4 numSortedTeamPlayers
INDIRI4
CNSTI4 8
LEI4 $404
ADDRLP4 96
CNSTI4 8
ASGNI4
ADDRGP4 $405
JUMPV
LABELV $404
ADDRLP4 96
ADDRGP4 numSortedTeamPlayers
INDIRI4
ASGNI4
LABELV $405
ADDRLP4 48
ADDRLP4 96
INDIRI4
ASGNI4
line 812
;812:	for (i = 0; i < count; i++) {
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $409
JUMPV
LABELV $406
line 813
;813:		ci = cgs.clientinfo + sortedTeamPlayers[i];
ADDRLP4 4
CNSTI4 1708
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 sortedTeamPlayers
ADDP4
INDIRI4
MULI4
ADDRGP4 cgs+40972
ADDP4
ASGNP4
line 814
;814:		if ( ci->infoValid && ci->team == cg.snap->ps.persistant[PERS_TEAM]) {
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $411
ADDRLP4 4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
NEI4 $411
line 815
;815:			plyrs++;
ADDRLP4 76
ADDRLP4 76
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 816
;816:			len = CG_DrawStrlen(ci->name);
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 104
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 40
ADDRLP4 104
INDIRI4
ASGNI4
line 817
;817:			if (len > pwidth)
ADDRLP4 40
INDIRI4
ADDRLP4 56
INDIRI4
LEI4 $414
line 818
;818:				pwidth = len;
ADDRLP4 56
ADDRLP4 40
INDIRI4
ASGNI4
LABELV $414
line 819
;819:		}
LABELV $411
line 820
;820:	}
LABELV $407
line 812
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $409
ADDRLP4 8
INDIRI4
ADDRLP4 48
INDIRI4
LTI4 $406
line 822
;821:
;822:	if (!plyrs)
ADDRLP4 76
INDIRI4
CNSTI4 0
NEI4 $416
line 823
;823:		return y;
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $395
JUMPV
LABELV $416
line 825
;824:
;825:	if (pwidth > TEAM_OVERLAY_MAXNAME_WIDTH)
ADDRLP4 56
INDIRI4
CNSTI4 12
LEI4 $418
line 826
;826:		pwidth = TEAM_OVERLAY_MAXNAME_WIDTH;
ADDRLP4 56
CNSTI4 12
ASGNI4
LABELV $418
line 829
;827:
;828:	// max location name width
;829:	lwidth = 0;
ADDRLP4 44
CNSTI4 0
ASGNI4
line 830
;830:	for (i = 1; i < MAX_LOCATIONS; i++) {
ADDRLP4 8
CNSTI4 1
ASGNI4
LABELV $420
line 831
;831:		p = CG_ConfigString(CS_LOCATIONS + i);
ADDRLP4 8
INDIRI4
CNSTI4 608
ADDI4
ARGI4
ADDRLP4 100
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 100
INDIRP4
ASGNP4
line 832
;832:		if (p && *p) {
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $424
ADDRLP4 20
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $424
line 833
;833:			len = CG_DrawStrlen(p);
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 108
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 40
ADDRLP4 108
INDIRI4
ASGNI4
line 834
;834:			if (len > lwidth)
ADDRLP4 40
INDIRI4
ADDRLP4 44
INDIRI4
LEI4 $426
line 835
;835:				lwidth = len;
ADDRLP4 44
ADDRLP4 40
INDIRI4
ASGNI4
LABELV $426
line 836
;836:		}
LABELV $424
line 837
;837:	}
LABELV $421
line 830
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 64
LTI4 $420
line 839
;838:
;839:	if (lwidth > TEAM_OVERLAY_MAXLOCATION_WIDTH)
ADDRLP4 44
INDIRI4
CNSTI4 16
LEI4 $428
line 840
;840:		lwidth = TEAM_OVERLAY_MAXLOCATION_WIDTH;
ADDRLP4 44
CNSTI4 16
ASGNI4
LABELV $428
line 842
;841:
;842:	w = (pwidth + lwidth + 4 + 7) * TINYCHAR_WIDTH;
ADDRLP4 80
ADDRLP4 56
INDIRI4
ADDRLP4 44
INDIRI4
ADDI4
CNSTI4 3
LSHI4
CNSTI4 32
ADDI4
CNSTI4 56
ADDI4
ASGNI4
line 844
;843:
;844:	if ( right )
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $430
line 845
;845:		x = 640 - w;
ADDRLP4 52
CNSTI4 640
ADDRLP4 80
INDIRI4
SUBI4
ASGNI4
ADDRGP4 $431
JUMPV
LABELV $430
line 847
;846:	else
;847:		x = 0;
ADDRLP4 52
CNSTI4 0
ASGNI4
LABELV $431
line 849
;848:
;849:	h = plyrs * TINYCHAR_HEIGHT;
ADDRLP4 84
ADDRLP4 76
INDIRI4
CNSTI4 3
LSHI4
ASGNI4
line 851
;850:
;851:	if ( upper ) {
ADDRFP4 8
INDIRI4
CNSTI4 0
EQI4 $432
line 852
;852:		ret_y = y + h;
ADDRLP4 88
ADDRFP4 0
INDIRF4
ADDRLP4 84
INDIRI4
CVIF4 4
ADDF4
CVFI4 4
ASGNI4
line 853
;853:	} else {
ADDRGP4 $433
JUMPV
LABELV $432
line 854
;854:		y -= h;
ADDRFP4 0
ADDRFP4 0
INDIRF4
ADDRLP4 84
INDIRI4
CVIF4 4
SUBF4
ASGNF4
line 855
;855:		ret_y = y;
ADDRLP4 88
ADDRFP4 0
INDIRF4
CVFI4 4
ASGNI4
line 856
;856:	}
LABELV $433
line 858
;857:
;858:	if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_RED ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 1
NEI4 $434
line 859
;859:		hcolor[0] = 1.0f;
ADDRLP4 24
CNSTF4 1065353216
ASGNF4
line 860
;860:		hcolor[1] = 0.0f;
ADDRLP4 24+4
CNSTF4 0
ASGNF4
line 861
;861:		hcolor[2] = 0.0f;
ADDRLP4 24+8
CNSTF4 0
ASGNF4
line 862
;862:		hcolor[3] = 0.33f;
ADDRLP4 24+12
CNSTF4 1051260355
ASGNF4
line 863
;863:	} else { // if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE )
ADDRGP4 $435
JUMPV
LABELV $434
line 864
;864:		hcolor[0] = 0.0f;
ADDRLP4 24
CNSTF4 0
ASGNF4
line 865
;865:		hcolor[1] = 0.0f;
ADDRLP4 24+4
CNSTF4 0
ASGNF4
line 866
;866:		hcolor[2] = 1.0f;
ADDRLP4 24+8
CNSTF4 1065353216
ASGNF4
line 867
;867:		hcolor[3] = 0.33f;
ADDRLP4 24+12
CNSTF4 1051260355
ASGNF4
line 868
;868:	}
LABELV $435
line 869
;869:	trap_R_SetColor( hcolor );
ADDRLP4 24
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 870
;870:	CG_DrawPic( x, y, w, h, cgs.media.teamStatusBar );
ADDRLP4 52
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 80
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 84
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 cgs+152340+128
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 871
;871:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 873
;872:
;873:	for (i = 0; i < count; i++) {
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $448
JUMPV
LABELV $445
line 874
;874:		ci = cgs.clientinfo + sortedTeamPlayers[i];
ADDRLP4 4
CNSTI4 1708
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 sortedTeamPlayers
ADDP4
INDIRI4
MULI4
ADDRGP4 cgs+40972
ADDP4
ASGNP4
line 875
;875:		if ( ci->infoValid && ci->team == cg.snap->ps.persistant[PERS_TEAM]) {
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $450
ADDRLP4 4
INDIRP4
CNSTI4 68
ADDP4
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
NEI4 $450
line 877
;876:
;877:			hcolor[0] = hcolor[1] = hcolor[2] = hcolor[3] = 1.0;
ADDRLP4 104
CNSTF4 1065353216
ASGNF4
ADDRLP4 24+12
ADDRLP4 104
INDIRF4
ASGNF4
ADDRLP4 24+8
ADDRLP4 104
INDIRF4
ASGNF4
ADDRLP4 24+4
ADDRLP4 104
INDIRF4
ASGNF4
ADDRLP4 24
ADDRLP4 104
INDIRF4
ASGNF4
line 879
;878:
;879:			xx = x + TINYCHAR_WIDTH;
ADDRLP4 12
ADDRLP4 52
INDIRI4
CNSTI4 8
ADDI4
ASGNI4
line 881
;880:
;881:			CG_DrawStringExt( xx, y,
ADDRLP4 12
INDIRI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 108
CNSTI4 0
ASGNI4
ADDRLP4 108
INDIRI4
ARGI4
ADDRLP4 108
INDIRI4
ARGI4
ADDRLP4 112
CNSTI4 8
ASGNI4
ADDRLP4 112
INDIRI4
ARGI4
ADDRLP4 112
INDIRI4
ARGI4
CNSTI4 12
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 885
;882:				ci->name, hcolor, qfalse, qfalse,
;883:				TINYCHAR_WIDTH, TINYCHAR_HEIGHT, TEAM_OVERLAY_MAXNAME_WIDTH);
;884:
;885:			if (lwidth) {
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $456
line 886
;886:				p = CG_ConfigString(CS_LOCATIONS + ci->location);
ADDRLP4 4
INDIRP4
CNSTI4 104
ADDP4
INDIRI4
CNSTI4 608
ADDI4
ARGI4
ADDRLP4 116
ADDRGP4 CG_ConfigString
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 116
INDIRP4
ASGNP4
line 887
;887:				if (!p || !*p)
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $460
ADDRLP4 20
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $458
LABELV $460
line 888
;888:					p = "unknown";
ADDRLP4 20
ADDRGP4 $461
ASGNP4
LABELV $458
line 889
;889:				len = CG_DrawStrlen(p);
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 124
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 40
ADDRLP4 124
INDIRI4
ASGNI4
line 890
;890:				if (len > lwidth)
ADDRLP4 40
INDIRI4
ADDRLP4 44
INDIRI4
LEI4 $462
line 891
;891:					len = lwidth;
ADDRLP4 40
ADDRLP4 44
INDIRI4
ASGNI4
LABELV $462
line 893
;892:
;893:				xx = x + TINYCHAR_WIDTH * 2 + TINYCHAR_WIDTH * pwidth;
ADDRLP4 12
ADDRLP4 52
INDIRI4
CNSTI4 16
ADDI4
ADDRLP4 56
INDIRI4
CNSTI4 3
LSHI4
ADDI4
ASGNI4
line 894
;894:				CG_DrawStringExt( xx, y,
ADDRLP4 12
INDIRI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 128
CNSTI4 0
ASGNI4
ADDRLP4 128
INDIRI4
ARGI4
ADDRLP4 128
INDIRI4
ARGI4
ADDRLP4 132
CNSTI4 8
ASGNI4
ADDRLP4 132
INDIRI4
ARGI4
ADDRLP4 132
INDIRI4
ARGI4
CNSTI4 16
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 897
;895:					p, hcolor, qfalse, qfalse, TINYCHAR_WIDTH, TINYCHAR_HEIGHT,
;896:					TEAM_OVERLAY_MAXLOCATION_WIDTH);
;897:			}
LABELV $456
line 899
;898:
;899:			CG_GetColorForHealth( ci->health, ci->armor, hcolor );
ADDRLP4 4
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 112
ADDP4
INDIRI4
ARGI4
ADDRLP4 24
ARGP4
ADDRGP4 CG_GetColorForHealth
CALLV
pop
line 901
;900:
;901:			Com_sprintf (st, sizeof(st), "%3i %3i", ci->health,	ci->armor);
ADDRLP4 60
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 $464
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 108
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 112
ADDP4
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 903
;902:
;903:			xx = x + TINYCHAR_WIDTH * 3 + 
ADDRLP4 124
CNSTI4 3
ASGNI4
ADDRLP4 12
ADDRLP4 52
INDIRI4
CNSTI4 24
ADDI4
ADDRLP4 56
INDIRI4
ADDRLP4 124
INDIRI4
LSHI4
ADDI4
ADDRLP4 44
INDIRI4
ADDRLP4 124
INDIRI4
LSHI4
ADDI4
ASGNI4
line 906
;904:				TINYCHAR_WIDTH * pwidth + TINYCHAR_WIDTH * lwidth;
;905:
;906:			CG_DrawStringExt( xx, y,
ADDRLP4 12
INDIRI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 60
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 128
CNSTI4 0
ASGNI4
ADDRLP4 128
INDIRI4
ARGI4
ADDRLP4 128
INDIRI4
ARGI4
ADDRLP4 132
CNSTI4 8
ASGNI4
ADDRLP4 132
INDIRI4
ARGI4
ADDRLP4 132
INDIRI4
ARGI4
ADDRLP4 128
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 911
;907:				st, hcolor, qfalse, qfalse,
;908:				TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0 );
;909:
;910:			// draw weapon icon
;911:			xx += TINYCHAR_WIDTH * 3;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 24
ADDI4
ASGNI4
line 913
;912:
;913:			if ( cg_weapons[ci->curWeapon].weaponIcon ) {
CNSTI4 136
ADDRLP4 4
INDIRP4
CNSTI4 116
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_weapons+68
ADDP4
INDIRI4
CNSTI4 0
EQI4 $465
line 914
;914:				CG_DrawPic( xx, y, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 
ADDRLP4 12
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 136
CNSTF4 1090519040
ASGNF4
ADDRLP4 136
INDIRF4
ARGF4
ADDRLP4 136
INDIRF4
ARGF4
CNSTI4 136
ADDRLP4 4
INDIRP4
CNSTI4 116
ADDP4
INDIRI4
MULI4
ADDRGP4 cg_weapons+68
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 916
;915:					cg_weapons[ci->curWeapon].weaponIcon );
;916:			} else {
ADDRGP4 $466
JUMPV
LABELV $465
line 917
;917:				CG_DrawPic( xx, y, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 
ADDRLP4 12
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 136
CNSTF4 1090519040
ASGNF4
ADDRLP4 136
INDIRF4
ARGF4
ADDRLP4 136
INDIRF4
ARGF4
ADDRGP4 cgs+152340+132
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 919
;918:					cgs.media.deferShader );
;919:			}
LABELV $466
line 922
;920:
;921:			// Draw powerup icons
;922:			if (right) {
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $471
line 923
;923:				xx = x;
ADDRLP4 12
ADDRLP4 52
INDIRI4
ASGNI4
line 924
;924:			} else {
ADDRGP4 $472
JUMPV
LABELV $471
line 925
;925:				xx = x + w - TINYCHAR_WIDTH;
ADDRLP4 12
ADDRLP4 52
INDIRI4
ADDRLP4 80
INDIRI4
ADDI4
CNSTI4 8
SUBI4
ASGNI4
line 926
;926:			}
LABELV $472
line 927
;927:			for (j = 0; j <= PW_NUM_POWERUPS; j++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $473
line 928
;928:				if (ci->powerups & (1 << j)) {
ADDRLP4 4
INDIRP4
CNSTI4 140
ADDP4
INDIRI4
CNSTI4 1
ADDRLP4 0
INDIRI4
LSHI4
BANDI4
CNSTI4 0
EQI4 $477
line 930
;929:
;930:					item = BG_FindItemForPowerup( j );
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 136
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 136
INDIRP4
ASGNP4
line 932
;931:
;932:					if (item) {
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $479
line 933
;933:						CG_DrawPic( xx, y, TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 
ADDRLP4 16
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
ARGP4
ADDRLP4 140
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 144
CNSTF4 1090519040
ASGNF4
ADDRLP4 144
INDIRF4
ARGF4
ADDRLP4 144
INDIRF4
ARGF4
ADDRLP4 140
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 935
;934:						trap_R_RegisterShader( item->icon ) );
;935:						if (right) {
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $481
line 936
;936:							xx -= TINYCHAR_WIDTH;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 8
SUBI4
ASGNI4
line 937
;937:						} else {
ADDRGP4 $482
JUMPV
LABELV $481
line 938
;938:							xx += TINYCHAR_WIDTH;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 8
ADDI4
ASGNI4
line 939
;939:						}
LABELV $482
line 940
;940:					}
LABELV $479
line 941
;941:				}
LABELV $477
line 942
;942:			}
LABELV $474
line 927
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 15
LEI4 $473
line 944
;943:
;944:			y += TINYCHAR_HEIGHT;
ADDRFP4 0
ADDRFP4 0
INDIRF4
CNSTF4 1090519040
ADDF4
ASGNF4
line 945
;945:		}
LABELV $450
line 946
;946:	}
LABELV $446
line 873
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $448
ADDRLP4 8
INDIRI4
ADDRLP4 48
INDIRI4
LTI4 $445
line 948
;947:
;948:	return ret_y;
ADDRLP4 88
INDIRI4
CVIF4 4
RETF4
LABELV $395
endproc CG_DrawTeamOverlay 148 36
proc CG_DrawUpperRight 12 12
line 952
;949:}
;950:
;951:
;952:static void CG_DrawUpperRight( void ) {
line 955
;953:	float	y;
;954:
;955:	y = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 957
;956:
;957:	if ( cgs.gametype >= GT_TEAM && cg_drawTeamOverlay.integer == 1 ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $484
ADDRGP4 cg_drawTeamOverlay+12
INDIRI4
CNSTI4 1
NEI4 $484
line 958
;958:		y = CG_DrawTeamOverlay( y, qtrue, qtrue );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 4
CNSTI4 1
ASGNI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 CG_DrawTeamOverlay
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 8
INDIRF4
ASGNF4
line 959
;959:	} 
LABELV $484
line 960
;960:	if ( cg_drawSnapshot.integer ) {
ADDRGP4 cg_drawSnapshot+12
INDIRI4
CNSTI4 0
EQI4 $488
line 961
;961:		y = CG_DrawSnapshot( y );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 4
ADDRGP4 CG_DrawSnapshot
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
ASGNF4
line 962
;962:	}
LABELV $488
line 966
;963:#if 0
;964:	if ( cg_drawFPS.integer ) {
;965:#endif
;966:	y = CG_DrawFPS( y );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 4
ADDRGP4 CG_DrawFPS
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
ASGNF4
line 970
;967:#if 0
;968:	}
;969:#endif
;970:	if ( cg_drawTimer.integer ) {
ADDRGP4 cg_drawTimer+12
INDIRI4
CNSTI4 0
EQI4 $491
line 971
;971:		y = CG_DrawTimer( y );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 8
ADDRGP4 CG_DrawTimer
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 8
INDIRF4
ASGNF4
line 972
;972:	}
LABELV $491
line 973
;973:	if ( cg_drawAttacker.integer ) {
ADDRGP4 cg_drawAttacker+12
INDIRI4
CNSTI4 0
EQI4 $494
line 974
;974:		y = CG_DrawAttacker( y );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 8
ADDRGP4 CG_DrawAttacker
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 8
INDIRF4
ASGNF4
line 975
;975:	}
LABELV $494
line 977
;976:
;977:}
LABELV $483
endproc CG_DrawUpperRight 12 12
proc CG_DrawScores 76 20
line 991
;978:
;979:/*
;980:===========================================================================================
;981:
;982:  LOWER RIGHT CORNER
;983:
;984:===========================================================================================
;985:*/
;986:
;987:/*
;988:Draw the small two score display
;989:*/
;990:#ifndef MISSIONPACK
;991:static float CG_DrawScores( float y ) {
line 1000
;992:	const char	*s;
;993:	int			s1, s2, score;
;994:	int			x, w;
;995:	int			v;
;996:	vec4_t		color;
;997:	float		y1;
;998:	gitem_t		*item;
;999:
;1000:	s1 = cgs.scores1;
ADDRLP4 28
ADDRGP4 cgs+34800
INDIRI4
ASGNI4
line 1001
;1001:	s2 = cgs.scores2;
ADDRLP4 32
ADDRGP4 cgs+34804
INDIRI4
ASGNI4
line 1003
;1002:
;1003:	y -=  BIGCHAR_HEIGHT + 8;
ADDRFP4 0
ADDRFP4 0
INDIRF4
CNSTF4 1103101952
SUBF4
ASGNF4
line 1005
;1004:
;1005:	y1 = y;
ADDRLP4 36
ADDRFP4 0
INDIRF4
ASGNF4
line 1008
;1006:
;1007:	// draw from the right side to left
;1008:	if ( cgs.gametype >= GT_TEAM ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $500
line 1009
;1009:		x = 640;
ADDRLP4 16
CNSTI4 640
ASGNI4
line 1010
;1010:		color[0] = 0.0f;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 1011
;1011:		color[1] = 0.0f;
ADDRLP4 0+4
CNSTF4 0
ASGNF4
line 1012
;1012:		color[2] = 1.0f;
ADDRLP4 0+8
CNSTF4 1065353216
ASGNF4
line 1013
;1013:		color[3] = 0.33f;
ADDRLP4 0+12
CNSTF4 1051260355
ASGNF4
line 1014
;1014:		s = va( "%2i", s2 );
ADDRGP4 $506
ARGP4
ADDRLP4 32
INDIRI4
ARGI4
ADDRLP4 52
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 24
ADDRLP4 52
INDIRP4
ASGNP4
line 1015
;1015:		w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH + 8;
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 56
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 56
INDIRI4
CNSTI4 4
LSHI4
CNSTI4 8
ADDI4
ASGNI4
line 1016
;1016:		x -= w;
ADDRLP4 16
ADDRLP4 16
INDIRI4
ADDRLP4 20
INDIRI4
SUBI4
ASGNI4
line 1017
;1017:		CG_FillRect( x, y-4,  w, BIGCHAR_HEIGHT+8, color );
ADDRLP4 16
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 20
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRLP4 0
ARGP4
ADDRGP4 CG_FillRect
CALLV
pop
line 1018
;1018:		if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 2
NEI4 $507
line 1019
;1019:			CG_DrawPic( x, y-4, w, BIGCHAR_HEIGHT+8, cgs.media.selectShader );
ADDRLP4 16
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 20
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRGP4 cgs+152340+212
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1020
;1020:		}
LABELV $507
line 1021
;1021:		CG_DrawBigString( x + 4, y, s, 1.0F);
ADDRLP4 16
INDIRI4
CNSTI4 4
ADDI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 24
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 1023
;1022:
;1023:		if ( cgs.gametype == GT_CTF ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 4
NEI4 $512
line 1025
;1024:			// Display flag status
;1025:			item = BG_FindItemForPowerup( PW_BLUEFLAG );
CNSTI4 8
ARGI4
ADDRLP4 60
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 48
ADDRLP4 60
INDIRP4
ASGNP4
line 1027
;1026:
;1027:			if (item) {
ADDRLP4 48
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $515
line 1028
;1028:				y1 = y - BIGCHAR_HEIGHT - 8;
ADDRLP4 36
ADDRFP4 0
INDIRF4
CNSTF4 1098907648
SUBF4
CNSTF4 1090519040
SUBF4
ASGNF4
line 1029
;1029:				if( cgs.blueflag >= 0 && cgs.blueflag <= 2 ) {
ADDRGP4 cgs+34812
INDIRI4
CNSTI4 0
LTI4 $517
ADDRGP4 cgs+34812
INDIRI4
CNSTI4 2
GTI4 $517
line 1030
;1030:					CG_DrawPic( x, y1-4, w, BIGCHAR_HEIGHT+8, cgs.media.blueFlagShader[cgs.blueflag] );
ADDRLP4 16
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 36
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 20
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRGP4 cgs+34812
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+152340+60
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1031
;1031:				}
LABELV $517
line 1032
;1032:			}
LABELV $515
line 1033
;1033:		}
LABELV $512
line 1034
;1034:		color[0] = 1.0f;
ADDRLP4 0
CNSTF4 1065353216
ASGNF4
line 1035
;1035:		color[1] = 0.0f;
ADDRLP4 0+4
CNSTF4 0
ASGNF4
line 1036
;1036:		color[2] = 0.0f;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 1037
;1037:		color[3] = 0.33f;
ADDRLP4 0+12
CNSTF4 1051260355
ASGNF4
line 1038
;1038:		s = va( "%2i", s1 );
ADDRGP4 $506
ARGP4
ADDRLP4 28
INDIRI4
ARGI4
ADDRLP4 60
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 24
ADDRLP4 60
INDIRP4
ASGNP4
line 1039
;1039:		w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH + 8;
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 64
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 64
INDIRI4
CNSTI4 4
LSHI4
CNSTI4 8
ADDI4
ASGNI4
line 1040
;1040:		x -= w;
ADDRLP4 16
ADDRLP4 16
INDIRI4
ADDRLP4 20
INDIRI4
SUBI4
ASGNI4
line 1041
;1041:		CG_FillRect( x, y-4,  w, BIGCHAR_HEIGHT+8, color );
ADDRLP4 16
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 20
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRLP4 0
ARGP4
ADDRGP4 CG_FillRect
CALLV
pop
line 1042
;1042:		if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_RED ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 1
NEI4 $527
line 1043
;1043:			CG_DrawPic( x, y-4, w, BIGCHAR_HEIGHT+8, cgs.media.selectShader );
ADDRLP4 16
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 20
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRGP4 cgs+152340+212
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1044
;1044:		}
LABELV $527
line 1045
;1045:		CG_DrawBigString( x + 4, y, s, 1.0F);
ADDRLP4 16
INDIRI4
CNSTI4 4
ADDI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 24
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 1047
;1046:
;1047:		if ( cgs.gametype == GT_CTF ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 4
NEI4 $532
line 1049
;1048:			// Display flag status
;1049:			item = BG_FindItemForPowerup( PW_REDFLAG );
CNSTI4 7
ARGI4
ADDRLP4 68
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 48
ADDRLP4 68
INDIRP4
ASGNP4
line 1051
;1050:
;1051:			if (item) {
ADDRLP4 48
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $535
line 1052
;1052:				y1 = y - BIGCHAR_HEIGHT - 8;
ADDRLP4 36
ADDRFP4 0
INDIRF4
CNSTF4 1098907648
SUBF4
CNSTF4 1090519040
SUBF4
ASGNF4
line 1053
;1053:				if( cgs.redflag >= 0 && cgs.redflag <= 2 ) {
ADDRGP4 cgs+34808
INDIRI4
CNSTI4 0
LTI4 $537
ADDRGP4 cgs+34808
INDIRI4
CNSTI4 2
GTI4 $537
line 1054
;1054:					CG_DrawPic( x, y1-4, w, BIGCHAR_HEIGHT+8, cgs.media.redFlagShader[cgs.redflag] );
ADDRLP4 16
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 36
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 20
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRGP4 cgs+34808
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+152340+48
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1055
;1055:				}
LABELV $537
line 1056
;1056:			}
LABELV $535
line 1057
;1057:		}
LABELV $532
line 1072
;1058:
;1059:#ifdef MISSIONPACK
;1060:		if ( cgs.gametype == GT_1FCTF ) {
;1061:			// Display flag status
;1062:			item = BG_FindItemForPowerup( PW_NEUTRALFLAG );
;1063:
;1064:			if (item) {
;1065:				y1 = y - BIGCHAR_HEIGHT - 8;
;1066:				if( cgs.flagStatus >= 0 && cgs.flagStatus <= 3 ) {
;1067:					CG_DrawPic( x, y1-4, w, BIGCHAR_HEIGHT+8, cgs.media.flagShader[cgs.flagStatus] );
;1068:				}
;1069:			}
;1070:		}
;1071:#endif
;1072:		if ( cgs.gametype >= GT_CTF ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 4
LTI4 $544
line 1073
;1073:			v = cgs.capturelimit;
ADDRLP4 44
ADDRGP4 cgs+31472
INDIRI4
ASGNI4
line 1074
;1074:		} else {
ADDRGP4 $545
JUMPV
LABELV $544
line 1075
;1075:			v = cgs.fraglimit;
ADDRLP4 44
ADDRGP4 cgs+31468
INDIRI4
ASGNI4
line 1076
;1076:		}
LABELV $545
line 1077
;1077:		if ( v ) {
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $501
line 1078
;1078:			s = va( "%2i", v );
ADDRGP4 $506
ARGP4
ADDRLP4 44
INDIRI4
ARGI4
ADDRLP4 68
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 24
ADDRLP4 68
INDIRP4
ASGNP4
line 1079
;1079:			w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH + 8;
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 72
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 72
INDIRI4
CNSTI4 4
LSHI4
CNSTI4 8
ADDI4
ASGNI4
line 1080
;1080:			x -= w;
ADDRLP4 16
ADDRLP4 16
INDIRI4
ADDRLP4 20
INDIRI4
SUBI4
ASGNI4
line 1081
;1081:			CG_DrawBigString( x + 4, y, s, 1.0F);
ADDRLP4 16
INDIRI4
CNSTI4 4
ADDI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 24
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 1082
;1082:		}
line 1084
;1083:
;1084:	} else {
ADDRGP4 $501
JUMPV
LABELV $500
line 1087
;1085:		qboolean	spectator;
;1086:
;1087:		x = 640;
ADDRLP4 16
CNSTI4 640
ASGNI4
line 1088
;1088:		score = cg.snap->ps.persistant[PERS_SCORE];
ADDRLP4 40
ADDRGP4 cg+36
INDIRP4
CNSTI4 292
ADDP4
INDIRI4
ASGNI4
line 1089
;1089:		spectator = ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR );
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 3
NEI4 $554
ADDRLP4 56
CNSTI4 1
ASGNI4
ADDRGP4 $555
JUMPV
LABELV $554
ADDRLP4 56
CNSTI4 0
ASGNI4
LABELV $555
ADDRLP4 52
ADDRLP4 56
INDIRI4
ASGNI4
line 1092
;1090:
;1091:		// always show your score in the second box if not in first place
;1092:		if ( s1 != score ) {
ADDRLP4 28
INDIRI4
ADDRLP4 40
INDIRI4
EQI4 $556
line 1093
;1093:			s2 = score;
ADDRLP4 32
ADDRLP4 40
INDIRI4
ASGNI4
line 1094
;1094:		}
LABELV $556
line 1095
;1095:		if ( s2 != SCORE_NOT_PRESENT ) {
ADDRLP4 32
INDIRI4
CNSTI4 -9999
EQI4 $558
line 1096
;1096:			s = va( "%2i", s2 );
ADDRGP4 $506
ARGP4
ADDRLP4 32
INDIRI4
ARGI4
ADDRLP4 60
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 24
ADDRLP4 60
INDIRP4
ASGNP4
line 1097
;1097:			w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH + 8;
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 64
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 64
INDIRI4
CNSTI4 4
LSHI4
CNSTI4 8
ADDI4
ASGNI4
line 1098
;1098:			x -= w;
ADDRLP4 16
ADDRLP4 16
INDIRI4
ADDRLP4 20
INDIRI4
SUBI4
ASGNI4
line 1099
;1099:			if ( !spectator && score == s2 && score != s1 ) {
ADDRLP4 52
INDIRI4
CNSTI4 0
NEI4 $560
ADDRLP4 68
ADDRLP4 40
INDIRI4
ASGNI4
ADDRLP4 68
INDIRI4
ADDRLP4 32
INDIRI4
NEI4 $560
ADDRLP4 68
INDIRI4
ADDRLP4 28
INDIRI4
EQI4 $560
line 1100
;1100:				color[0] = 1.0f;
ADDRLP4 0
CNSTF4 1065353216
ASGNF4
line 1101
;1101:				color[1] = 0.0f;
ADDRLP4 0+4
CNSTF4 0
ASGNF4
line 1102
;1102:				color[2] = 0.0f;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 1103
;1103:				color[3] = 0.33f;
ADDRLP4 0+12
CNSTF4 1051260355
ASGNF4
line 1104
;1104:				CG_FillRect( x, y-4,  w, BIGCHAR_HEIGHT+8, color );
ADDRLP4 16
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 20
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRLP4 0
ARGP4
ADDRGP4 CG_FillRect
CALLV
pop
line 1105
;1105:				CG_DrawPic( x, y-4, w, BIGCHAR_HEIGHT+8, cgs.media.selectShader );
ADDRLP4 16
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 20
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRGP4 cgs+152340+212
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1106
;1106:			} else {
ADDRGP4 $561
JUMPV
LABELV $560
line 1107
;1107:				color[0] = 0.5f;
ADDRLP4 0
CNSTF4 1056964608
ASGNF4
line 1108
;1108:				color[1] = 0.5f;
ADDRLP4 0+4
CNSTF4 1056964608
ASGNF4
line 1109
;1109:				color[2] = 0.5f;
ADDRLP4 0+8
CNSTF4 1056964608
ASGNF4
line 1110
;1110:				color[3] = 0.33f;
ADDRLP4 0+12
CNSTF4 1051260355
ASGNF4
line 1111
;1111:				CG_FillRect( x, y-4,  w, BIGCHAR_HEIGHT+8, color );
ADDRLP4 16
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 20
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRLP4 0
ARGP4
ADDRGP4 CG_FillRect
CALLV
pop
line 1112
;1112:			}	
LABELV $561
line 1113
;1113:			CG_DrawBigString( x + 4, y, s, 1.0F);
ADDRLP4 16
INDIRI4
CNSTI4 4
ADDI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 24
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 1114
;1114:		}
LABELV $558
line 1117
;1115:
;1116:		// first place
;1117:		if ( s1 != SCORE_NOT_PRESENT ) {
ADDRLP4 28
INDIRI4
CNSTI4 -9999
EQI4 $570
line 1118
;1118:			s = va( "%2i", s1 );
ADDRGP4 $506
ARGP4
ADDRLP4 28
INDIRI4
ARGI4
ADDRLP4 60
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 24
ADDRLP4 60
INDIRP4
ASGNP4
line 1119
;1119:			w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH + 8;
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 64
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 64
INDIRI4
CNSTI4 4
LSHI4
CNSTI4 8
ADDI4
ASGNI4
line 1120
;1120:			x -= w;
ADDRLP4 16
ADDRLP4 16
INDIRI4
ADDRLP4 20
INDIRI4
SUBI4
ASGNI4
line 1121
;1121:			if ( !spectator && score == s1 ) {
ADDRLP4 52
INDIRI4
CNSTI4 0
NEI4 $572
ADDRLP4 40
INDIRI4
ADDRLP4 28
INDIRI4
NEI4 $572
line 1122
;1122:				color[0] = 0.0f;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 1123
;1123:				color[1] = 0.0f;
ADDRLP4 0+4
CNSTF4 0
ASGNF4
line 1124
;1124:				color[2] = 1.0f;
ADDRLP4 0+8
CNSTF4 1065353216
ASGNF4
line 1125
;1125:				color[3] = 0.33f;
ADDRLP4 0+12
CNSTF4 1051260355
ASGNF4
line 1126
;1126:				CG_FillRect( x, y-4,  w, BIGCHAR_HEIGHT+8, color );
ADDRLP4 16
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 20
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRLP4 0
ARGP4
ADDRGP4 CG_FillRect
CALLV
pop
line 1127
;1127:				CG_DrawPic( x, y-4, w, BIGCHAR_HEIGHT+8, cgs.media.selectShader );
ADDRLP4 16
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 20
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRGP4 cgs+152340+212
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1128
;1128:			} else {
ADDRGP4 $573
JUMPV
LABELV $572
line 1129
;1129:				color[0] = 0.5f;
ADDRLP4 0
CNSTF4 1056964608
ASGNF4
line 1130
;1130:				color[1] = 0.5f;
ADDRLP4 0+4
CNSTF4 1056964608
ASGNF4
line 1131
;1131:				color[2] = 0.5f;
ADDRLP4 0+8
CNSTF4 1056964608
ASGNF4
line 1132
;1132:				color[3] = 0.33f;
ADDRLP4 0+12
CNSTF4 1051260355
ASGNF4
line 1133
;1133:				CG_FillRect( x, y-4,  w, BIGCHAR_HEIGHT+8, color );
ADDRLP4 16
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRF4
CNSTF4 1082130432
SUBF4
ARGF4
ADDRLP4 20
INDIRI4
CVIF4 4
ARGF4
CNSTF4 1103101952
ARGF4
ADDRLP4 0
ARGP4
ADDRGP4 CG_FillRect
CALLV
pop
line 1134
;1134:			}	
LABELV $573
line 1135
;1135:			CG_DrawBigString( x + 4, y, s, 1.0F);
ADDRLP4 16
INDIRI4
CNSTI4 4
ADDI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 24
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 1136
;1136:		}
LABELV $570
line 1138
;1137:
;1138:		if ( cgs.fraglimit ) {
ADDRGP4 cgs+31468
INDIRI4
CNSTI4 0
EQI4 $582
line 1139
;1139:			s = va( "%2i", cgs.fraglimit );
ADDRGP4 $506
ARGP4
ADDRGP4 cgs+31468
INDIRI4
ARGI4
ADDRLP4 60
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 24
ADDRLP4 60
INDIRP4
ASGNP4
line 1140
;1140:			w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH + 8;
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 64
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 64
INDIRI4
CNSTI4 4
LSHI4
CNSTI4 8
ADDI4
ASGNI4
line 1141
;1141:			x -= w;
ADDRLP4 16
ADDRLP4 16
INDIRI4
ADDRLP4 20
INDIRI4
SUBI4
ASGNI4
line 1142
;1142:			CG_DrawBigString( x + 4, y, s, 1.0F);
ADDRLP4 16
INDIRI4
CNSTI4 4
ADDI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 24
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 1143
;1143:		}
LABELV $582
line 1145
;1144:
;1145:	}
LABELV $501
line 1147
;1146:
;1147:	return y1 - 8;
ADDRLP4 36
INDIRF4
CNSTF4 1090519040
SUBF4
RETF4
LABELV $497
endproc CG_DrawScores 76 20
data
align 4
LABELV $587
byte 4 1045220557
byte 4 1065353216
byte 4 1045220557
byte 4 1065353216
byte 4 1065353216
byte 4 1045220557
byte 4 1045220557
byte 4 1065353216
code
proc CG_DrawPowerups 208 20
line 1153
;1148:}
;1149:#endif // MISSIONPACK
;1150:
;1151:
;1152:#ifndef MISSIONPACK
;1153:static float CG_DrawPowerups( float y ) {
line 1170
;1154:	int		sorted[MAX_POWERUPS];
;1155:	int		sortedTime[MAX_POWERUPS];
;1156:	int		i, j, k;
;1157:	int		active;
;1158:	playerState_t	*ps;
;1159:	int		t;
;1160:	gitem_t	*item;
;1161:	int		x;
;1162:	int		color;
;1163:	float	size;
;1164:	float	f;
;1165:	static float colors[2][4] = { 
;1166:    { 0.2f, 1.0f, 0.2f, 1.0f } , 
;1167:    { 1.0f, 0.2f, 0.2f, 1.0f } 
;1168:  };
;1169:
;1170:	ps = &cg.snap->ps;
ADDRLP4 148
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
line 1172
;1171:
;1172:	if ( ps->stats[STAT_HEALTH] <= 0 ) {
ADDRLP4 148
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CNSTI4 0
GTI4 $589
line 1173
;1173:		return y;
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $586
JUMPV
LABELV $589
line 1177
;1174:	}
;1175:
;1176:	// sort the list by time remaining
;1177:	active = 0;
ADDRLP4 136
CNSTI4 0
ASGNI4
line 1178
;1178:	for ( i = 0 ; i < MAX_POWERUPS ; i++ ) {
ADDRLP4 144
CNSTI4 0
ASGNI4
LABELV $591
line 1179
;1179:		if ( !ps->powerups[ i ] ) {
ADDRLP4 144
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 148
INDIRP4
CNSTI4 312
ADDP4
ADDP4
INDIRI4
CNSTI4 0
NEI4 $595
line 1180
;1180:			continue;
ADDRGP4 $592
JUMPV
LABELV $595
line 1182
;1181:		}
;1182:		t = ps->powerups[ i ] - cg.time;
ADDRLP4 140
ADDRLP4 144
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 148
INDIRP4
CNSTI4 312
ADDP4
ADDP4
INDIRI4
ADDRGP4 cg+107604
INDIRI4
SUBI4
ASGNI4
line 1185
;1183:		// ZOID--don't draw if the power up has unlimited time (999 seconds)
;1184:		// This is true of the CTF flags
;1185:		if ( t < 0 || t > 999000) {
ADDRLP4 140
INDIRI4
CNSTI4 0
LTI4 $600
ADDRLP4 140
INDIRI4
CNSTI4 999000
LEI4 $598
LABELV $600
line 1186
;1186:			continue;
ADDRGP4 $592
JUMPV
LABELV $598
line 1190
;1187:		}
;1188:
;1189:		// insert into the list
;1190:		for ( j = 0 ; j < active ; j++ ) {
ADDRLP4 132
CNSTI4 0
ASGNI4
ADDRGP4 $604
JUMPV
LABELV $601
line 1191
;1191:			if ( sortedTime[j] >= t ) {
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
ADDRLP4 140
INDIRI4
LTI4 $605
line 1192
;1192:				for ( k = active - 1 ; k >= j ; k-- ) {
ADDRLP4 0
ADDRLP4 136
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
ADDRGP4 $610
JUMPV
LABELV $607
line 1193
;1193:					sorted[k+1] = sorted[k];
ADDRLP4 176
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 176
INDIRI4
ADDRLP4 68+4
ADDP4
ADDRLP4 176
INDIRI4
ADDRLP4 68
ADDP4
INDIRI4
ASGNI4
line 1194
;1194:					sortedTime[k+1] = sortedTime[k];
ADDRLP4 180
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 180
INDIRI4
ADDRLP4 4+4
ADDP4
ADDRLP4 180
INDIRI4
ADDRLP4 4
ADDP4
INDIRI4
ASGNI4
line 1195
;1195:				}
LABELV $608
line 1192
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
LABELV $610
ADDRLP4 0
INDIRI4
ADDRLP4 132
INDIRI4
GEI4 $607
line 1196
;1196:				break;
ADDRGP4 $603
JUMPV
LABELV $605
line 1198
;1197:			}
;1198:		}
LABELV $602
line 1190
ADDRLP4 132
ADDRLP4 132
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $604
ADDRLP4 132
INDIRI4
ADDRLP4 136
INDIRI4
LTI4 $601
LABELV $603
line 1199
;1199:		sorted[j] = i;
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 68
ADDP4
ADDRLP4 144
INDIRI4
ASGNI4
line 1200
;1200:		sortedTime[j] = t;
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
ADDP4
ADDRLP4 140
INDIRI4
ASGNI4
line 1201
;1201:		active++;
ADDRLP4 136
ADDRLP4 136
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1202
;1202:	}
LABELV $592
line 1178
ADDRLP4 144
ADDRLP4 144
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 144
INDIRI4
CNSTI4 16
LTI4 $591
line 1205
;1203:
;1204:	// draw the icons and timers
;1205:	x = 640 - ICON_SIZE - CHAR_WIDTH * 2;
ADDRLP4 168
CNSTI4 528
ASGNI4
line 1206
;1206:	for ( i = 0 ; i < active ; i++ ) {
ADDRLP4 144
CNSTI4 0
ASGNI4
ADDRGP4 $616
JUMPV
LABELV $613
line 1207
;1207:		item = BG_FindItemForPowerup( sorted[i] );
ADDRLP4 144
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 68
ADDP4
INDIRI4
ARGI4
ADDRLP4 172
ADDRGP4 BG_FindItemForPowerup
CALLP4
ASGNP4
ADDRLP4 152
ADDRLP4 172
INDIRP4
ASGNP4
line 1209
;1208:
;1209:    if (item) {
ADDRLP4 152
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $617
line 1211
;1210:
;1211:		  color = 1;
ADDRLP4 164
CNSTI4 1
ASGNI4
line 1213
;1212:
;1213:		  y -= ICON_SIZE;
ADDRFP4 0
ADDRFP4 0
INDIRF4
CNSTF4 1111490560
SUBF4
ASGNF4
line 1215
;1214:
;1215:		  trap_R_SetColor( colors[color] );
ADDRLP4 164
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 $587
ADDP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1216
;1216:		  CG_DrawField( x, y, 2, sortedTime[ i ] / 1000 );
ADDRLP4 168
INDIRI4
ARGI4
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 176
CNSTI4 2
ASGNI4
ADDRLP4 176
INDIRI4
ARGI4
ADDRLP4 144
INDIRI4
ADDRLP4 176
INDIRI4
LSHI4
ADDRLP4 4
ADDP4
INDIRI4
CNSTI4 1000
DIVI4
ARGI4
ADDRGP4 CG_DrawField
CALLV
pop
line 1218
;1217:
;1218:		  t = ps->powerups[ sorted[i] ];
ADDRLP4 180
CNSTI4 2
ASGNI4
ADDRLP4 140
ADDRLP4 144
INDIRI4
ADDRLP4 180
INDIRI4
LSHI4
ADDRLP4 68
ADDP4
INDIRI4
ADDRLP4 180
INDIRI4
LSHI4
ADDRLP4 148
INDIRP4
CNSTI4 312
ADDP4
ADDP4
INDIRI4
ASGNI4
line 1219
;1219:		  if ( t - cg.time >= POWERUP_BLINKS * POWERUP_BLINK_TIME ) {
ADDRLP4 140
INDIRI4
ADDRGP4 cg+107604
INDIRI4
SUBI4
CNSTI4 5000
LTI4 $619
line 1220
;1220:			  trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1221
;1221:		  } else {
ADDRGP4 $620
JUMPV
LABELV $619
line 1224
;1222:			  vec4_t	modulate;
;1223:
;1224:			  f = (float)( t - cg.time ) / POWERUP_BLINK_TIME;
ADDRLP4 160
ADDRLP4 140
INDIRI4
ADDRGP4 cg+107604
INDIRI4
SUBI4
CVIF4 4
CNSTF4 1148846080
DIVF4
ASGNF4
line 1225
;1225:			  f -= (int)f;
ADDRLP4 160
ADDRLP4 160
INDIRF4
ADDRLP4 160
INDIRF4
CVFI4 4
CVIF4 4
SUBF4
ASGNF4
line 1226
;1226:			  modulate[0] = modulate[1] = modulate[2] = modulate[3] = f;
ADDRLP4 184+12
ADDRLP4 160
INDIRF4
ASGNF4
ADDRLP4 184+8
ADDRLP4 160
INDIRF4
ASGNF4
ADDRLP4 184+4
ADDRLP4 160
INDIRF4
ASGNF4
ADDRLP4 184
ADDRLP4 160
INDIRF4
ASGNF4
line 1227
;1227:			  trap_R_SetColor( modulate );
ADDRLP4 184
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1228
;1228:		  }
LABELV $620
line 1230
;1229:
;1230:		  if ( cg.powerupActive == sorted[i] && 
ADDRGP4 cg+124408
INDIRI4
ADDRLP4 144
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 68
ADDP4
INDIRI4
NEI4 $626
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+124412
INDIRI4
SUBI4
CNSTI4 200
GEI4 $626
line 1231
;1231:			  cg.time - cg.powerupTime < PULSE_TIME ) {
line 1232
;1232:			  f = 1.0 - ( ( (float)cg.time - cg.powerupTime ) / PULSE_TIME );
ADDRLP4 160
CNSTF4 1065353216
ADDRGP4 cg+107604
INDIRI4
CVIF4 4
ADDRGP4 cg+124412
INDIRI4
CVIF4 4
SUBF4
CNSTF4 1128792064
DIVF4
SUBF4
ASGNF4
line 1233
;1233:			  size = ICON_SIZE * ( 1.0 + ( PULSE_SCALE - 1.0 ) * f );
ADDRLP4 156
CNSTF4 1111490560
CNSTF4 1056964608
ADDRLP4 160
INDIRF4
MULF4
CNSTF4 1065353216
ADDF4
MULF4
ASGNF4
line 1234
;1234:		  } else {
ADDRGP4 $627
JUMPV
LABELV $626
line 1235
;1235:			  size = ICON_SIZE;
ADDRLP4 156
CNSTF4 1111490560
ASGNF4
line 1236
;1236:		  }
LABELV $627
line 1238
;1237:
;1238:		  CG_DrawPic( 640 - size, y + ICON_SIZE / 2 - size / 2, 
ADDRLP4 152
INDIRP4
CNSTI4 24
ADDP4
INDIRP4
ARGP4
ADDRLP4 184
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
CNSTF4 1142947840
ADDRLP4 156
INDIRF4
SUBF4
ARGF4
ADDRFP4 0
INDIRF4
CNSTF4 1103101952
ADDF4
ADDRLP4 156
INDIRF4
CNSTF4 1073741824
DIVF4
SUBF4
ARGF4
ADDRLP4 156
INDIRF4
ARGF4
ADDRLP4 156
INDIRF4
ARGF4
ADDRLP4 184
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1240
;1239:			  size, size, trap_R_RegisterShader( item->icon ) );
;1240:    }
LABELV $617
line 1241
;1241:	}
LABELV $614
line 1206
ADDRLP4 144
ADDRLP4 144
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $616
ADDRLP4 144
INDIRI4
ADDRLP4 136
INDIRI4
LTI4 $613
line 1242
;1242:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1244
;1243:
;1244:	return y;
ADDRFP4 0
INDIRF4
RETF4
LABELV $586
endproc CG_DrawPowerups 208 20
proc CG_DrawLowerRight 12 12
line 1250
;1245:}
;1246:#endif // MISSIONPACK
;1247:
;1248:
;1249:#ifndef MISSIONPACK
;1250:static void CG_DrawLowerRight( void ) {
line 1253
;1251:	float	y;
;1252:
;1253:	y = 480 - ICON_SIZE;
ADDRLP4 0
CNSTF4 1138229248
ASGNF4
line 1255
;1254:
;1255:	if ( cgs.gametype >= GT_TEAM && cg_drawTeamOverlay.integer == 2 ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $634
ADDRGP4 cg_drawTeamOverlay+12
INDIRI4
CNSTI4 2
NEI4 $634
line 1256
;1256:		y = CG_DrawTeamOverlay( y, qtrue, qfalse );
ADDRLP4 0
INDIRF4
ARGF4
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 4
ADDRGP4 CG_DrawTeamOverlay
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
ASGNF4
line 1257
;1257:	} 
LABELV $634
line 1259
;1258:
;1259:	y = CG_DrawScores( y );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 4
ADDRGP4 CG_DrawScores
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
ASGNF4
line 1260
;1260:	y = CG_DrawPowerups( y );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 8
ADDRGP4 CG_DrawPowerups
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 8
INDIRF4
ASGNF4
line 1261
;1261:}
LABELV $633
endproc CG_DrawLowerRight 12 12
proc CG_DrawPickupItem 16 20
line 1266
;1262:#endif // MISSIONPACK
;1263:
;1264:
;1265:#ifndef MISSIONPACK
;1266:static int CG_DrawPickupItem( int y ) {
line 1270
;1267:	int		value;
;1268:	float	*fadeColor;
;1269:
;1270:	if ( cg.snap->ps.stats[STAT_HEALTH] <= 0 ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
CNSTI4 0
GTI4 $639
line 1271
;1271:		return y;
ADDRFP4 0
INDIRI4
RETI4
ADDRGP4 $638
JUMPV
LABELV $639
line 1274
;1272:	}
;1273:
;1274:	y -= ICON_SIZE;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 48
SUBI4
ASGNI4
line 1276
;1275:
;1276:	value = cg.itemPickup;
ADDRLP4 0
ADDRGP4 cg+124664
INDIRI4
ASGNI4
line 1277
;1277:	if ( value ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $643
line 1278
;1278:		fadeColor = CG_FadeColor( cg.itemPickupTime, 3000 );
ADDRGP4 cg+124668
INDIRI4
ARGI4
CNSTI4 3000
ARGI4
ADDRLP4 8
ADDRGP4 CG_FadeColor
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
ASGNP4
line 1279
;1279:		if ( fadeColor ) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $646
line 1280
;1280:			CG_RegisterItemVisuals( value );
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_RegisterItemVisuals
CALLV
pop
line 1281
;1281:			trap_R_SetColor( fadeColor );
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1282
;1282:			CG_DrawPic( 8, y, ICON_SIZE, ICON_SIZE, cg_items[ value ].icon );
CNSTF4 1090519040
ARGF4
ADDRFP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 12
CNSTF4 1111490560
ASGNF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cg_items+20
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1283
;1283:			CG_DrawBigString( ICON_SIZE + 16, y + (ICON_SIZE/2 - BIGCHAR_HEIGHT/2), bg_itemlist[ value ].pickup_name, fadeColor[0] );
CNSTI4 64
ARGI4
ADDRFP4 0
INDIRI4
CNSTI4 16
ADDI4
ARGI4
CNSTI4 52
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 bg_itemlist+28
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
INDIRF4
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 1284
;1284:			trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1285
;1285:		}
LABELV $646
line 1286
;1286:	}
LABELV $643
line 1288
;1287:	
;1288:	return y;
ADDRFP4 0
INDIRI4
RETI4
LABELV $638
endproc CG_DrawPickupItem 16 20
proc CG_DrawLowerLeft 16 12
line 1294
;1289:}
;1290:#endif // MISSIONPACK
;1291:
;1292:
;1293:#ifndef MISSIONPACK
;1294:static void CG_DrawLowerLeft( void ) {
line 1297
;1295:	float	y;
;1296:
;1297:	y = 480 - ICON_SIZE;
ADDRLP4 0
CNSTF4 1138229248
ASGNF4
line 1299
;1298:
;1299:	if ( cgs.gametype >= GT_TEAM && cg_drawTeamOverlay.integer == 3 ) {
ADDRLP4 4
CNSTI4 3
ASGNI4
ADDRGP4 cgs+31456
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $651
ADDRGP4 cg_drawTeamOverlay+12
INDIRI4
ADDRLP4 4
INDIRI4
NEI4 $651
line 1300
;1300:		y = CG_DrawTeamOverlay( y, qfalse, qfalse );
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 CG_DrawTeamOverlay
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 12
INDIRF4
ASGNF4
line 1301
;1301:	} 
LABELV $651
line 1304
;1302:
;1303:
;1304:	y = CG_DrawPickupItem( y );
ADDRLP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 8
ADDRGP4 CG_DrawPickupItem
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
CVIF4 4
ASGNF4
line 1305
;1305:}
LABELV $650
endproc CG_DrawLowerLeft 16 12
proc CG_DrawTeamInfo 56 36
line 1312
;1306:#endif // MISSIONPACK
;1307:
;1308:
;1309://===========================================================================================
;1310:
;1311:#ifndef MISSIONPACK
;1312:static void CG_DrawTeamInfo( void ) {
line 1321
;1313:	int w, h;
;1314:	int i, len;
;1315:	vec4_t		hcolor;
;1316:	int		chatHeight;
;1317:
;1318:#define CHATLOC_Y 420 // bottom end
;1319:#define CHATLOC_X 0
;1320:
;1321:	if (cg_teamChatHeight.integer < TEAMCHAT_HEIGHT)
ADDRGP4 cg_teamChatHeight+12
INDIRI4
CNSTI4 8
GEI4 $656
line 1322
;1322:		chatHeight = cg_teamChatHeight.integer;
ADDRLP4 8
ADDRGP4 cg_teamChatHeight+12
INDIRI4
ASGNI4
ADDRGP4 $657
JUMPV
LABELV $656
line 1324
;1323:	else
;1324:		chatHeight = TEAMCHAT_HEIGHT;
ADDRLP4 8
CNSTI4 8
ASGNI4
LABELV $657
line 1325
;1325:	if (chatHeight <= 0)
ADDRLP4 8
INDIRI4
CNSTI4 0
GTI4 $660
line 1326
;1326:		return; // disabled
ADDRGP4 $655
JUMPV
LABELV $660
line 1328
;1327:
;1328:	if (cgs.teamLastChatPos != cgs.teamChatPos) {
ADDRGP4 cgs+152248
INDIRI4
ADDRGP4 cgs+152244
INDIRI4
EQI4 $662
line 1329
;1329:		if (cg.time - cgs.teamChatMsgTimes[cgs.teamLastChatPos % chatHeight] > cg_teamChatTime.integer) {
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cgs+152248
INDIRI4
ADDRLP4 8
INDIRI4
MODI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+152212
ADDP4
INDIRI4
SUBI4
ADDRGP4 cg_teamChatTime+12
INDIRI4
LEI4 $666
line 1330
;1330:			cgs.teamLastChatPos++;
ADDRLP4 36
ADDRGP4 cgs+152248
ASGNP4
ADDRLP4 36
INDIRP4
ADDRLP4 36
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1331
;1331:		}
LABELV $666
line 1333
;1332:
;1333:		h = (cgs.teamChatPos - cgs.teamLastChatPos) * TINYCHAR_HEIGHT;
ADDRLP4 32
ADDRGP4 cgs+152244
INDIRI4
ADDRGP4 cgs+152248
INDIRI4
SUBI4
CNSTI4 3
LSHI4
ASGNI4
line 1335
;1334:
;1335:		w = 0;
ADDRLP4 28
CNSTI4 0
ASGNI4
line 1337
;1336:
;1337:		for (i = cgs.teamLastChatPos; i < cgs.teamChatPos; i++) {
ADDRLP4 0
ADDRGP4 cgs+152248
INDIRI4
ASGNI4
ADDRGP4 $678
JUMPV
LABELV $675
line 1338
;1338:			len = CG_DrawStrlen(cgs.teamChatMsgs[i % chatHeight]);
CNSTI4 241
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
MODI4
MULI4
ADDRGP4 cgs+150284
ADDP4
ARGP4
ADDRLP4 36
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 36
INDIRI4
ASGNI4
line 1339
;1339:			if (len > w)
ADDRLP4 4
INDIRI4
ADDRLP4 28
INDIRI4
LEI4 $682
line 1340
;1340:				w = len;
ADDRLP4 28
ADDRLP4 4
INDIRI4
ASGNI4
LABELV $682
line 1341
;1341:		}
LABELV $676
line 1337
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $678
ADDRLP4 0
INDIRI4
ADDRGP4 cgs+152244
INDIRI4
LTI4 $675
line 1342
;1342:		w *= TINYCHAR_WIDTH;
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 3
LSHI4
ASGNI4
line 1343
;1343:		w += TINYCHAR_WIDTH * 2;
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 16
ADDI4
ASGNI4
line 1345
;1344:
;1345:		if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_RED ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 1
NEI4 $684
line 1346
;1346:			hcolor[0] = 1.0f;
ADDRLP4 12
CNSTF4 1065353216
ASGNF4
line 1347
;1347:			hcolor[1] = 0.0f;
ADDRLP4 12+4
CNSTF4 0
ASGNF4
line 1348
;1348:			hcolor[2] = 0.0f;
ADDRLP4 12+8
CNSTF4 0
ASGNF4
line 1349
;1349:			hcolor[3] = 0.33f;
ADDRLP4 12+12
CNSTF4 1051260355
ASGNF4
line 1350
;1350:		} else if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_BLUE ) {
ADDRGP4 $685
JUMPV
LABELV $684
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 2
NEI4 $690
line 1351
;1351:			hcolor[0] = 0.0f;
ADDRLP4 12
CNSTF4 0
ASGNF4
line 1352
;1352:			hcolor[1] = 0.0f;
ADDRLP4 12+4
CNSTF4 0
ASGNF4
line 1353
;1353:			hcolor[2] = 1.0f;
ADDRLP4 12+8
CNSTF4 1065353216
ASGNF4
line 1354
;1354:			hcolor[3] = 0.33f;
ADDRLP4 12+12
CNSTF4 1051260355
ASGNF4
line 1355
;1355:		} else {
ADDRGP4 $691
JUMPV
LABELV $690
line 1356
;1356:			hcolor[0] = 0.0f;
ADDRLP4 12
CNSTF4 0
ASGNF4
line 1357
;1357:			hcolor[1] = 1.0f;
ADDRLP4 12+4
CNSTF4 1065353216
ASGNF4
line 1358
;1358:			hcolor[2] = 0.0f;
ADDRLP4 12+8
CNSTF4 0
ASGNF4
line 1359
;1359:			hcolor[3] = 0.33f;
ADDRLP4 12+12
CNSTF4 1051260355
ASGNF4
line 1360
;1360:		}
LABELV $691
LABELV $685
line 1362
;1361:
;1362:		trap_R_SetColor( hcolor );
ADDRLP4 12
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1363
;1363:		CG_DrawPic( CHATLOC_X, CHATLOC_Y - h, 640, h, cgs.media.teamStatusBar );
CNSTF4 0
ARGF4
ADDRLP4 36
ADDRLP4 32
INDIRI4
ASGNI4
CNSTI4 420
ADDRLP4 36
INDIRI4
SUBI4
CVIF4 4
ARGF4
CNSTF4 1142947840
ARGF4
ADDRLP4 36
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 cgs+152340+128
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1364
;1364:		trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1366
;1365:
;1366:		hcolor[0] = hcolor[1] = hcolor[2] = 1.0f;
ADDRLP4 40
CNSTF4 1065353216
ASGNF4
ADDRLP4 12+8
ADDRLP4 40
INDIRF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 40
INDIRF4
ASGNF4
ADDRLP4 12
ADDRLP4 40
INDIRF4
ASGNF4
line 1367
;1367:		hcolor[3] = 1.0f;
ADDRLP4 12+12
CNSTF4 1065353216
ASGNF4
line 1369
;1368:
;1369:		for (i = cgs.teamChatPos - 1; i >= cgs.teamLastChatPos; i--) {
ADDRLP4 0
ADDRGP4 cgs+152244
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
ADDRGP4 $707
JUMPV
LABELV $704
line 1370
;1370:			CG_DrawStringExt( CHATLOC_X + TINYCHAR_WIDTH, 
ADDRLP4 44
CNSTI4 8
ASGNI4
ADDRLP4 44
INDIRI4
ARGI4
CNSTI4 420
ADDRGP4 cgs+152244
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 3
LSHI4
SUBI4
ARGI4
CNSTI4 241
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
MODI4
MULI4
ADDRGP4 cgs+150284
ADDP4
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 52
CNSTI4 0
ASGNI4
ADDRLP4 52
INDIRI4
ARGI4
ADDRLP4 52
INDIRI4
ARGI4
ADDRLP4 44
INDIRI4
ARGI4
ADDRLP4 44
INDIRI4
ARGI4
ADDRLP4 52
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 1374
;1371:				CHATLOC_Y - (cgs.teamChatPos - i)*TINYCHAR_HEIGHT, 
;1372:				cgs.teamChatMsgs[i % chatHeight], hcolor, qfalse, qfalse,
;1373:				TINYCHAR_WIDTH, TINYCHAR_HEIGHT, 0 );
;1374:		}
LABELV $705
line 1369
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
LABELV $707
ADDRLP4 0
INDIRI4
ADDRGP4 cgs+152248
INDIRI4
GEI4 $704
line 1375
;1375:	}
LABELV $662
line 1376
;1376:}
LABELV $655
endproc CG_DrawTeamInfo 56 36
proc CG_DrawHoldableItem 8 20
line 1381
;1377:#endif // MISSIONPACK
;1378:
;1379:
;1380:#ifndef MISSIONPACK
;1381:static void CG_DrawHoldableItem( void ) { 
line 1384
;1382:	int		value;
;1383:
;1384:	value = cg.snap->ps.stats[STAT_HOLDABLE_ITEM];
ADDRLP4 0
ADDRGP4 cg+36
INDIRP4
CNSTI4 232
ADDP4
INDIRI4
ASGNI4
line 1385
;1385:	if ( value ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $714
line 1386
;1386:		CG_RegisterItemVisuals( value );
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_RegisterItemVisuals
CALLV
pop
line 1387
;1387:		CG_DrawPic( 640-ICON_SIZE, (SCREEN_HEIGHT-ICON_SIZE)/2, ICON_SIZE, ICON_SIZE, cg_items[ value ].icon );
CNSTF4 1142161408
ARGF4
CNSTF4 1129840640
ARGF4
ADDRLP4 4
CNSTF4 1111490560
ASGNF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cg_items+20
ADDP4
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1388
;1388:	}
LABELV $714
line 1390
;1389:
;1390:}
LABELV $712
endproc CG_DrawHoldableItem 8 20
proc CG_DrawReward 68 36
line 1394
;1391:#endif // MISSIONPACK
;1392:
;1393:
;1394:static void CG_DrawReward( void ) { 
line 1400
;1395:	float	*color;
;1396:	int		i, count;
;1397:	float	x, y;
;1398:	char	buf[32];
;1399:
;1400:	if ( !cg_drawRewards.integer ) {
ADDRGP4 cg_drawRewards+12
INDIRI4
CNSTI4 0
NEI4 $718
line 1401
;1401:		return;
ADDRGP4 $717
JUMPV
LABELV $718
line 1404
;1402:	}
;1403:
;1404:	color = CG_FadeColor( cg.rewardTime, REWARD_TIME );
ADDRGP4 cg+124428
INDIRI4
ARGI4
CNSTI4 3000
ARGI4
ADDRLP4 52
ADDRGP4 CG_FadeColor
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 52
INDIRP4
ASGNP4
line 1405
;1405:	if ( !color ) {
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $722
line 1406
;1406:		if (cg.rewardStack > 0) {
ADDRGP4 cg+124424
INDIRI4
CNSTI4 0
LEI4 $717
line 1407
;1407:			for(i = 0; i < cg.rewardStack; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $730
JUMPV
LABELV $727
line 1408
;1408:				cg.rewardSound[i] = cg.rewardSound[i+1];
ADDRLP4 56
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 56
INDIRI4
ADDRGP4 cg+124512
ADDP4
ADDRLP4 56
INDIRI4
ADDRGP4 cg+124512+4
ADDP4
INDIRI4
ASGNI4
line 1409
;1409:				cg.rewardShader[i] = cg.rewardShader[i+1];
ADDRLP4 60
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 60
INDIRI4
ADDRGP4 cg+124472
ADDP4
ADDRLP4 60
INDIRI4
ADDRGP4 cg+124472+4
ADDP4
INDIRI4
ASGNI4
line 1410
;1410:				cg.rewardCount[i] = cg.rewardCount[i+1];
ADDRLP4 64
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 64
INDIRI4
ADDRGP4 cg+124432
ADDP4
ADDRLP4 64
INDIRI4
ADDRGP4 cg+124432+4
ADDP4
INDIRI4
ASGNI4
line 1411
;1411:			}
LABELV $728
line 1407
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $730
ADDRLP4 0
INDIRI4
ADDRGP4 cg+124424
INDIRI4
LTI4 $727
line 1412
;1412:			cg.rewardTime = cg.time;
ADDRGP4 cg+124428
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 1413
;1413:			cg.rewardStack--;
ADDRLP4 56
ADDRGP4 cg+124424
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1414
;1414:			color = CG_FadeColor( cg.rewardTime, REWARD_TIME );
ADDRGP4 cg+124428
INDIRI4
ARGI4
CNSTI4 3000
ARGI4
ADDRLP4 60
ADDRGP4 CG_FadeColor
CALLP4
ASGNP4
ADDRLP4 16
ADDRLP4 60
INDIRP4
ASGNP4
line 1415
;1415:			trap_S_StartLocalSound(cg.rewardSound[0], CHAN_ANNOUNCER);
ADDRGP4 cg+124512
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 1416
;1416:		} else {
line 1417
;1417:			return;
LABELV $725
line 1419
;1418:		}
;1419:	}
LABELV $722
line 1421
;1420:
;1421:	trap_R_SetColor( color );
ADDRLP4 16
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1423
;1422:
;1423:	if ( cg.rewardCount[0] >= 10 ) {
ADDRGP4 cg+124432
INDIRI4
CNSTI4 10
LTI4 $746
line 1424
;1424:		y = 56;
ADDRLP4 8
CNSTF4 1113587712
ASGNF4
line 1425
;1425:		x = 320 - ICON_SIZE/2;
ADDRLP4 4
CNSTF4 1133772800
ASGNF4
line 1426
;1426:		CG_DrawPic( x, y, ICON_SIZE-4, ICON_SIZE-4, cg.rewardShader[0] );
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 56
CNSTF4 1110441984
ASGNF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRGP4 cg+124472
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1427
;1427:		Com_sprintf(buf, sizeof(buf), "%d", cg.rewardCount[0]);
ADDRLP4 20
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 $750
ARGP4
ADDRGP4 cg+124432
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1428
;1428:		x = ( SCREEN_WIDTH - SMALLCHAR_WIDTH * CG_DrawStrlen( buf ) ) / 2;
ADDRLP4 20
ARGP4
ADDRLP4 60
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 4
CNSTI4 640
ADDRLP4 60
INDIRI4
CNSTI4 3
LSHI4
SUBI4
CNSTI4 2
DIVI4
CVIF4 4
ASGNF4
line 1429
;1429:		CG_DrawStringExt( x, y+ICON_SIZE, buf, color, qfalse, qtrue,
ADDRLP4 4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 8
INDIRF4
CNSTF4 1111490560
ADDF4
CVFI4 4
ARGI4
ADDRLP4 20
ARGP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 64
CNSTI4 0
ASGNI4
ADDRLP4 64
INDIRI4
ARGI4
CNSTI4 1
ARGI4
CNSTI4 8
ARGI4
CNSTI4 16
ARGI4
ADDRLP4 64
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 1431
;1430:								SMALLCHAR_WIDTH, SMALLCHAR_HEIGHT, 0 );
;1431:	}
ADDRGP4 $747
JUMPV
LABELV $746
line 1432
;1432:	else {
line 1434
;1433:
;1434:		count = cg.rewardCount[0];
ADDRLP4 12
ADDRGP4 cg+124432
INDIRI4
ASGNI4
line 1436
;1435:
;1436:		y = 56;
ADDRLP4 8
CNSTF4 1113587712
ASGNF4
line 1437
;1437:		x = 320 - count * ICON_SIZE/2;
ADDRLP4 4
CNSTI4 320
CNSTI4 48
ADDRLP4 12
INDIRI4
MULI4
CNSTI4 2
DIVI4
SUBI4
CVIF4 4
ASGNF4
line 1438
;1438:		for ( i = 0 ; i < count ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $756
JUMPV
LABELV $753
line 1439
;1439:			CG_DrawPic( x, y, ICON_SIZE-4, ICON_SIZE-4, cg.rewardShader[0] );
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 56
CNSTF4 1110441984
ASGNF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRGP4 cg+124472
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1440
;1440:			x += ICON_SIZE;
ADDRLP4 4
ADDRLP4 4
INDIRF4
CNSTF4 1111490560
ADDF4
ASGNF4
line 1441
;1441:		}
LABELV $754
line 1438
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $756
ADDRLP4 0
INDIRI4
ADDRLP4 12
INDIRI4
LTI4 $753
line 1442
;1442:	}
LABELV $747
line 1443
;1443:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1444
;1444:}
LABELV $717
endproc CG_DrawReward 68 36
export CG_AddLagometerFrameInfo
proc CG_AddLagometerFrameInfo 8 0
line 1471
;1445:
;1446:
;1447:/*
;1448:===============================================================================
;1449:
;1450:LAGOMETER
;1451:
;1452:===============================================================================
;1453:*/
;1454:
;1455:#define	LAG_SAMPLES		128
;1456:
;1457:
;1458:typedef struct {
;1459:	int		frameSamples[LAG_SAMPLES];
;1460:	int		frameCount;
;1461:	int		snapshotFlags[LAG_SAMPLES];
;1462:	int		snapshotSamples[LAG_SAMPLES];
;1463:	int		snapshotCount;
;1464:} lagometer_t;
;1465:
;1466:lagometer_t		lagometer;
;1467:
;1468:/*
;1469:Adds the current interpolate / extrapolate bar for this frame
;1470:*/
;1471:void CG_AddLagometerFrameInfo( void ) {
line 1474
;1472:	int			offset;
;1473:
;1474:	offset = cg.time - cg.latestSnapshotTime;
ADDRLP4 0
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+32
INDIRI4
SUBI4
ASGNI4
line 1475
;1475:	lagometer.frameSamples[ lagometer.frameCount & ( LAG_SAMPLES - 1) ] = offset;
ADDRGP4 lagometer+512
INDIRI4
CNSTI4 127
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 lagometer
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 1476
;1476:	lagometer.frameCount++;
ADDRLP4 4
ADDRGP4 lagometer+512
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1477
;1477:}
LABELV $759
endproc CG_AddLagometerFrameInfo 8 0
export CG_AddLagometerSnapshotInfo
proc CG_AddLagometerSnapshotInfo 4 0
line 1485
;1478:
;1479:/*
;1480:Each time a snapshot is received, log its ping time and
;1481:the number of snapshots that were dropped before it.
;1482:
;1483:Pass NULL for a dropped packet.
;1484:*/
;1485:void CG_AddLagometerSnapshotInfo( snapshot_t *snap ) {
line 1487
;1486:	// dropped packet
;1487:	if ( !snap ) {
ADDRFP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $765
line 1488
;1488:		lagometer.snapshotSamples[ lagometer.snapshotCount & ( LAG_SAMPLES - 1) ] = -1;
ADDRGP4 lagometer+1540
INDIRI4
CNSTI4 127
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 lagometer+1028
ADDP4
CNSTI4 -1
ASGNI4
line 1489
;1489:		lagometer.snapshotCount++;
ADDRLP4 0
ADDRGP4 lagometer+1540
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1490
;1490:		return;
ADDRGP4 $764
JUMPV
LABELV $765
line 1494
;1491:	}
;1492:
;1493:	// add this snapshot's info
;1494:	lagometer.snapshotSamples[ lagometer.snapshotCount & ( LAG_SAMPLES - 1) ] = snap->ping;
ADDRGP4 lagometer+1540
INDIRI4
CNSTI4 127
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 lagometer+1028
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 1495
;1495:	lagometer.snapshotFlags[ lagometer.snapshotCount & ( LAG_SAMPLES - 1) ] = snap->snapFlags;
ADDRGP4 lagometer+1540
INDIRI4
CNSTI4 127
BANDI4
CNSTI4 2
LSHI4
ADDRGP4 lagometer+516
ADDP4
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 1496
;1496:	lagometer.snapshotCount++;
ADDRLP4 0
ADDRGP4 lagometer+1540
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1497
;1497:}
LABELV $764
endproc CG_AddLagometerSnapshotInfo 4 0
proc CG_DrawDisconnect 64 20
line 1503
;1498:
;1499:
;1500:/*
;1501:Should we draw something differnet for long lag vs no packets?
;1502:*/
;1503:static void CG_DrawDisconnect( void ) {
line 1511
;1504:	float		x, y;
;1505:	int			cmdNum;
;1506:	usercmd_t	cmd;
;1507:	const char		*s;
;1508:	int			w;  // bk010215 - FIXME char message[1024];
;1509:
;1510:	// draw the phone jack if we are completely past our buffers
;1511:	cmdNum = trap_GetCurrentCmdNumber() - CMD_BACKUP + 1;
ADDRLP4 44
ADDRGP4 trap_GetCurrentCmdNumber
CALLI4
ASGNI4
ADDRLP4 36
ADDRLP4 44
INDIRI4
CNSTI4 64
SUBI4
CNSTI4 1
ADDI4
ASGNI4
line 1512
;1512:	trap_GetUserCmd( cmdNum, &cmd );
ADDRLP4 36
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 trap_GetUserCmd
CALLI4
pop
line 1513
;1513:	if ( cmd.serverTime <= cg.snap->ps.commandTime
ADDRLP4 48
ADDRLP4 0
INDIRI4
ASGNI4
ADDRLP4 48
INDIRI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
LEI4 $780
ADDRLP4 48
INDIRI4
ADDRGP4 cg+107604
INDIRI4
LEI4 $776
LABELV $780
line 1514
;1514:		|| cmd.serverTime > cg.time ) {	// special check for map_restart // bk 0102165 - FIXME
line 1515
;1515:		return;
ADDRGP4 $775
JUMPV
LABELV $776
line 1519
;1516:	}
;1517:
;1518:	// also add text in center of screen
;1519:	s = "Connection Interrupted"; // bk 010215 - FIXME
ADDRLP4 24
ADDRGP4 $781
ASGNP4
line 1520
;1520:	w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH;
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 40
ADDRLP4 52
INDIRI4
CNSTI4 4
LSHI4
ASGNI4
line 1521
;1521:	CG_DrawBigString( 320 - w/2, 100, s, 1.0F);
CNSTI4 320
ADDRLP4 40
INDIRI4
CNSTI4 2
DIVI4
SUBI4
ARGI4
CNSTI4 100
ARGI4
ADDRLP4 24
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 1524
;1522:
;1523:	// blink the icon
;1524:	if ( ( cg.time >> 9 ) & 1 ) {
ADDRGP4 cg+107604
INDIRI4
CNSTI4 9
RSHI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $782
line 1525
;1525:		return;
ADDRGP4 $775
JUMPV
LABELV $782
line 1528
;1526:	}
;1527:
;1528:	x = 640 - 48;
ADDRLP4 28
CNSTF4 1142161408
ASGNF4
line 1529
;1529:	y = 480 - 48;
ADDRLP4 32
CNSTF4 1138229248
ASGNF4
line 1531
;1530:
;1531:	CG_DrawPic( x, y, 48, 48, trap_R_RegisterShader("gfx/2d/net.tga" ) );
ADDRGP4 $785
ARGP4
ADDRLP4 56
ADDRGP4 trap_R_RegisterShader
CALLI4
ASGNI4
ADDRLP4 28
INDIRF4
ARGF4
ADDRLP4 32
INDIRF4
ARGF4
ADDRLP4 60
CNSTF4 1111490560
ASGNF4
ADDRLP4 60
INDIRF4
ARGF4
ADDRLP4 60
INDIRF4
ARGF4
ADDRLP4 56
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1532
;1532:}
LABELV $775
endproc CG_DrawDisconnect 64 20
proc CG_DrawLagometer 68 36
line 1539
;1533:
;1534:
;1535:#define	MAX_LAGOMETER_PING	900
;1536:#define	MAX_LAGOMETER_RANGE	300
;1537:
;1538:
;1539:static void CG_DrawLagometer( void ) {
line 1546
;1540:	int		a, x, y, i;
;1541:	float	v;
;1542:	float	ax, ay, aw, ah, mid, range;
;1543:	int		color;
;1544:	float	vscale;
;1545:
;1546:	if ( !cg_lagometer.integer || cgs.localServer ) {
ADDRLP4 52
CNSTI4 0
ASGNI4
ADDRGP4 cg_lagometer+12
INDIRI4
ADDRLP4 52
INDIRI4
EQI4 $791
ADDRGP4 cgs+31452
INDIRI4
ADDRLP4 52
INDIRI4
EQI4 $787
LABELV $791
line 1547
;1547:		CG_DrawDisconnect();
ADDRGP4 CG_DrawDisconnect
CALLV
pop
line 1548
;1548:		return;
ADDRGP4 $786
JUMPV
LABELV $787
line 1556
;1549:	}
;1550:
;1551:	// draw the graph
;1552:#ifdef MISSIONPACK
;1553:	x = 640 - 48;
;1554:	y = 480 - 144;
;1555:#else
;1556:	x = 640 - 48;
ADDRLP4 44
CNSTI4 592
ASGNI4
line 1557
;1557:	y = 480 - 48;
ADDRLP4 48
CNSTI4 432
ASGNI4
line 1560
;1558:#endif
;1559:
;1560:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1561
;1561:	CG_DrawPic( x, y, 48, 48, cgs.media.lagometerShader );
ADDRLP4 44
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 48
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 56
CNSTF4 1111490560
ASGNF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRLP4 56
INDIRF4
ARGF4
ADDRGP4 cgs+152340+264
INDIRI4
ARGI4
ADDRGP4 CG_DrawPic
CALLV
pop
line 1563
;1562:
;1563:	ax = x;
ADDRLP4 24
ADDRLP4 44
INDIRI4
CVIF4 4
ASGNF4
line 1564
;1564:	ay = y;
ADDRLP4 36
ADDRLP4 48
INDIRI4
CVIF4 4
ASGNF4
line 1565
;1565:	aw = 48;
ADDRLP4 12
CNSTF4 1111490560
ASGNF4
line 1566
;1566:	ah = 48;
ADDRLP4 32
CNSTF4 1111490560
ASGNF4
line 1567
;1567:	CG_AdjustFrom640( &ax, &ay, &aw, &ah );
ADDRLP4 24
ARGP4
ADDRLP4 36
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 32
ARGP4
ADDRGP4 CG_AdjustFrom640
CALLV
pop
line 1569
;1568:
;1569:	color = -1;
ADDRLP4 20
CNSTI4 -1
ASGNI4
line 1570
;1570:	range = ah / 3;
ADDRLP4 16
ADDRLP4 32
INDIRF4
CNSTF4 1077936128
DIVF4
ASGNF4
line 1571
;1571:	mid = ay + range;
ADDRLP4 40
ADDRLP4 36
INDIRF4
ADDRLP4 16
INDIRF4
ADDF4
ASGNF4
line 1573
;1572:
;1573:	vscale = range / MAX_LAGOMETER_RANGE;
ADDRLP4 28
ADDRLP4 16
INDIRF4
CNSTF4 1133903872
DIVF4
ASGNF4
line 1576
;1574:
;1575:	// draw the frame interpoalte / extrapolate graph
;1576:	for ( a = 0 ; a < aw ; a++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $797
JUMPV
LABELV $794
line 1577
;1577:		i = ( lagometer.frameCount - 1 - a ) & (LAG_SAMPLES - 1);
ADDRLP4 8
ADDRGP4 lagometer+512
INDIRI4
CNSTI4 1
SUBI4
ADDRLP4 4
INDIRI4
SUBI4
CNSTI4 127
BANDI4
ASGNI4
line 1578
;1578:		v = lagometer.frameSamples[i];
ADDRLP4 0
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 lagometer
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 1579
;1579:		v *= vscale;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
line 1580
;1580:		if ( v > 0 ) {
ADDRLP4 0
INDIRF4
CNSTF4 0
LEF4 $799
line 1581
;1581:			if ( color != 1 ) {
ADDRLP4 20
INDIRI4
CNSTI4 1
EQI4 $801
line 1582
;1582:				color = 1;
ADDRLP4 20
CNSTI4 1
ASGNI4
line 1583
;1583:				trap_R_SetColor( g_color_table[ColorIndex(COLOR_YELLOW)] );
ADDRGP4 g_color_table+48
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1584
;1584:			}
LABELV $801
line 1585
;1585:			if ( v > range ) {
ADDRLP4 0
INDIRF4
ADDRLP4 16
INDIRF4
LEF4 $804
line 1586
;1586:				v = range;
ADDRLP4 0
ADDRLP4 16
INDIRF4
ASGNF4
line 1587
;1587:			}
LABELV $804
line 1588
;1588:			trap_R_DrawStretchPic ( ax + aw - a, mid - v, 1, v, 0, 0, 0, 0, cgs.media.whiteShader );
ADDRLP4 24
INDIRF4
ADDRLP4 12
INDIRF4
ADDF4
ADDRLP4 4
INDIRI4
CVIF4 4
SUBF4
ARGF4
ADDRLP4 40
INDIRF4
ADDRLP4 0
INDIRF4
SUBF4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 64
CNSTF4 0
ASGNF4
ADDRLP4 64
INDIRF4
ARGF4
ADDRLP4 64
INDIRF4
ARGF4
ADDRLP4 64
INDIRF4
ARGF4
ADDRLP4 64
INDIRF4
ARGF4
ADDRGP4 cgs+152340+16
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 1589
;1589:		} else if ( v < 0 ) {
ADDRGP4 $800
JUMPV
LABELV $799
ADDRLP4 0
INDIRF4
CNSTF4 0
GEF4 $808
line 1590
;1590:			if ( color != 2 ) {
ADDRLP4 20
INDIRI4
CNSTI4 2
EQI4 $810
line 1591
;1591:				color = 2;
ADDRLP4 20
CNSTI4 2
ASGNI4
line 1592
;1592:				trap_R_SetColor( g_color_table[ColorIndex(COLOR_BLUE)] );
ADDRGP4 g_color_table+64
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1593
;1593:			}
LABELV $810
line 1594
;1594:			v = -v;
ADDRLP4 0
ADDRLP4 0
INDIRF4
NEGF4
ASGNF4
line 1595
;1595:			if ( v > range ) {
ADDRLP4 0
INDIRF4
ADDRLP4 16
INDIRF4
LEF4 $813
line 1596
;1596:				v = range;
ADDRLP4 0
ADDRLP4 16
INDIRF4
ASGNF4
line 1597
;1597:			}
LABELV $813
line 1598
;1598:			trap_R_DrawStretchPic( ax + aw - a, mid, 1, v, 0, 0, 0, 0, cgs.media.whiteShader );
ADDRLP4 24
INDIRF4
ADDRLP4 12
INDIRF4
ADDF4
ADDRLP4 4
INDIRI4
CVIF4 4
SUBF4
ARGF4
ADDRLP4 40
INDIRF4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 60
CNSTF4 0
ASGNF4
ADDRLP4 60
INDIRF4
ARGF4
ADDRLP4 60
INDIRF4
ARGF4
ADDRLP4 60
INDIRF4
ARGF4
ADDRLP4 60
INDIRF4
ARGF4
ADDRGP4 cgs+152340+16
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 1599
;1599:		}
LABELV $808
LABELV $800
line 1600
;1600:	}
LABELV $795
line 1576
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $797
ADDRLP4 4
INDIRI4
CVIF4 4
ADDRLP4 12
INDIRF4
LTF4 $794
line 1603
;1601:
;1602:	// draw the snapshot latency / drop graph
;1603:	range = ah / 2;
ADDRLP4 16
ADDRLP4 32
INDIRF4
CNSTF4 1073741824
DIVF4
ASGNF4
line 1604
;1604:	vscale = range / MAX_LAGOMETER_PING;
ADDRLP4 28
ADDRLP4 16
INDIRF4
CNSTF4 1147207680
DIVF4
ASGNF4
line 1606
;1605:
;1606:	for ( a = 0 ; a < aw ; a++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $820
JUMPV
LABELV $817
line 1607
;1607:		i = ( lagometer.snapshotCount - 1 - a ) & (LAG_SAMPLES - 1);
ADDRLP4 8
ADDRGP4 lagometer+1540
INDIRI4
CNSTI4 1
SUBI4
ADDRLP4 4
INDIRI4
SUBI4
CNSTI4 127
BANDI4
ASGNI4
line 1608
;1608:		v = lagometer.snapshotSamples[i];
ADDRLP4 0
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 lagometer+1028
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 1609
;1609:		if ( v > 0 ) {
ADDRLP4 0
INDIRF4
CNSTF4 0
LEF4 $823
line 1610
;1610:			if ( lagometer.snapshotFlags[i] & SNAPFLAG_RATE_DELAYED ) {
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 lagometer+516
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $825
line 1611
;1611:				if ( color != 5 ) {
ADDRLP4 20
INDIRI4
CNSTI4 5
EQI4 $826
line 1612
;1612:					color = 5;	// YELLOW for rate delay
ADDRLP4 20
CNSTI4 5
ASGNI4
line 1613
;1613:					trap_R_SetColor( g_color_table[ColorIndex(COLOR_YELLOW)] );
ADDRGP4 g_color_table+48
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1614
;1614:				}
line 1615
;1615:			} else {
ADDRGP4 $826
JUMPV
LABELV $825
line 1616
;1616:				if ( color != 3 ) {
ADDRLP4 20
INDIRI4
CNSTI4 3
EQI4 $831
line 1617
;1617:					color = 3;
ADDRLP4 20
CNSTI4 3
ASGNI4
line 1618
;1618:					trap_R_SetColor( g_color_table[ColorIndex(COLOR_GREEN)] );
ADDRGP4 g_color_table+32
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1619
;1619:				}
LABELV $831
line 1620
;1620:			}
LABELV $826
line 1621
;1621:			v = v * vscale;
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 28
INDIRF4
MULF4
ASGNF4
line 1622
;1622:			if ( v > range ) {
ADDRLP4 0
INDIRF4
ADDRLP4 16
INDIRF4
LEF4 $834
line 1623
;1623:				v = range;
ADDRLP4 0
ADDRLP4 16
INDIRF4
ASGNF4
line 1624
;1624:			}
LABELV $834
line 1625
;1625:			trap_R_DrawStretchPic( ax + aw - a, ay + ah - v, 1, v, 0, 0, 0, 0, cgs.media.whiteShader );
ADDRLP4 24
INDIRF4
ADDRLP4 12
INDIRF4
ADDF4
ADDRLP4 4
INDIRI4
CVIF4 4
SUBF4
ARGF4
ADDRLP4 36
INDIRF4
ADDRLP4 32
INDIRF4
ADDF4
ADDRLP4 0
INDIRF4
SUBF4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 64
CNSTF4 0
ASGNF4
ADDRLP4 64
INDIRF4
ARGF4
ADDRLP4 64
INDIRF4
ARGF4
ADDRLP4 64
INDIRF4
ARGF4
ADDRLP4 64
INDIRF4
ARGF4
ADDRGP4 cgs+152340+16
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 1626
;1626:		} else if ( v < 0 ) {
ADDRGP4 $824
JUMPV
LABELV $823
ADDRLP4 0
INDIRF4
CNSTF4 0
GEF4 $838
line 1627
;1627:			if ( color != 4 ) {
ADDRLP4 20
INDIRI4
CNSTI4 4
EQI4 $840
line 1628
;1628:				color = 4;		// RED for dropped snapshots
ADDRLP4 20
CNSTI4 4
ASGNI4
line 1629
;1629:				trap_R_SetColor( g_color_table[ColorIndex(COLOR_RED)] );
ADDRGP4 g_color_table+16
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1630
;1630:			}
LABELV $840
line 1631
;1631:			trap_R_DrawStretchPic( ax + aw - a, ay + ah - range, 1, range, 0, 0, 0, 0, cgs.media.whiteShader );
ADDRLP4 24
INDIRF4
ADDRLP4 12
INDIRF4
ADDF4
ADDRLP4 4
INDIRI4
CVIF4 4
SUBF4
ARGF4
ADDRLP4 36
INDIRF4
ADDRLP4 32
INDIRF4
ADDF4
ADDRLP4 16
INDIRF4
SUBF4
ARGF4
CNSTF4 1065353216
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 64
CNSTF4 0
ASGNF4
ADDRLP4 64
INDIRF4
ARGF4
ADDRLP4 64
INDIRF4
ARGF4
ADDRLP4 64
INDIRF4
ARGF4
ADDRLP4 64
INDIRF4
ARGF4
ADDRGP4 cgs+152340+16
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 1632
;1632:		}
LABELV $838
LABELV $824
line 1633
;1633:	}
LABELV $818
line 1606
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $820
ADDRLP4 4
INDIRI4
CVIF4 4
ADDRLP4 12
INDIRF4
LTF4 $817
line 1635
;1634:
;1635:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1637
;1636:
;1637:	if ( cg_nopredict.integer || cg_synchronousClients.integer ) {
ADDRLP4 60
CNSTI4 0
ASGNI4
ADDRGP4 cg_nopredict+12
INDIRI4
ADDRLP4 60
INDIRI4
NEI4 $849
ADDRGP4 cg_synchronousClients+12
INDIRI4
ADDRLP4 60
INDIRI4
EQI4 $845
LABELV $849
line 1638
;1638:		CG_DrawBigString( ax, ay, "snc", 1.0 );
ADDRLP4 24
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 36
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 $850
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 1639
;1639:	}
LABELV $845
line 1641
;1640:
;1641:	CG_DrawDisconnect();
ADDRGP4 CG_DrawDisconnect
CALLV
pop
line 1642
;1642:}
LABELV $786
endproc CG_DrawLagometer 68 36
export CG_CenterPrint
proc CG_CenterPrint 8 12
line 1659
;1643:
;1644:
;1645:
;1646:/*
;1647:===============================================================================
;1648:
;1649:CENTER PRINTING
;1650:
;1651:===============================================================================
;1652:*/
;1653:
;1654:
;1655:/*
;1656:Called for important messages that should stay in the center of the screen
;1657:for a few moments
;1658:*/
;1659:void CG_CenterPrint( const char *str, int y, int charWidth ) {
line 1662
;1660:	char	*s;
;1661:
;1662:	Q_strncpyz( cg.centerPrint, str, sizeof(cg.centerPrint) );
ADDRGP4 cg+123364
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 1664
;1663:
;1664:	cg.centerPrintTime = cg.time;
ADDRGP4 cg+123352
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 1665
;1665:	cg.centerPrintY = y;
ADDRGP4 cg+123360
ADDRFP4 4
INDIRI4
ASGNI4
line 1666
;1666:	cg.centerPrintCharWidth = charWidth;
ADDRGP4 cg+123356
ADDRFP4 8
INDIRI4
ASGNI4
line 1669
;1667:
;1668:	// count the number of lines for centering
;1669:	cg.centerPrintLines = 1;
ADDRGP4 cg+124388
CNSTI4 1
ASGNI4
line 1670
;1670:	s = cg.centerPrint;
ADDRLP4 0
ADDRGP4 cg+123364
ASGNP4
ADDRGP4 $861
JUMPV
LABELV $860
line 1671
;1671:	while( *s ) {
line 1672
;1672:		if (*s == '\n')
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 10
NEI4 $863
line 1673
;1673:			cg.centerPrintLines++;
ADDRLP4 4
ADDRGP4 cg+124388
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $863
line 1674
;1674:		s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1675
;1675:	}
LABELV $861
line 1671
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $860
line 1676
;1676:}
LABELV $851
endproc CG_CenterPrint 8 12
proc CG_DrawCenterString 1064 36
line 1679
;1677:
;1678:
;1679:static void CG_DrawCenterString( void ) {
line 1688
;1680:	char	*start;
;1681:	int		l;
;1682:	int		x, y, w;
;1683:#ifdef MISSIONPACK // bk010221 - unused else
;1684:  int h;
;1685:#endif
;1686:	float	*color;
;1687:
;1688:	if ( !cg.centerPrintTime ) {
ADDRGP4 cg+123352
INDIRI4
CNSTI4 0
NEI4 $867
line 1689
;1689:		return;
ADDRGP4 $866
JUMPV
LABELV $867
line 1692
;1690:	}
;1691:
;1692:	color = CG_FadeColor( cg.centerPrintTime, 1000 * cg_centertime.value );
ADDRGP4 cg+123352
INDIRI4
ARGI4
CNSTF4 1148846080
ADDRGP4 cg_centertime+8
INDIRF4
MULF4
CVFI4 4
ARGI4
ADDRLP4 24
ADDRGP4 CG_FadeColor
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 24
INDIRP4
ASGNP4
line 1693
;1693:	if ( !color ) {
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $872
line 1694
;1694:		return;
ADDRGP4 $866
JUMPV
LABELV $872
line 1697
;1695:	}
;1696:
;1697:	trap_R_SetColor( color );
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1699
;1698:
;1699:	start = cg.centerPrint;
ADDRLP4 0
ADDRGP4 cg+123364
ASGNP4
line 1701
;1700:
;1701:	y = cg.centerPrintY - cg.centerPrintLines * BIGCHAR_HEIGHT / 2;
ADDRLP4 8
ADDRGP4 cg+123360
INDIRI4
ADDRGP4 cg+124388
INDIRI4
CNSTI4 4
LSHI4
CNSTI4 2
DIVI4
SUBI4
ASGNI4
ADDRGP4 $878
JUMPV
LABELV $877
line 1703
;1702:
;1703:	while ( 1 ) {
line 1706
;1704:		char linebuffer[1024];
;1705:
;1706:		for ( l = 0; l < 50; l++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $880
line 1707
;1707:			if ( !start[l] || start[l] == '\n' ) {
ADDRLP4 1052
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 1052
INDIRI4
CNSTI4 0
EQI4 $886
ADDRLP4 1052
INDIRI4
CNSTI4 10
NEI4 $884
LABELV $886
line 1708
;1708:				break;
ADDRGP4 $882
JUMPV
LABELV $884
line 1710
;1709:			}
;1710:			linebuffer[l] = start[l];
ADDRLP4 4
INDIRI4
ADDRLP4 28
ADDP4
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
ADDP4
INDIRI1
ASGNI1
line 1711
;1711:		}
LABELV $881
line 1706
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 50
LTI4 $880
LABELV $882
line 1712
;1712:		linebuffer[l] = 0;
ADDRLP4 4
INDIRI4
ADDRLP4 28
ADDP4
CNSTI1 0
ASGNI1
line 1721
;1713:
;1714:#ifdef MISSIONPACK
;1715:		w = CG_Text_Width(linebuffer, 0.5, 0);
;1716:		h = CG_Text_Height(linebuffer, 0.5, 0);
;1717:		x = (SCREEN_WIDTH - w) / 2;
;1718:		CG_Text_Paint(x, y + h, 0.5, color, linebuffer, 0, 0, ITEM_TEXTSTYLE_SHADOWEDMORE);
;1719:		y += h + 6;
;1720:#else
;1721:		w = cg.centerPrintCharWidth * CG_DrawStrlen( linebuffer );
ADDRLP4 28
ARGP4
ADDRLP4 1052
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 16
ADDRGP4 cg+123356
INDIRI4
ADDRLP4 1052
INDIRI4
MULI4
ASGNI4
line 1723
;1722:
;1723:		x = ( SCREEN_WIDTH - w ) / 2;
ADDRLP4 12
CNSTI4 640
ADDRLP4 16
INDIRI4
SUBI4
CNSTI4 2
DIVI4
ASGNI4
line 1725
;1724:
;1725:		CG_DrawStringExt( x, y, linebuffer, color, qfalse, qtrue,
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 28
ARGP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 1056
CNSTI4 0
ASGNI4
ADDRLP4 1056
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 cg+123356
INDIRI4
ARGI4
CNSTF4 1069547520
ADDRGP4 cg+123356
INDIRI4
CVIF4 4
MULF4
CVFI4 4
ARGI4
ADDRLP4 1056
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 1728
;1726:			cg.centerPrintCharWidth, (int)(cg.centerPrintCharWidth * 1.5), 0 );
;1727:
;1728:		y += cg.centerPrintCharWidth * 1.5;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CVIF4 4
CNSTF4 1069547520
ADDRGP4 cg+123356
INDIRI4
CVIF4 4
MULF4
ADDF4
CVFI4 4
ASGNI4
ADDRGP4 $892
JUMPV
LABELV $891
line 1730
;1729:#endif
;1730:		while ( *start && ( *start != '\n' ) ) {
line 1731
;1731:			start++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1732
;1732:		}
LABELV $892
line 1730
ADDRLP4 1060
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 1060
INDIRI4
CNSTI4 0
EQI4 $894
ADDRLP4 1060
INDIRI4
CNSTI4 10
NEI4 $891
LABELV $894
line 1733
;1733:		if ( !*start ) {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $895
line 1734
;1734:			break;
ADDRGP4 $879
JUMPV
LABELV $895
line 1736
;1735:		}
;1736:		start++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 1737
;1737:	}
LABELV $878
line 1703
ADDRGP4 $877
JUMPV
LABELV $879
line 1739
;1738:
;1739:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1740
;1740:}
LABELV $866
endproc CG_DrawCenterString 1064 36
proc CG_DrawCrosshair 56 36
line 1753
;1741:
;1742:
;1743:
;1744:/*
;1745:================================================================================
;1746:
;1747:CROSSHAIR
;1748:
;1749:================================================================================
;1750:*/
;1751:
;1752:
;1753:static void CG_DrawCrosshair(void) {
line 1760
;1754:	float		w, h;
;1755:	qhandle_t	hShader;
;1756:	float		f;
;1757:	float		x, y;
;1758:	int			ca;
;1759:
;1760:	if ( !cg_drawCrosshair.integer ) {
ADDRGP4 cg_drawCrosshair+12
INDIRI4
CNSTI4 0
NEI4 $898
line 1761
;1761:		return;
ADDRGP4 $897
JUMPV
LABELV $898
line 1764
;1762:	}
;1763:
;1764:	if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 3
NEI4 $901
line 1765
;1765:		return;
ADDRGP4 $897
JUMPV
LABELV $901
line 1768
;1766:	}
;1767:
;1768:	if ( cg.renderingThirdPerson ) {
ADDRGP4 cg+107628
INDIRI4
CNSTI4 0
EQI4 $904
line 1769
;1769:		return;
ADDRGP4 $897
JUMPV
LABELV $904
line 1773
;1770:	}
;1771:
;1772:	// set color based on health
;1773:	if ( cg_crosshairHealth.integer ) {
ADDRGP4 cg_crosshairHealth+12
INDIRI4
CNSTI4 0
EQI4 $907
line 1776
;1774:		vec4_t		hcolor;
;1775:
;1776:		CG_ColorForHealth( hcolor );
ADDRLP4 28
ARGP4
ADDRGP4 CG_ColorForHealth
CALLV
pop
line 1777
;1777:		trap_R_SetColor( hcolor );
ADDRLP4 28
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1778
;1778:	} else {
ADDRGP4 $908
JUMPV
LABELV $907
line 1779
;1779:		trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1780
;1780:	}
LABELV $908
line 1782
;1781:
;1782:	w = h = cg_crosshairSize.value;
ADDRLP4 28
ADDRGP4 cg_crosshairSize+8
INDIRF4
ASGNF4
ADDRLP4 4
ADDRLP4 28
INDIRF4
ASGNF4
ADDRLP4 0
ADDRLP4 28
INDIRF4
ASGNF4
line 1785
;1783:
;1784:	// pulse the size of the crosshair when picking up items
;1785:	f = cg.time - cg.itemPickupBlendTime;
ADDRLP4 8
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cg+124672
INDIRI4
SUBI4
CVIF4 4
ASGNF4
line 1786
;1786:	if ( f > 0 && f < ITEM_BLOB_TIME ) {
ADDRLP4 8
INDIRF4
CNSTF4 0
LEF4 $913
ADDRLP4 8
INDIRF4
CNSTF4 1128792064
GEF4 $913
line 1787
;1787:		f /= ITEM_BLOB_TIME;
ADDRLP4 8
ADDRLP4 8
INDIRF4
CNSTF4 1128792064
DIVF4
ASGNF4
line 1788
;1788:		w *= ( 1 + f );
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRLP4 8
INDIRF4
CNSTF4 1065353216
ADDF4
MULF4
ASGNF4
line 1789
;1789:		h *= ( 1 + f );
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRLP4 8
INDIRF4
CNSTF4 1065353216
ADDF4
MULF4
ASGNF4
line 1790
;1790:	}
LABELV $913
line 1792
;1791:
;1792:	x = cg_crosshairX.integer;
ADDRLP4 16
ADDRGP4 cg_crosshairX+12
INDIRI4
CVIF4 4
ASGNF4
line 1793
;1793:	y = cg_crosshairY.integer;
ADDRLP4 20
ADDRGP4 cg_crosshairY+12
INDIRI4
CVIF4 4
ASGNF4
line 1794
;1794:	CG_AdjustFrom640( &x, &y, &w, &h );
ADDRLP4 16
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 CG_AdjustFrom640
CALLV
pop
line 1796
;1795:
;1796:	ca = cg_drawCrosshair.integer;
ADDRLP4 12
ADDRGP4 cg_drawCrosshair+12
INDIRI4
ASGNI4
line 1797
;1797:	if (ca < 0) {
ADDRLP4 12
INDIRI4
CNSTI4 0
GEI4 $918
line 1798
;1798:		ca = 0;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 1799
;1799:	}
LABELV $918
line 1800
;1800:	hShader = cgs.media.crosshairShader[ ca % NUM_CROSSHAIRS ];
ADDRLP4 24
ADDRLP4 12
INDIRI4
CNSTI4 10
MODI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+152340+224
ADDP4
INDIRI4
ASGNI4
line 1802
;1801:
;1802:	trap_R_DrawStretchPic( x + cg.refdef.x + 0.5 * (cg.refdef.width - w), 
ADDRLP4 36
CNSTF4 1056964608
ASGNF4
ADDRLP4 40
ADDRLP4 0
INDIRF4
ASGNF4
ADDRLP4 16
INDIRF4
ADDRGP4 cg+109044
INDIRI4
CVIF4 4
ADDF4
ADDRLP4 36
INDIRF4
ADDRGP4 cg+109044+8
INDIRI4
CVIF4 4
ADDRLP4 40
INDIRF4
SUBF4
MULF4
ADDF4
ARGF4
ADDRLP4 44
ADDRLP4 4
INDIRF4
ASGNF4
ADDRLP4 20
INDIRF4
ADDRGP4 cg+109044+4
INDIRI4
CVIF4 4
ADDF4
ADDRLP4 36
INDIRF4
ADDRGP4 cg+109044+12
INDIRI4
CVIF4 4
ADDRLP4 44
INDIRF4
SUBF4
MULF4
ADDF4
ARGF4
ADDRLP4 40
INDIRF4
ARGF4
ADDRLP4 44
INDIRF4
ARGF4
ADDRLP4 48
CNSTF4 0
ASGNF4
ADDRLP4 48
INDIRF4
ARGF4
ADDRLP4 48
INDIRF4
ARGF4
ADDRLP4 52
CNSTF4 1065353216
ASGNF4
ADDRLP4 52
INDIRF4
ARGF4
ADDRLP4 52
INDIRF4
ARGF4
ADDRLP4 24
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 1805
;1803:		y + cg.refdef.y + 0.5 * (cg.refdef.height - h), 
;1804:		w, h, 0, 0, 1, 1, hShader );
;1805:}
LABELV $897
endproc CG_DrawCrosshair 56 36
proc CG_ScanForCrosshairEntity 96 28
line 1808
;1806:
;1807:
;1808:static void CG_ScanForCrosshairEntity( void ) {
line 1813
;1809:	trace_t		trace;
;1810:	vec3_t		start, end;
;1811:	int			content;
;1812:
;1813:	VectorCopy( cg.refdef.vieworg, start );
ADDRLP4 56
ADDRGP4 cg+109044+24
INDIRB
ASGNB 12
line 1814
;1814:	VectorMA( start, 131072, cg.refdef.viewaxis[0], end );
ADDRLP4 84
CNSTF4 1207959552
ASGNF4
ADDRLP4 68
ADDRLP4 56
INDIRF4
ADDRLP4 84
INDIRF4
ADDRGP4 cg+109044+36
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 68+4
ADDRLP4 56+4
INDIRF4
ADDRLP4 84
INDIRF4
ADDRGP4 cg+109044+36+4
INDIRF4
MULF4
ADDF4
ASGNF4
ADDRLP4 68+8
ADDRLP4 56+8
INDIRF4
CNSTF4 1207959552
ADDRGP4 cg+109044+36+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 1816
;1815:
;1816:	CG_Trace( &trace, start, vec3_origin, vec3_origin, end, 
ADDRLP4 0
ARGP4
ADDRLP4 56
ARGP4
ADDRLP4 88
ADDRGP4 vec3_origin
ASGNP4
ADDRLP4 88
INDIRP4
ARGP4
ADDRLP4 88
INDIRP4
ARGP4
ADDRLP4 68
ARGP4
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
ARGI4
CNSTI4 33554433
ARGI4
ADDRGP4 CG_Trace
CALLV
pop
line 1818
;1817:		cg.snap->ps.clientNum, CONTENTS_SOLID|CONTENTS_BODY );
;1818:	if ( trace.entityNum >= MAX_CLIENTS ) {
ADDRLP4 0+52
INDIRI4
CNSTI4 64
LTI4 $945
line 1819
;1819:		return;
ADDRGP4 $929
JUMPV
LABELV $945
line 1823
;1820:	}
;1821:
;1822:	// if the player is in fog, don't show it
;1823:	content = trap_CM_PointContents( trace.endpos, 0 );
ADDRLP4 0+12
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 92
ADDRGP4 trap_CM_PointContents
CALLI4
ASGNI4
ADDRLP4 80
ADDRLP4 92
INDIRI4
ASGNI4
line 1824
;1824:	if ( content & CONTENTS_FOG ) {
ADDRLP4 80
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
EQI4 $949
line 1825
;1825:		return;
ADDRGP4 $929
JUMPV
LABELV $949
line 1829
;1826:	}
;1827:
;1828:	// if the player is invisible, don't show it
;1829:	if ( cg_entities[ trace.entityNum ].currentState.powerups & ( 1 << PW_INVIS ) ) {
CNSTI4 728
ADDRLP4 0+52
INDIRI4
MULI4
ADDRGP4 cg_entities+188
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $951
line 1830
;1830:		return;
ADDRGP4 $929
JUMPV
LABELV $951
line 1834
;1831:	}
;1832:
;1833:	// update the fade timer
;1834:	cg.crosshairClientNum = trace.entityNum;
ADDRGP4 cg+124400
ADDRLP4 0+52
INDIRI4
ASGNI4
line 1835
;1835:	cg.crosshairClientTime = cg.time;
ADDRGP4 cg+124404
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 1836
;1836:}
LABELV $929
endproc CG_ScanForCrosshairEntity 96 28
proc CG_DrawCrosshairNames 20 16
line 1839
;1837:
;1838:
;1839:static void CG_DrawCrosshairNames( void ) {
line 1844
;1840:	float		*color;
;1841:	char		*name;
;1842:	float		w;
;1843:
;1844:	if ( !cg_drawCrosshair.integer ) {
ADDRGP4 cg_drawCrosshair+12
INDIRI4
CNSTI4 0
NEI4 $960
line 1845
;1845:		return;
ADDRGP4 $959
JUMPV
LABELV $960
line 1847
;1846:	}
;1847:	if ( !cg_drawCrosshairNames.integer ) {
ADDRGP4 cg_drawCrosshairNames+12
INDIRI4
CNSTI4 0
NEI4 $963
line 1848
;1848:		return;
ADDRGP4 $959
JUMPV
LABELV $963
line 1850
;1849:	}
;1850:	if ( cg.renderingThirdPerson ) {
ADDRGP4 cg+107628
INDIRI4
CNSTI4 0
EQI4 $966
line 1851
;1851:		return;
ADDRGP4 $959
JUMPV
LABELV $966
line 1855
;1852:	}
;1853:
;1854:	// scan the known entities to see if the crosshair is sighted on one
;1855:	CG_ScanForCrosshairEntity();
ADDRGP4 CG_ScanForCrosshairEntity
CALLV
pop
line 1858
;1856:
;1857:	// draw the name of the player being looked at
;1858:	color = CG_FadeColor( cg.crosshairClientTime, 1000 );
ADDRGP4 cg+124404
INDIRI4
ARGI4
CNSTI4 1000
ARGI4
ADDRLP4 12
ADDRGP4 CG_FadeColor
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRP4
ASGNP4
line 1859
;1859:	if ( !color ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $970
line 1860
;1860:		trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1861
;1861:		return;
ADDRGP4 $959
JUMPV
LABELV $970
line 1864
;1862:	}
;1863:
;1864:	name = cgs.clientinfo[ cg.crosshairClientNum ].name;
ADDRLP4 4
CNSTI4 1708
ADDRGP4 cg+124400
INDIRI4
MULI4
ADDRGP4 cgs+40972+4
ADDP4
ASGNP4
line 1870
;1865:#ifdef MISSIONPACK
;1866:	color[3] *= 0.5f;
;1867:	w = CG_Text_Width(name, 0.3f, 0);
;1868:	CG_Text_Paint( 320 - w / 2, 190, 0.3f, color, name, 0, 0, ITEM_TEXTSTYLE_SHADOWED);
;1869:#else
;1870:	w = CG_DrawStrlen( name ) * BIGCHAR_WIDTH;
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 16
INDIRI4
CNSTI4 4
LSHI4
CVIF4 4
ASGNF4
line 1871
;1871:	CG_DrawBigString( 320 - w / 2, 170, name, color[3] * 0.5f );
CNSTF4 1134559232
ADDRLP4 8
INDIRF4
CNSTF4 1073741824
DIVF4
SUBF4
CVFI4 4
ARGI4
CNSTI4 170
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
CNSTF4 1056964608
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
MULF4
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 1873
;1872:#endif
;1873:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1874
;1874:}
LABELV $959
endproc CG_DrawCrosshairNames 20 16
proc CG_DrawSpectator 0 16
line 1880
;1875:
;1876:
;1877://==============================================================================
;1878:
;1879:
;1880:static void CG_DrawSpectator(void) {
line 1881
;1881:	CG_DrawBigString(320 - 9 * 8, 440, "SPECTATOR", 1.0F);
CNSTI4 248
ARGI4
CNSTI4 440
ARGI4
ADDRGP4 $976
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 1882
;1882:	if ( cgs.gametype == GT_TOURNAMENT ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 1
NEI4 $977
line 1883
;1883:		CG_DrawBigString(320 - 15 * 8, 460, "waiting to play", 1.0F);
CNSTI4 200
ARGI4
CNSTI4 460
ARGI4
ADDRGP4 $980
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 1884
;1884:	}
ADDRGP4 $978
JUMPV
LABELV $977
line 1885
;1885:	else if ( cgs.gametype >= GT_TEAM ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $981
line 1886
;1886:		CG_DrawBigString(320 - 39 * 8, 460, "press ESC and use the JOIN menu to play", 1.0F);
CNSTI4 8
ARGI4
CNSTI4 460
ARGI4
ADDRGP4 $984
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 1887
;1887:	}
LABELV $981
LABELV $978
line 1888
;1888:}
LABELV $975
endproc CG_DrawSpectator 0 16
proc CG_DrawVote 12 20
line 1891
;1889:
;1890:
;1891:static void CG_DrawVote(void) {
line 1895
;1892:	char	*s;
;1893:	int		sec;
;1894:
;1895:	if ( !cgs.voteTime ) {
ADDRGP4 cgs+31676
INDIRI4
CNSTI4 0
NEI4 $986
line 1896
;1896:		return;
ADDRGP4 $985
JUMPV
LABELV $986
line 1900
;1897:	}
;1898:
;1899:	// play a talk beep whenever it is modified
;1900:	if ( cgs.voteModified ) {
ADDRGP4 cgs+31688
INDIRI4
CNSTI4 0
EQI4 $989
line 1901
;1901:		cgs.voteModified = qfalse;
ADDRGP4 cgs+31688
CNSTI4 0
ASGNI4
line 1902
;1902:		trap_S_StartLocalSound( cgs.media.talkSound, CHAN_LOCAL_SOUND );
ADDRGP4 cgs+152340+728
INDIRI4
ARGI4
CNSTI4 6
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 1903
;1903:	}
LABELV $989
line 1905
;1904:
;1905:	sec = ( VOTE_TIME - ( cg.time - cgs.voteTime ) ) / 1000;
ADDRLP4 0
CNSTI4 30000
ADDRGP4 cg+107604
INDIRI4
ADDRGP4 cgs+31676
INDIRI4
SUBI4
SUBI4
CNSTI4 1000
DIVI4
ASGNI4
line 1906
;1906:	if ( sec < 0 ) {
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $997
line 1907
;1907:		sec = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1908
;1908:	}
LABELV $997
line 1915
;1909:#ifdef MISSIONPACK
;1910:	s = va("VOTE(%i):%s yes:%i no:%i", sec, cgs.voteString, cgs.voteYes, cgs.voteNo);
;1911:	CG_DrawSmallString( 0, 58, s, 1.0F );
;1912:	s = "or press ESC then click Vote";
;1913:	CG_DrawSmallString( 0, 58 + SMALLCHAR_HEIGHT + 2, s, 1.0F );
;1914:#else
;1915:	s = va("VOTE(%i):%s yes:%i no:%i", sec, cgs.voteString, cgs.voteYes, cgs.voteNo );
ADDRGP4 $999
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 cgs+31692
ARGP4
ADDRGP4 cgs+31680
INDIRI4
ARGI4
ADDRGP4 cgs+31684
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
ASGNP4
line 1916
;1916:	CG_DrawSmallString( 0, 58, s, 1.0F );
CNSTI4 0
ARGI4
CNSTI4 58
ARGI4
ADDRLP4 4
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawSmallString
CALLV
pop
line 1918
;1917:#endif
;1918:}
LABELV $985
endproc CG_DrawVote 12 20
proc CG_DrawTeamVote 24 20
line 1921
;1919:
;1920:
;1921:static void CG_DrawTeamVote(void) {
line 1925
;1922:	char	*s;
;1923:	int		sec, cs_offset;
;1924:
;1925:	if ( cgs.clientinfo->team == TEAM_RED )
ADDRGP4 cgs+40972+68
INDIRI4
CNSTI4 1
NEI4 $1004
line 1926
;1926:		cs_offset = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1005
JUMPV
LABELV $1004
line 1927
;1927:	else if ( cgs.clientinfo->team == TEAM_BLUE )
ADDRGP4 cgs+40972+68
INDIRI4
CNSTI4 2
NEI4 $1003
line 1928
;1928:		cs_offset = 1;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 1930
;1929:	else
;1930:		return;
LABELV $1009
LABELV $1005
line 1932
;1931:
;1932:	if ( !cgs.teamVoteTime[cs_offset] ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+32716
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1012
line 1933
;1933:		return;
ADDRGP4 $1003
JUMPV
LABELV $1012
line 1937
;1934:	}
;1935:
;1936:	// play a talk beep whenever it is modified
;1937:	if ( cgs.teamVoteModified[cs_offset] ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+32740
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1015
line 1938
;1938:		cgs.teamVoteModified[cs_offset] = qfalse;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+32740
ADDP4
CNSTI4 0
ASGNI4
line 1939
;1939:		trap_S_StartLocalSound( cgs.media.talkSound, CHAN_LOCAL_SOUND );
ADDRGP4 cgs+152340+728
INDIRI4
ARGI4
CNSTI4 6
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 1940
;1940:	}
LABELV $1015
line 1942
;1941:
;1942:	sec = ( VOTE_TIME - ( cg.time - cgs.teamVoteTime[cs_offset] ) ) / 1000;
ADDRLP4 4
CNSTI4 30000
ADDRGP4 cg+107604
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 cgs+32716
ADDP4
INDIRI4
SUBI4
SUBI4
CNSTI4 1000
DIVI4
ASGNI4
line 1943
;1943:	if ( sec < 0 ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
GEI4 $1023
line 1944
;1944:		sec = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 1945
;1945:	}
LABELV $1023
line 1946
;1946:	s = va("TEAMVOTE(%i):%s yes:%i no:%i", sec, cgs.teamVoteString[cs_offset],
ADDRGP4 $1025
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 10
LSHI4
ADDRGP4 cgs+32748
ADDP4
ARGP4
ADDRLP4 16
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 16
INDIRI4
ADDRGP4 cgs+32724
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
INDIRI4
ADDRGP4 cgs+32732
ADDP4
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 20
INDIRP4
ASGNP4
line 1948
;1947:							cgs.teamVoteYes[cs_offset], cgs.teamVoteNo[cs_offset] );
;1948:	CG_DrawSmallString( 0, 90, s, 1.0F );
CNSTI4 0
ARGI4
CNSTI4 90
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawSmallString
CALLV
pop
line 1949
;1949:}
LABELV $1003
endproc CG_DrawTeamVote 24 20
proc CG_DrawScoreboard 4 0
line 1952
;1950:
;1951:
;1952:static qboolean CG_DrawScoreboard() {
line 2017
;1953:#ifdef MISSIONPACK
;1954:	static qboolean firstTime = qtrue;
;1955:	float fade, *fadeColor;
;1956:
;1957:	if (menuScoreboard) {
;1958:		menuScoreboard->window.flags &= ~WINDOW_FORCED;
;1959:	}
;1960:	if (cg_paused.integer) {
;1961:		cg.deferredPlayerLoading = 0;
;1962:		firstTime = qtrue;
;1963:		return qfalse;
;1964:	}
;1965:
;1966:	// should never happen in Team Arena
;1967:	if (cgs.gametype == GT_SINGLE_PLAYER && cg.predictedPlayerState.pm_type == PM_INTERMISSION ) {
;1968:		cg.deferredPlayerLoading = 0;
;1969:		firstTime = qtrue;
;1970:		return qfalse;
;1971:	}
;1972:
;1973:	// don't draw scoreboard during death while warmup up
;1974:	if ( cg.warmup && !cg.showScores ) {
;1975:		return qfalse;
;1976:	}
;1977:
;1978:	if ( cg.showScores || cg.predictedPlayerState.pm_type == PM_DEAD || cg.predictedPlayerState.pm_type == PM_INTERMISSION ) {
;1979:		fade = 1.0;
;1980:		fadeColor = colorWhite;
;1981:	} else {
;1982:		fadeColor = CG_FadeColor( cg.scoreFadeTime, FADE_TIME );
;1983:		if ( !fadeColor ) {
;1984:			// next time scoreboard comes up, don't print killer
;1985:			cg.deferredPlayerLoading = 0;
;1986:			cg.killerName[0] = 0;
;1987:			firstTime = qtrue;
;1988:			return qfalse;
;1989:		}
;1990:		fade = *fadeColor;
;1991:	}																					  
;1992:
;1993:
;1994:	if (menuScoreboard == NULL) {
;1995:		if ( cgs.gametype >= GT_TEAM ) {
;1996:			menuScoreboard = Menus_FindByName("teamscore_menu");
;1997:		} else {
;1998:			menuScoreboard = Menus_FindByName("score_menu");
;1999:		}
;2000:	}
;2001:
;2002:	if (menuScoreboard) {
;2003:		if (firstTime) {
;2004:			CG_SetScoreSelection(menuScoreboard);
;2005:			firstTime = qfalse;
;2006:		}
;2007:		Menu_Paint(menuScoreboard, qtrue);
;2008:	}
;2009:
;2010:	// load any models that have been deferred
;2011:	if ( ++cg.deferredPlayerLoading > 10 ) {
;2012:		CG_LoadDeferredPlayers();
;2013:	}
;2014:
;2015:	return qtrue;
;2016:#else
;2017:	return CG_DrawOldScoreboard();
ADDRLP4 0
ADDRGP4 CG_DrawOldScoreboard
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
RETI4
LABELV $1029
endproc CG_DrawScoreboard 4 0
proc CG_DrawIntermission 4 0
line 2022
;2018:#endif
;2019:}
;2020:
;2021:
;2022:static void CG_DrawIntermission( void ) {
line 2029
;2023:#ifdef MISSIONPACK
;2024:	//if (cg_singlePlayer.integer) {
;2025:	//	CG_DrawCenterString();
;2026:	//	return;
;2027:	//}
;2028:#else
;2029:	if ( cgs.gametype == GT_SINGLE_PLAYER ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 2
NEI4 $1031
line 2030
;2030:		CG_DrawCenterString();
ADDRGP4 CG_DrawCenterString
CALLV
pop
line 2031
;2031:		return;
ADDRGP4 $1030
JUMPV
LABELV $1031
line 2034
;2032:	}
;2033:#endif
;2034:	cg.scoreFadeTime = cg.time;
ADDRGP4 cg+114328
ADDRGP4 cg+107604
INDIRI4
ASGNI4
line 2035
;2035:	cg.scoreBoardShowing = CG_DrawScoreboard();
ADDRLP4 0
ADDRGP4 CG_DrawScoreboard
CALLI4
ASGNI4
ADDRGP4 cg+114324
ADDRLP4 0
INDIRI4
ASGNI4
line 2036
;2036:}
LABELV $1030
endproc CG_DrawIntermission 4 0
proc CG_DrawFollow 32 36
line 2039
;2037:
;2038:
;2039:static qboolean CG_DrawFollow( void ) {
line 2044
;2040:	float		x;
;2041:	vec4_t		color;
;2042:	const char	*name;
;2043:
;2044:	if ( !(cg.snap->ps.pm_flags & PMF_FOLLOW) ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
NEI4 $1038
line 2045
;2045:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1037
JUMPV
LABELV $1038
line 2047
;2046:	}
;2047:	color[0] = 1;
ADDRLP4 0
CNSTF4 1065353216
ASGNF4
line 2048
;2048:	color[1] = 1;
ADDRLP4 0+4
CNSTF4 1065353216
ASGNF4
line 2049
;2049:	color[2] = 1;
ADDRLP4 0+8
CNSTF4 1065353216
ASGNF4
line 2050
;2050:	color[3] = 1;
ADDRLP4 0+12
CNSTF4 1065353216
ASGNF4
line 2053
;2051:
;2052:
;2053:	CG_DrawBigString( 320 - 9 * 8, 24, "following", 1.0F );
CNSTI4 248
ARGI4
CNSTI4 24
ARGI4
ADDRGP4 $1044
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 2055
;2054:
;2055:	name = cgs.clientinfo[ cg.snap->ps.clientNum ].name;
ADDRLP4 16
CNSTI4 1708
ADDRGP4 cg+36
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
MULI4
ADDRGP4 cgs+40972+4
ADDP4
ASGNP4
line 2057
;2056:
;2057:	x = 0.5 * ( 640 - GIANT_WIDTH * CG_DrawStrlen( name ) );
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 20
CNSTF4 1056964608
CNSTI4 640
ADDRLP4 24
INDIRI4
CNSTI4 5
LSHI4
SUBI4
CVIF4 4
MULF4
ASGNF4
line 2059
;2058:
;2059:	CG_DrawStringExt( x, 40, name, color, qtrue, qtrue, GIANT_WIDTH, GIANT_HEIGHT, 0 );
ADDRLP4 20
INDIRF4
CVFI4 4
ARGI4
CNSTI4 40
ARGI4
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 28
CNSTI4 1
ASGNI4
ADDRLP4 28
INDIRI4
ARGI4
ADDRLP4 28
INDIRI4
ARGI4
CNSTI4 32
ARGI4
CNSTI4 48
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 2061
;2060:
;2061:	return qtrue;
CNSTI4 1
RETI4
LABELV $1037
endproc CG_DrawFollow 32 36
proc CG_DrawAmmoWarning 12 16
line 2065
;2062:}
;2063:
;2064:
;2065:static void CG_DrawAmmoWarning( void ) {
line 2069
;2066:	const char	*s;
;2067:	int			w;
;2068:
;2069:	if ( cg_drawAmmoWarning.integer == 0 ) {
ADDRGP4 cg_drawAmmoWarning+12
INDIRI4
CNSTI4 0
NEI4 $1049
line 2070
;2070:		return;
ADDRGP4 $1048
JUMPV
LABELV $1049
line 2073
;2071:	}
;2072:
;2073:	if ( !cg.lowAmmoWarning ) {
ADDRGP4 cg+124392
INDIRI4
CNSTI4 0
NEI4 $1052
line 2074
;2074:		return;
ADDRGP4 $1048
JUMPV
LABELV $1052
line 2077
;2075:	}
;2076:
;2077:	if ( cg.lowAmmoWarning == 2 ) {
ADDRGP4 cg+124392
INDIRI4
CNSTI4 2
NEI4 $1055
line 2078
;2078:		s = "OUT OF AMMO";
ADDRLP4 0
ADDRGP4 $1058
ASGNP4
line 2079
;2079:	} else {
ADDRGP4 $1056
JUMPV
LABELV $1055
line 2080
;2080:		s = "LOW AMMO WARNING";
ADDRLP4 0
ADDRGP4 $1059
ASGNP4
line 2081
;2081:	}
LABELV $1056
line 2082
;2082:	w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH;
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 8
INDIRI4
CNSTI4 4
LSHI4
ASGNI4
line 2083
;2083:	CG_DrawBigString(320 - w / 2, 64, s, 1.0F);
CNSTI4 320
ADDRLP4 4
INDIRI4
CNSTI4 2
DIVI4
SUBI4
ARGI4
CNSTI4 64
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 2084
;2084:}
LABELV $1048
endproc CG_DrawAmmoWarning 12 16
proc CG_DrawWarmup 56 36
line 2123
;2085:
;2086:
;2087:#ifdef MISSIONPACK
;2088:static void CG_DrawProxWarning( void ) {
;2089:	char s [32];
;2090:	int			w;
;2091:  static int proxTime;
;2092:  static int proxCounter;
;2093:  static int proxTick;
;2094:
;2095:	if( !(cg.snap->ps.eFlags & EF_TICKING ) ) {
;2096:    proxTime = 0;
;2097:		return;
;2098:	}
;2099:
;2100:  if (proxTime == 0) {
;2101:    proxTime = cg.time + 5000;
;2102:    proxCounter = 5;
;2103:    proxTick = 0;
;2104:  }
;2105:
;2106:  if (cg.time > proxTime) {
;2107:    proxTick = proxCounter--;
;2108:    proxTime = cg.time + 1000;
;2109:  }
;2110:
;2111:  if (proxTick != 0) {
;2112:    Com_sprintf(s, sizeof(s), "INTERNAL COMBUSTION IN: %i", proxTick);
;2113:  } else {
;2114:    Com_sprintf(s, sizeof(s), "YOU HAVE BEEN MINED");
;2115:  }
;2116:
;2117:	w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH;
;2118:	CG_DrawBigStringColor( 320 - w / 2, 64 + BIGCHAR_HEIGHT, s, g_color_table[ColorIndex(COLOR_RED)] );
;2119:}
;2120:#endif
;2121:
;2122:
;2123:static void CG_DrawWarmup( void ) {
line 2132
;2124:	int			w;
;2125:	int			sec;
;2126:	int			i;
;2127:	float scale;
;2128:	clientInfo_t	*ci1, *ci2;
;2129:	int			cw;
;2130:	const char	*s;
;2131:
;2132:	sec = cg.warmup;
ADDRLP4 4
ADDRGP4 cg+124656
INDIRI4
ASGNI4
line 2133
;2133:	if ( !sec ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $1062
line 2134
;2134:		return;
ADDRGP4 $1060
JUMPV
LABELV $1062
line 2137
;2135:	}
;2136:
;2137:	if ( sec < 0 ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
GEI4 $1064
line 2138
;2138:		s = "Waiting for players";		
ADDRLP4 8
ADDRGP4 $1066
ASGNP4
line 2139
;2139:		w = CG_DrawStrlen( s ) * BIGCHAR_WIDTH;
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 32
INDIRI4
CNSTI4 4
LSHI4
ASGNI4
line 2140
;2140:		CG_DrawBigString(320 - w / 2, 24, s, 1.0F);
CNSTI4 320
ADDRLP4 16
INDIRI4
CNSTI4 2
DIVI4
SUBI4
ARGI4
CNSTI4 24
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 CG_DrawBigString
CALLV
pop
line 2141
;2141:		cg.warmupCount = 0;
ADDRGP4 cg+124660
CNSTI4 0
ASGNI4
line 2142
;2142:		return;
ADDRGP4 $1060
JUMPV
LABELV $1064
line 2145
;2143:	}
;2144:
;2145:	if (cgs.gametype == GT_TOURNAMENT) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 1
NEI4 $1068
line 2147
;2146:		// find the two active players
;2147:		ci1 = NULL;
ADDRLP4 20
CNSTP4 0
ASGNP4
line 2148
;2148:		ci2 = NULL;
ADDRLP4 24
CNSTP4 0
ASGNP4
line 2149
;2149:		for ( i = 0 ; i < cgs.maxclients ; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1074
JUMPV
LABELV $1071
line 2150
;2150:			if ( cgs.clientinfo[i].infoValid && cgs.clientinfo[i].team == TEAM_FREE ) {
ADDRLP4 32
CNSTI4 1708
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 36
CNSTI4 0
ASGNI4
ADDRLP4 32
INDIRI4
ADDRGP4 cgs+40972
ADDP4
INDIRI4
ADDRLP4 36
INDIRI4
EQI4 $1076
ADDRLP4 32
INDIRI4
ADDRGP4 cgs+40972+68
ADDP4
INDIRI4
ADDRLP4 36
INDIRI4
NEI4 $1076
line 2151
;2151:				if ( !ci1 ) {
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1081
line 2152
;2152:					ci1 = &cgs.clientinfo[i];
ADDRLP4 20
CNSTI4 1708
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cgs+40972
ADDP4
ASGNP4
line 2153
;2153:				} else {
ADDRGP4 $1082
JUMPV
LABELV $1081
line 2154
;2154:					ci2 = &cgs.clientinfo[i];
ADDRLP4 24
CNSTI4 1708
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 cgs+40972
ADDP4
ASGNP4
line 2155
;2155:				}
LABELV $1082
line 2156
;2156:			}
LABELV $1076
line 2157
;2157:		}
LABELV $1072
line 2149
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1074
ADDRLP4 0
INDIRI4
ADDRGP4 cgs+31480
INDIRI4
LTI4 $1071
line 2159
;2158:
;2159:		if ( ci1 && ci2 ) {
ADDRLP4 32
CNSTU4 0
ASGNU4
ADDRLP4 20
INDIRP4
CVPU4 4
ADDRLP4 32
INDIRU4
EQU4 $1069
ADDRLP4 24
INDIRP4
CVPU4 4
ADDRLP4 32
INDIRU4
EQU4 $1069
line 2160
;2160:			s = va( "%s vs %s", ci1->name, ci2->name );
ADDRGP4 $1087
ARGP4
ADDRLP4 36
CNSTI4 4
ASGNI4
ADDRLP4 20
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
ARGP4
ADDRLP4 24
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
ARGP4
ADDRLP4 40
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 40
INDIRP4
ASGNP4
line 2165
;2161:#ifdef MISSIONPACK
;2162:			w = CG_Text_Width(s, 0.6f, 0);
;2163:			CG_Text_Paint(320 - w / 2, 60, 0.6f, colorWhite, s, 0, 0, ITEM_TEXTSTYLE_SHADOWEDMORE);
;2164:#else
;2165:			w = CG_DrawStrlen( s );
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 44
INDIRI4
ASGNI4
line 2166
;2166:			if ( w > 640 / GIANT_WIDTH ) {
ADDRLP4 16
INDIRI4
CNSTI4 20
LEI4 $1088
line 2167
;2167:				cw = 640 / w;
ADDRLP4 12
CNSTI4 640
ADDRLP4 16
INDIRI4
DIVI4
ASGNI4
line 2168
;2168:			} else {
ADDRGP4 $1089
JUMPV
LABELV $1088
line 2169
;2169:				cw = GIANT_WIDTH;
ADDRLP4 12
CNSTI4 32
ASGNI4
line 2170
;2170:			}
LABELV $1089
line 2171
;2171:			CG_DrawStringExt( 320 - w * cw/2, 20,s, colorWhite, 
CNSTI4 320
ADDRLP4 16
INDIRI4
ADDRLP4 12
INDIRI4
MULI4
CNSTI4 2
DIVI4
SUBI4
ARGI4
CNSTI4 20
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 52
CNSTI4 0
ASGNI4
ADDRLP4 52
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
CNSTF4 1069547520
ADDRLP4 12
INDIRI4
CVIF4 4
MULF4
CVFI4 4
ARGI4
ADDRLP4 52
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 2174
;2172:					qfalse, qtrue, cw, (int)(cw * 1.5f), 0 );
;2173:#endif
;2174:		}
line 2175
;2175:	} else {
ADDRGP4 $1069
JUMPV
LABELV $1068
line 2176
;2176:		if ( cgs.gametype == GT_FFA ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 0
NEI4 $1090
line 2177
;2177:			s = "Free For All";
ADDRLP4 8
ADDRGP4 $1093
ASGNP4
line 2178
;2178:		} else if ( cgs.gametype == GT_TEAM ) {
ADDRGP4 $1091
JUMPV
LABELV $1090
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
NEI4 $1094
line 2179
;2179:			s = "Team Deathmatch";
ADDRLP4 8
ADDRGP4 $1097
ASGNP4
line 2180
;2180:		} else if ( cgs.gametype == GT_CTF ) {
ADDRGP4 $1095
JUMPV
LABELV $1094
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 4
NEI4 $1098
line 2181
;2181:			s = "Capture the Flag";
ADDRLP4 8
ADDRGP4 $1101
ASGNP4
line 2190
;2182:#ifdef MISSIONPACK
;2183:		} else if ( cgs.gametype == GT_1FCTF ) {
;2184:			s = "One Flag CTF";
;2185:		} else if ( cgs.gametype == GT_OBELISK ) {
;2186:			s = "Overload";
;2187:		} else if ( cgs.gametype == GT_HARVESTER ) {
;2188:			s = "Harvester";
;2189:#endif
;2190:		} else {
ADDRGP4 $1099
JUMPV
LABELV $1098
line 2191
;2191:			s = "";
ADDRLP4 8
ADDRGP4 $1102
ASGNP4
line 2192
;2192:		}
LABELV $1099
LABELV $1095
LABELV $1091
line 2197
;2193:#ifdef MISSIONPACK
;2194:		w = CG_Text_Width(s, 0.6f, 0);
;2195:		CG_Text_Paint(320 - w / 2, 90, 0.6f, colorWhite, s, 0, 0, ITEM_TEXTSTYLE_SHADOWEDMORE);
;2196:#else
;2197:		w = CG_DrawStrlen( s );
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 32
INDIRI4
ASGNI4
line 2198
;2198:		if ( w > 640 / GIANT_WIDTH ) {
ADDRLP4 16
INDIRI4
CNSTI4 20
LEI4 $1103
line 2199
;2199:			cw = 640 / w;
ADDRLP4 12
CNSTI4 640
ADDRLP4 16
INDIRI4
DIVI4
ASGNI4
line 2200
;2200:		} else {
ADDRGP4 $1104
JUMPV
LABELV $1103
line 2201
;2201:			cw = GIANT_WIDTH;
ADDRLP4 12
CNSTI4 32
ASGNI4
line 2202
;2202:		}
LABELV $1104
line 2203
;2203:		CG_DrawStringExt( 320 - w * cw/2, 25,s, colorWhite, 
CNSTI4 320
ADDRLP4 16
INDIRI4
ADDRLP4 12
INDIRI4
MULI4
CNSTI4 2
DIVI4
SUBI4
ARGI4
CNSTI4 25
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 40
CNSTI4 0
ASGNI4
ADDRLP4 40
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
CNSTF4 1066192077
ADDRLP4 12
INDIRI4
CVIF4 4
MULF4
CVFI4 4
ARGI4
ADDRLP4 40
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 2206
;2204:				qfalse, qtrue, cw, (int)(cw * 1.1f), 0 );
;2205:#endif
;2206:	}
LABELV $1069
line 2208
;2207:
;2208:	sec = ( sec - cg.time ) / 1000;
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRGP4 cg+107604
INDIRI4
SUBI4
CNSTI4 1000
DIVI4
ASGNI4
line 2209
;2209:	if ( sec < 0 ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
GEI4 $1106
line 2210
;2210:		cg.warmup = 0;
ADDRGP4 cg+124656
CNSTI4 0
ASGNI4
line 2211
;2211:		sec = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 2212
;2212:	}
LABELV $1106
line 2213
;2213:	s = va( "Starts in: %i", sec + 1 );
ADDRGP4 $1109
ARGP4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 32
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 32
INDIRP4
ASGNP4
line 2214
;2214:	if ( sec != cg.warmupCount ) {
ADDRLP4 4
INDIRI4
ADDRGP4 cg+124660
INDIRI4
EQI4 $1110
line 2215
;2215:		cg.warmupCount = sec;
ADDRGP4 cg+124660
ADDRLP4 4
INDIRI4
ASGNI4
line 2216
;2216:		switch ( sec ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $1116
ADDRLP4 4
INDIRI4
CNSTI4 1
EQI4 $1119
ADDRLP4 4
INDIRI4
CNSTI4 2
EQI4 $1122
ADDRGP4 $1115
JUMPV
LABELV $1116
line 2218
;2217:		case 0:
;2218:			trap_S_StartLocalSound( cgs.media.count1Sound, CHAN_ANNOUNCER );
ADDRGP4 cgs+152340+964
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 2219
;2219:			break;
ADDRGP4 $1115
JUMPV
LABELV $1119
line 2221
;2220:		case 1:
;2221:			trap_S_StartLocalSound( cgs.media.count2Sound, CHAN_ANNOUNCER );
ADDRGP4 cgs+152340+960
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 2222
;2222:			break;
ADDRGP4 $1115
JUMPV
LABELV $1122
line 2224
;2223:		case 2:
;2224:			trap_S_StartLocalSound( cgs.media.count3Sound, CHAN_ANNOUNCER );
ADDRGP4 cgs+152340+956
INDIRI4
ARGI4
CNSTI4 7
ARGI4
ADDRGP4 trap_S_StartLocalSound
CALLV
pop
line 2225
;2225:			break;
line 2227
;2226:		default:
;2227:			break;
LABELV $1115
line 2229
;2228:		}
;2229:	}
LABELV $1110
line 2230
;2230:	scale = 0.45f;
ADDRLP4 28
CNSTF4 1055286886
ASGNF4
line 2231
;2231:	switch ( cg.warmupCount ) {
ADDRLP4 36
ADDRGP4 cg+124660
INDIRI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $1128
ADDRLP4 36
INDIRI4
CNSTI4 1
EQI4 $1129
ADDRLP4 36
INDIRI4
CNSTI4 2
EQI4 $1130
ADDRGP4 $1125
JUMPV
LABELV $1128
line 2233
;2232:	case 0:
;2233:		cw = 28;
ADDRLP4 12
CNSTI4 28
ASGNI4
line 2234
;2234:		scale = 0.54f;
ADDRLP4 28
CNSTF4 1057635697
ASGNF4
line 2235
;2235:		break;
ADDRGP4 $1126
JUMPV
LABELV $1129
line 2237
;2236:	case 1:
;2237:		cw = 24;
ADDRLP4 12
CNSTI4 24
ASGNI4
line 2238
;2238:		scale = 0.51f;
ADDRLP4 28
CNSTF4 1057132380
ASGNF4
line 2239
;2239:		break;
ADDRGP4 $1126
JUMPV
LABELV $1130
line 2241
;2240:	case 2:
;2241:		cw = 20;
ADDRLP4 12
CNSTI4 20
ASGNI4
line 2242
;2242:		scale = 0.48f;
ADDRLP4 28
CNSTF4 1056293519
ASGNF4
line 2243
;2243:		break;
ADDRGP4 $1126
JUMPV
LABELV $1125
line 2245
;2244:	default:
;2245:		cw = 16;
ADDRLP4 12
CNSTI4 16
ASGNI4
line 2246
;2246:		scale = 0.45f;
ADDRLP4 28
CNSTF4 1055286886
ASGNF4
line 2247
;2247:		break;
LABELV $1126
line 2254
;2248:	}
;2249:
;2250:#ifdef MISSIONPACK
;2251:		w = CG_Text_Width(s, scale, 0);
;2252:		CG_Text_Paint(320 - w / 2, 125, scale, colorWhite, s, 0, 0, ITEM_TEXTSTYLE_SHADOWEDMORE);
;2253:#else
;2254:	w = CG_DrawStrlen( s );
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 CG_DrawStrlen
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 40
INDIRI4
ASGNI4
line 2255
;2255:	CG_DrawStringExt( 320 - w * cw/2, 70, s, colorWhite, 
CNSTI4 320
ADDRLP4 16
INDIRI4
ADDRLP4 12
INDIRI4
MULI4
CNSTI4 2
DIVI4
SUBI4
ARGI4
CNSTI4 70
ARGI4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 48
CNSTI4 0
ASGNI4
ADDRLP4 48
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
CNSTF4 1069547520
ADDRLP4 12
INDIRI4
CVIF4 4
MULF4
CVFI4 4
ARGI4
ADDRLP4 48
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 2258
;2256:			qfalse, qtrue, cw, (int)(cw * 1.5), 0 );
;2257:#endif
;2258:}
LABELV $1060
endproc CG_DrawWarmup 56 36
proc CG_Draw2D 8 0
line 2275
;2259:
;2260://==================================================================================
;2261:#ifdef MISSIONPACK
;2262:void CG_DrawTimedMenus() {
;2263:	if (cg.voiceTime) {
;2264:		int t = cg.time - cg.voiceTime;
;2265:		if ( t > 2500 ) {
;2266:			Menus_CloseByName("voiceMenu");
;2267:			trap_Cvar_Set("cl_conXOffset", "0");
;2268:			cg.voiceTime = 0;
;2269:		}
;2270:	}
;2271:}
;2272:#endif
;2273:
;2274:
;2275:static void CG_Draw2D( void ) {
line 2282
;2276:#ifdef MISSIONPACK
;2277:	if (cgs.orderPending && cg.time > cgs.orderTime) {
;2278:		CG_CheckOrderPending();
;2279:	}
;2280:#endif
;2281:	// if we are taking a levelshot for the menu, don't draw anything
;2282:	if ( cg.levelShot ) {
ADDRGP4 cg+12
INDIRI4
CNSTI4 0
EQI4 $1132
line 2283
;2283:		return;
ADDRGP4 $1131
JUMPV
LABELV $1132
line 2286
;2284:	}
;2285:
;2286:	if ( cg_draw2D.integer == 0 ) {
ADDRGP4 cg_draw2D+12
INDIRI4
CNSTI4 0
NEI4 $1135
line 2287
;2287:		return;
ADDRGP4 $1131
JUMPV
LABELV $1135
line 2290
;2288:	}
;2289:
;2290:	if ( cg.snap->ps.pm_type == PM_INTERMISSION ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 48
ADDP4
INDIRI4
CNSTI4 5
NEI4 $1138
line 2291
;2291:		CG_DrawIntermission();
ADDRGP4 CG_DrawIntermission
CALLV
pop
line 2292
;2292:		return;
ADDRGP4 $1131
JUMPV
LABELV $1138
line 2295
;2293:	}
;2294:
;2295:	if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR ) {
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 3
NEI4 $1141
line 2296
;2296:		CG_DrawSpectator();
ADDRGP4 CG_DrawSpectator
CALLV
pop
line 2297
;2297:		CG_DrawCrosshair();
ADDRGP4 CG_DrawCrosshair
CALLV
pop
line 2298
;2298:		CG_DrawCrosshairNames();
ADDRGP4 CG_DrawCrosshairNames
CALLV
pop
line 2299
;2299:	} else {
ADDRGP4 $1142
JUMPV
LABELV $1141
line 2301
;2300:		// don't draw any status if dead or the scoreboard is being explicitly shown
;2301:		if ( !cg.showScores && cg.snap->ps.stats[STAT_HEALTH] > 0 ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 cg+114320
INDIRI4
ADDRLP4 0
INDIRI4
NEI4 $1144
ADDRGP4 cg+36
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
LEI4 $1144
line 2309
;2302:
;2303:#ifdef MISSIONPACK
;2304:			if ( cg_drawStatus.integer ) {
;2305:				Menu_PaintAll();
;2306:				CG_DrawTimedMenus();
;2307:			}
;2308:#else
;2309:			CG_DrawStatusBar();
ADDRGP4 CG_DrawStatusBar
CALLV
pop
line 2312
;2310:#endif
;2311:      
;2312:			CG_DrawAmmoWarning();
ADDRGP4 CG_DrawAmmoWarning
CALLV
pop
line 2317
;2313:
;2314:#ifdef MISSIONPACK
;2315:			CG_DrawProxWarning();
;2316:#endif      
;2317:			CG_DrawCrosshair();
ADDRGP4 CG_DrawCrosshair
CALLV
pop
line 2318
;2318:			CG_DrawCrosshairNames();
ADDRGP4 CG_DrawCrosshairNames
CALLV
pop
line 2319
;2319:			CG_DrawWeaponSelect();
ADDRGP4 CG_DrawWeaponSelect
CALLV
pop
line 2322
;2320:
;2321:#ifndef MISSIONPACK
;2322:			CG_DrawHoldableItem();
ADDRGP4 CG_DrawHoldableItem
CALLV
pop
line 2324
;2323:#endif
;2324:			CG_DrawReward();
ADDRGP4 CG_DrawReward
CALLV
pop
line 2325
;2325:		}
LABELV $1144
line 2327
;2326:    
;2327:		if ( cgs.gametype >= GT_TEAM ) {
ADDRGP4 cgs+31456
INDIRI4
CNSTI4 3
LTI4 $1148
line 2329
;2328:#ifndef MISSIONPACK
;2329:			CG_DrawTeamInfo();
ADDRGP4 CG_DrawTeamInfo
CALLV
pop
line 2331
;2330:#endif
;2331:		}
LABELV $1148
line 2332
;2332:	}
LABELV $1142
line 2334
;2333:
;2334:	CG_DrawVote();
ADDRGP4 CG_DrawVote
CALLV
pop
line 2335
;2335:	CG_DrawTeamVote();
ADDRGP4 CG_DrawTeamVote
CALLV
pop
line 2337
;2336:
;2337:	CG_DrawLagometer();
ADDRGP4 CG_DrawLagometer
CALLV
pop
line 2344
;2338:
;2339:#ifdef MISSIONPACK
;2340:	if (!cg_paused.integer) {
;2341:		CG_DrawUpperRight();
;2342:	}
;2343:#else
;2344:	CG_DrawUpperRight();
ADDRGP4 CG_DrawUpperRight
CALLV
pop
line 2348
;2345:#endif
;2346:
;2347:#ifndef MISSIONPACK
;2348:	CG_DrawLowerRight();
ADDRGP4 CG_DrawLowerRight
CALLV
pop
line 2349
;2349:	CG_DrawLowerLeft();
ADDRGP4 CG_DrawLowerLeft
CALLV
pop
line 2352
;2350:#endif
;2351:
;2352:	if ( !CG_DrawFollow() ) {
ADDRLP4 0
ADDRGP4 CG_DrawFollow
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $1151
line 2353
;2353:		CG_DrawWarmup();
ADDRGP4 CG_DrawWarmup
CALLV
pop
line 2354
;2354:	}
LABELV $1151
line 2357
;2355:
;2356:	// don't draw center string if scoreboard is up
;2357:	cg.scoreBoardShowing = CG_DrawScoreboard();
ADDRLP4 4
ADDRGP4 CG_DrawScoreboard
CALLI4
ASGNI4
ADDRGP4 cg+114324
ADDRLP4 4
INDIRI4
ASGNI4
line 2358
;2358:	if ( !cg.scoreBoardShowing) {
ADDRGP4 cg+114324
INDIRI4
CNSTI4 0
NEI4 $1154
line 2359
;2359:		CG_DrawCenterString();
ADDRGP4 CG_DrawCenterString
CALLV
pop
line 2360
;2360:	}
LABELV $1154
line 2361
;2361:}
LABELV $1131
endproc CG_Draw2D 8 0
proc CG_DrawTourneyScoreboard 0 0
line 2364
;2362:
;2363:
;2364:static void CG_DrawTourneyScoreboard() {
line 2367
;2365:#ifdef MISSIONPACK
;2366:#else
;2367:	CG_DrawOldTourneyScoreboard();
ADDRGP4 CG_DrawOldTourneyScoreboard
CALLV
pop
line 2369
;2368:#endif
;2369:}
LABELV $1157
endproc CG_DrawTourneyScoreboard 0 0
export CG_DrawActive
proc CG_DrawActive 24 4
line 2375
;2370:
;2371:
;2372:/*
;2373:Perform all drawing needed to completely fill the screen
;2374:*/
;2375:void CG_DrawActive( stereoFrame_t stereoView ) {
line 2380
;2376:	float		separation;
;2377:	vec3_t		baseOrg;
;2378:
;2379:	// optionally draw the info screen instead
;2380:	if ( !cg.snap ) {
ADDRGP4 cg+36
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1159
line 2381
;2381:		CG_DrawInformation();
ADDRGP4 CG_DrawInformation
CALLV
pop
line 2382
;2382:		return;
ADDRGP4 $1158
JUMPV
LABELV $1159
line 2386
;2383:	}
;2384:
;2385:	// optionally draw the tournement scoreboard instead
;2386:	if ( cg.snap->ps.persistant[PERS_TEAM] == TEAM_SPECTATOR &&
ADDRGP4 cg+36
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 3
NEI4 $1162
ADDRGP4 cg+36
INDIRP4
CNSTI4 56
ADDP4
INDIRI4
CNSTI4 8192
BANDI4
CNSTI4 0
EQI4 $1162
line 2387
;2387:		( cg.snap->ps.pm_flags & PMF_SCOREBOARD ) ) {
line 2388
;2388:		CG_DrawTourneyScoreboard();
ADDRGP4 CG_DrawTourneyScoreboard
CALLV
pop
line 2389
;2389:		return;
ADDRGP4 $1158
JUMPV
LABELV $1162
line 2392
;2390:	}
;2391:
;2392:	switch ( stereoView ) {
ADDRLP4 16
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $1169
ADDRLP4 16
INDIRI4
CNSTI4 1
EQI4 $1170
ADDRLP4 16
INDIRI4
CNSTI4 2
EQI4 $1172
ADDRGP4 $1166
JUMPV
LABELV $1169
line 2394
;2393:	case STEREO_CENTER:
;2394:		separation = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 2395
;2395:		break;
ADDRGP4 $1167
JUMPV
LABELV $1170
line 2397
;2396:	case STEREO_LEFT:
;2397:		separation = -cg_stereoSeparation.value / 2;
ADDRLP4 0
ADDRGP4 cg_stereoSeparation+8
INDIRF4
NEGF4
CNSTF4 1073741824
DIVF4
ASGNF4
line 2398
;2398:		break;
ADDRGP4 $1167
JUMPV
LABELV $1172
line 2400
;2399:	case STEREO_RIGHT:
;2400:		separation = cg_stereoSeparation.value / 2;
ADDRLP4 0
ADDRGP4 cg_stereoSeparation+8
INDIRF4
CNSTF4 1073741824
DIVF4
ASGNF4
line 2401
;2401:		break;
ADDRGP4 $1167
JUMPV
LABELV $1166
line 2403
;2402:	default:
;2403:		separation = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 2404
;2404:		CG_Error( "CG_DrawActive: Undefined stereoView" );
ADDRGP4 $1174
ARGP4
ADDRGP4 CG_Error
CALLV
pop
line 2405
;2405:	}
LABELV $1167
line 2409
;2406:
;2407:
;2408:	// clear around the rendered view if sized down
;2409:	CG_TileClear();
ADDRGP4 CG_TileClear
CALLV
pop
line 2419
;2410:
;2411:	// offset vieworg appropriately if we're doing stereo separation
;2412:#if 0
;2413:	VectorCopy( cg.refdef.vieworg, baseOrg );
;2414:	if ( separation != 0 ) {
;2415:		VectorMA( cg.refdef.vieworg, -separation, cg.refdef.viewaxis[1], cg.refdef.vieworg );
;2416:		// ↑cg.refdef.vieworg -= separation * cg.refdef.viewaxis
;2417:	}
;2418:#else
;2419:	if ( separation != 0 ) {
ADDRLP4 0
INDIRF4
CNSTF4 0
EQF4 $1175
line 2421
;2420:		// cg.refdef.vieworg = baseOrg - separation * cg.refdef.viewaxis
;2421:		VectorMA( baseOrg, -separation, cg.refdef.viewaxis[1], cg.refdef.vieworg );
ADDRGP4 cg+109044+24
ADDRLP4 4
INDIRF4
ADDRGP4 cg+109044+36+12
INDIRF4
ADDRLP4 0
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
ADDRGP4 cg+109044+24+4
ADDRLP4 4+4
INDIRF4
ADDRGP4 cg+109044+36+12+4
INDIRF4
ADDRLP4 0
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
ADDRGP4 cg+109044+24+8
ADDRLP4 4+8
INDIRF4
ADDRGP4 cg+109044+36+12+8
INDIRF4
ADDRLP4 0
INDIRF4
NEGF4
MULF4
ADDF4
ASGNF4
line 2422
;2422:	} else {
ADDRGP4 $1176
JUMPV
LABELV $1175
line 2424
;2423:		// cg.refdef.vieworg = baseOrg;
;2424:		VectorCopy( cg.refdef.vieworg, baseOrg );
ADDRLP4 4
ADDRGP4 cg+109044+24
INDIRB
ASGNB 12
line 2425
;2425:	}
LABELV $1176
line 2429
;2426:#endif
;2427:
;2428:	// draw 3D view
;2429:	trap_R_RenderScene( &cg.refdef );
ADDRGP4 cg+109044
ARGP4
ADDRGP4 trap_R_RenderScene
CALLV
pop
line 2432
;2430:
;2431:	// restore original viewpoint if running stereo
;2432:	if ( separation != 0 ) {
ADDRLP4 0
INDIRF4
CNSTF4 0
EQF4 $1201
line 2433
;2433:		VectorCopy( baseOrg, cg.refdef.vieworg );
ADDRGP4 cg+109044+24
ADDRLP4 4
INDIRB
ASGNB 12
line 2434
;2434:	}
LABELV $1201
line 2437
;2435:
;2436:	// draw status bar and other floating elements
;2437: 	CG_Draw2D();
ADDRGP4 CG_Draw2D
CALLV
pop
line 2438
;2438:}
LABELV $1158
endproc CG_DrawActive 24 4
bss
export lagometer
align 4
LABELV lagometer
skip 1544
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
export teamChat2
align 1
LABELV teamChat2
skip 256
export teamChat1
align 1
LABELV teamChat1
skip 256
export systemChat
align 1
LABELV systemChat
skip 256
export numSortedTeamPlayers
align 4
LABELV numSortedTeamPlayers
skip 4
export sortedTeamPlayers
align 4
LABELV sortedTeamPlayers
skip 128
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
LABELV $1174
byte 1 67
byte 1 71
byte 1 95
byte 1 68
byte 1 114
byte 1 97
byte 1 119
byte 1 65
byte 1 99
byte 1 116
byte 1 105
byte 1 118
byte 1 101
byte 1 58
byte 1 32
byte 1 85
byte 1 110
byte 1 100
byte 1 101
byte 1 102
byte 1 105
byte 1 110
byte 1 101
byte 1 100
byte 1 32
byte 1 115
byte 1 116
byte 1 101
byte 1 114
byte 1 101
byte 1 111
byte 1 86
byte 1 105
byte 1 101
byte 1 119
byte 1 0
align 1
LABELV $1109
byte 1 83
byte 1 116
byte 1 97
byte 1 114
byte 1 116
byte 1 115
byte 1 32
byte 1 105
byte 1 110
byte 1 58
byte 1 32
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $1102
byte 1 0
align 1
LABELV $1101
byte 1 67
byte 1 97
byte 1 112
byte 1 116
byte 1 117
byte 1 114
byte 1 101
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 70
byte 1 108
byte 1 97
byte 1 103
byte 1 0
align 1
LABELV $1097
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
LABELV $1093
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
LABELV $1087
byte 1 37
byte 1 115
byte 1 32
byte 1 118
byte 1 115
byte 1 32
byte 1 37
byte 1 115
byte 1 0
align 1
LABELV $1066
byte 1 87
byte 1 97
byte 1 105
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 102
byte 1 111
byte 1 114
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 101
byte 1 114
byte 1 115
byte 1 0
align 1
LABELV $1059
byte 1 76
byte 1 79
byte 1 87
byte 1 32
byte 1 65
byte 1 77
byte 1 77
byte 1 79
byte 1 32
byte 1 87
byte 1 65
byte 1 82
byte 1 78
byte 1 73
byte 1 78
byte 1 71
byte 1 0
align 1
LABELV $1058
byte 1 79
byte 1 85
byte 1 84
byte 1 32
byte 1 79
byte 1 70
byte 1 32
byte 1 65
byte 1 77
byte 1 77
byte 1 79
byte 1 0
align 1
LABELV $1044
byte 1 102
byte 1 111
byte 1 108
byte 1 108
byte 1 111
byte 1 119
byte 1 105
byte 1 110
byte 1 103
byte 1 0
align 1
LABELV $1025
byte 1 84
byte 1 69
byte 1 65
byte 1 77
byte 1 86
byte 1 79
byte 1 84
byte 1 69
byte 1 40
byte 1 37
byte 1 105
byte 1 41
byte 1 58
byte 1 37
byte 1 115
byte 1 32
byte 1 121
byte 1 101
byte 1 115
byte 1 58
byte 1 37
byte 1 105
byte 1 32
byte 1 110
byte 1 111
byte 1 58
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $999
byte 1 86
byte 1 79
byte 1 84
byte 1 69
byte 1 40
byte 1 37
byte 1 105
byte 1 41
byte 1 58
byte 1 37
byte 1 115
byte 1 32
byte 1 121
byte 1 101
byte 1 115
byte 1 58
byte 1 37
byte 1 105
byte 1 32
byte 1 110
byte 1 111
byte 1 58
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $984
byte 1 112
byte 1 114
byte 1 101
byte 1 115
byte 1 115
byte 1 32
byte 1 69
byte 1 83
byte 1 67
byte 1 32
byte 1 97
byte 1 110
byte 1 100
byte 1 32
byte 1 117
byte 1 115
byte 1 101
byte 1 32
byte 1 116
byte 1 104
byte 1 101
byte 1 32
byte 1 74
byte 1 79
byte 1 73
byte 1 78
byte 1 32
byte 1 109
byte 1 101
byte 1 110
byte 1 117
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $980
byte 1 119
byte 1 97
byte 1 105
byte 1 116
byte 1 105
byte 1 110
byte 1 103
byte 1 32
byte 1 116
byte 1 111
byte 1 32
byte 1 112
byte 1 108
byte 1 97
byte 1 121
byte 1 0
align 1
LABELV $976
byte 1 83
byte 1 80
byte 1 69
byte 1 67
byte 1 84
byte 1 65
byte 1 84
byte 1 79
byte 1 82
byte 1 0
align 1
LABELV $850
byte 1 115
byte 1 110
byte 1 99
byte 1 0
align 1
LABELV $785
byte 1 103
byte 1 102
byte 1 120
byte 1 47
byte 1 50
byte 1 100
byte 1 47
byte 1 110
byte 1 101
byte 1 116
byte 1 46
byte 1 116
byte 1 103
byte 1 97
byte 1 0
align 1
LABELV $781
byte 1 67
byte 1 111
byte 1 110
byte 1 110
byte 1 101
byte 1 99
byte 1 116
byte 1 105
byte 1 111
byte 1 110
byte 1 32
byte 1 73
byte 1 110
byte 1 116
byte 1 101
byte 1 114
byte 1 114
byte 1 117
byte 1 112
byte 1 116
byte 1 101
byte 1 100
byte 1 0
align 1
LABELV $750
byte 1 37
byte 1 100
byte 1 0
align 1
LABELV $506
byte 1 37
byte 1 50
byte 1 105
byte 1 0
align 1
LABELV $464
byte 1 37
byte 1 51
byte 1 105
byte 1 32
byte 1 37
byte 1 51
byte 1 105
byte 1 0
align 1
LABELV $461
byte 1 117
byte 1 110
byte 1 107
byte 1 110
byte 1 111
byte 1 119
byte 1 110
byte 1 0
align 1
LABELV $394
byte 1 37
byte 1 105
byte 1 58
byte 1 37
byte 1 105
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $390
byte 1 37
byte 1 105
byte 1 102
byte 1 112
byte 1 115
byte 1 0
align 1
LABELV $374
byte 1 116
byte 1 105
byte 1 109
byte 1 101
byte 1 58
byte 1 37
byte 1 105
byte 1 32
byte 1 115
byte 1 110
byte 1 97
byte 1 112
byte 1 58
byte 1 37
byte 1 105
byte 1 32
byte 1 99
byte 1 109
byte 1 100
byte 1 58
byte 1 37
byte 1 105
byte 1 0
align 1
LABELV $372
byte 1 110
byte 1 0
align 1
LABELV $107
byte 1 37
byte 1 105
byte 1 0
