export CG_AdjustFrom640
code
proc CG_AdjustFrom640 16 0
file "../cg_drawtools.c"
line 7
;1:// cg_drawtools.c -- helper functions called by cg_draw, cg_scoreboard, cg_info, etc
;2:#include "cg_local.h"
;3:
;4:/*
;5:Adjusted for resolution and screen aspect ratio
;6:*/
;7:void CG_AdjustFrom640( float *x, float *y, float *w, float *h ) {
line 15
;8:#if 0
;9:	// adjust for wide screens
;10:	if ( cgs.glconfig.vidWidth * 480 > cgs.glconfig.vidHeight * 640 ) {
;11:		*x += 0.5 * ( cgs.glconfig.vidWidth - ( cgs.glconfig.vidHeight * 640 / 480 ) );
;12:	}
;13:#endif
;14:	// scale for screen sizes
;15:	*x *= cgs.screenXScale;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRF4
ADDRGP4 cgs+31432
INDIRF4
MULF4
ASGNF4
line 16
;16:	*y *= cgs.screenYScale;
ADDRLP4 4
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRF4
ADDRGP4 cgs+31436
INDIRF4
MULF4
ASGNF4
line 17
;17:	*w *= cgs.screenXScale;
ADDRLP4 8
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
ADDRGP4 cgs+31432
INDIRF4
MULF4
ASGNF4
line 18
;18:	*h *= cgs.screenYScale;
ADDRLP4 12
ADDRFP4 12
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRF4
ADDRGP4 cgs+31436
INDIRF4
MULF4
ASGNF4
line 19
;19:}
LABELV $70
endproc CG_AdjustFrom640 16 0
export CG_FillRect
proc CG_FillRect 4 36
line 24
;20:
;21:/*
;22:Coordinates are 640*480 virtual values
;23:*/
;24:void CG_FillRect( float x, float y, float width, float height, const float *color ) {
line 25
;25:	trap_R_SetColor( color );
ADDRFP4 16
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 27
;26:
;27:	CG_AdjustFrom640( &x, &y, &width, &height );
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
line 28
;28:	trap_R_DrawStretchPic( x, y, width, height, 0, 0, 0, 0, cgs.media.whiteShader );
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
CNSTF4 0
ASGNF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRGP4 cgs+152340+16
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 30
;29:
;30:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 31
;31:}
LABELV $75
endproc CG_FillRect 4 36
export CG_DrawSides
proc CG_DrawSides 12 36
line 36
;32:
;33:/*
;34:Coords are virtual 640x480
;35:*/
;36:void CG_DrawSides(float x, float y, float w, float h, float size) {
line 37
;37:	CG_AdjustFrom640( &x, &y, &w, &h );
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
line 38
;38:	size *= cgs.screenXScale;
ADDRFP4 16
ADDRFP4 16
INDIRF4
ADDRGP4 cgs+31432
INDIRF4
MULF4
ASGNF4
line 39
;39:	trap_R_DrawStretchPic( x, y, size, h, 0, 0, 0, 0, cgs.media.whiteShader );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 16
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRLP4 0
CNSTF4 0
ASGNF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRGP4 cgs+152340+16
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 40
;40:	trap_R_DrawStretchPic( x + w - size, y, size, h, 0, 0, 0, 0, cgs.media.whiteShader );
ADDRLP4 4
ADDRFP4 16
INDIRF4
ASGNF4
ADDRFP4 0
INDIRF4
ADDRFP4 8
INDIRF4
ADDF4
ADDRLP4 4
INDIRF4
SUBF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRLP4 8
CNSTF4 0
ASGNF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRGP4 cgs+152340+16
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 41
;41:}
LABELV $78
endproc CG_DrawSides 12 36
export CG_DrawTopBottom
proc CG_DrawTopBottom 12 36
line 43
;42:
;43:void CG_DrawTopBottom(float x, float y, float w, float h, float size) {
line 44
;44:	CG_AdjustFrom640( &x, &y, &w, &h );
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
line 45
;45:	size *= cgs.screenYScale;
ADDRFP4 16
ADDRFP4 16
INDIRF4
ADDRGP4 cgs+31436
INDIRF4
MULF4
ASGNF4
line 46
;46:	trap_R_DrawStretchPic( x, y, w, size, 0, 0, 0, 0, cgs.media.whiteShader );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 16
INDIRF4
ARGF4
ADDRLP4 0
CNSTF4 0
ASGNF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRGP4 cgs+152340+16
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 47
;47:	trap_R_DrawStretchPic( x, y + h - size, w, size, 0, 0, 0, 0, cgs.media.whiteShader );
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 4
ADDRFP4 16
INDIRF4
ASGNF4
ADDRFP4 4
INDIRF4
ADDRFP4 12
INDIRF4
ADDF4
ADDRLP4 4
INDIRF4
SUBF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 8
CNSTF4 0
ASGNF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRGP4 cgs+152340+16
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 48
;48:}
LABELV $84
endproc CG_DrawTopBottom 12 36
export CG_DrawRect
proc CG_DrawRect 0 20
line 56
;49:/*
;50:================
;51:UI_DrawRect
;52:
;53:Coordinates are 640*480 virtual values
;54:=================
;55:*/
;56:void CG_DrawRect( float x, float y, float width, float height, float size, const float *color ) {
line 57
;57:	trap_R_SetColor( color );
ADDRFP4 20
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 59
;58:
;59:  CG_DrawTopBottom(x, y, width, height, size);
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
ADDRFP4 16
INDIRF4
ARGF4
ADDRGP4 CG_DrawTopBottom
CALLV
pop
line 60
;60:  CG_DrawSides(x, y, width, height, size);
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
ADDRFP4 16
INDIRF4
ARGF4
ADDRGP4 CG_DrawSides
CALLV
pop
line 62
;61:
;62:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 63
;63:}
LABELV $90
endproc CG_DrawRect 0 20
export CG_DrawPic
proc CG_DrawPic 8 36
line 74
;64:
;65:
;66:
;67:/*
;68:================
;69:CG_DrawPic
;70:
;71:Coordinates are 640*480 virtual values
;72:=================
;73:*/
;74:void CG_DrawPic( float x, float y, float width, float height, qhandle_t hShader ) {
line 75
;75:	CG_AdjustFrom640( &x, &y, &width, &height );
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
line 76
;76:	trap_R_DrawStretchPic( x, y, width, height, 0, 0, 1, 1, hShader );
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
CNSTF4 0
ASGNF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 77
;77:}
LABELV $91
endproc CG_DrawPic 8 36
export CG_DrawChar
proc CG_DrawChar 48 36
line 88
;78:
;79:
;80:
;81:/*
;82:===============
;83:CG_DrawChar
;84:
;85:Coordinates and size in 640*480 virtual screen size
;86:===============
;87:*/
;88:void CG_DrawChar( int x, int y, int width, int height, int ch ) {
line 94
;89:	int row, col;
;90:	float frow, fcol;
;91:	float size;
;92:	float	ax, ay, aw, ah;
;93:
;94:	ch &= 255;
ADDRFP4 16
ADDRFP4 16
INDIRI4
CNSTI4 255
BANDI4
ASGNI4
line 96
;95:
;96:	if ( ch == ' ' ) {
ADDRFP4 16
INDIRI4
CNSTI4 32
NEI4 $93
line 97
;97:		return;
ADDRGP4 $92
JUMPV
LABELV $93
line 100
;98:	}
;99:
;100:	ax = x;
ADDRLP4 12
ADDRFP4 0
INDIRI4
CVIF4 4
ASGNF4
line 101
;101:	ay = y;
ADDRLP4 16
ADDRFP4 4
INDIRI4
CVIF4 4
ASGNF4
line 102
;102:	aw = width;
ADDRLP4 20
ADDRFP4 8
INDIRI4
CVIF4 4
ASGNF4
line 103
;103:	ah = height;
ADDRLP4 24
ADDRFP4 12
INDIRI4
CVIF4 4
ASGNF4
line 104
;104:	CG_AdjustFrom640( &ax, &ay, &aw, &ah );
ADDRLP4 12
ARGP4
ADDRLP4 16
ARGP4
ADDRLP4 20
ARGP4
ADDRLP4 24
ARGP4
ADDRGP4 CG_AdjustFrom640
CALLV
pop
line 106
;105:
;106:	row = ch>>4;
ADDRLP4 28
ADDRFP4 16
INDIRI4
CNSTI4 4
RSHI4
ASGNI4
line 107
;107:	col = ch&15;
ADDRLP4 32
ADDRFP4 16
INDIRI4
CNSTI4 15
BANDI4
ASGNI4
line 109
;108:
;109:	frow = row*0.0625;
ADDRLP4 0
CNSTF4 1031798784
ADDRLP4 28
INDIRI4
CVIF4 4
MULF4
ASGNF4
line 110
;110:	fcol = col*0.0625;
ADDRLP4 4
CNSTF4 1031798784
ADDRLP4 32
INDIRI4
CVIF4 4
MULF4
ASGNF4
line 111
;111:	size = 0.0625;
ADDRLP4 8
CNSTF4 1031798784
ASGNF4
line 113
;112:
;113:	trap_R_DrawStretchPic( ax, ay, aw, ah,
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ADDRLP4 8
INDIRF4
ADDF4
ARGF4
ADDRLP4 0
INDIRF4
ADDRLP4 8
INDIRF4
ADDF4
ARGF4
ADDRGP4 cgs+152340
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 117
;114:					   fcol, frow, 
;115:					   fcol + size, frow + size, 
;116:					   cgs.media.charsetShader );
;117:}
LABELV $92
endproc CG_DrawChar 48 36
export CG_DrawStringExt
proc CG_DrawStringExt 48 20
line 131
;118:
;119:
;120:/*
;121:==================
;122:CG_DrawStringExt
;123:
;124:Draws a multi-colored string with a drop shadow, optionally forcing
;125:to a fixed color.
;126:
;127:Coordinates are at 640 by 480 virtual resolution
;128:==================
;129:*/
;130:void CG_DrawStringExt( int x, int y, const char *string, const float *setColor, 
;131:		qboolean forceColor, qboolean shadow, int charWidth, int charHeight, int maxChars ) {
line 137
;132:	vec4_t		color;
;133:	const char	*s;
;134:	int			xx;
;135:	int			cnt;
;136:
;137:	if (maxChars <= 0)
ADDRFP4 32
INDIRI4
CNSTI4 0
GTI4 $97
line 138
;138:		maxChars = 32767; // do them all!
ADDRFP4 32
CNSTI4 32767
ASGNI4
LABELV $97
line 141
;139:
;140:	// draw the drop shadow
;141:	if (shadow) {
ADDRFP4 20
INDIRI4
CNSTI4 0
EQI4 $99
line 142
;142:		color[0] = color[1] = color[2] = 0;
ADDRLP4 28
CNSTF4 0
ASGNF4
ADDRLP4 12+8
ADDRLP4 28
INDIRF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 28
INDIRF4
ASGNF4
ADDRLP4 12
ADDRLP4 28
INDIRF4
ASGNF4
line 143
;143:		color[3] = setColor[3];
ADDRLP4 12+12
ADDRFP4 12
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ASGNF4
line 144
;144:		trap_R_SetColor( color );
ADDRLP4 12
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 145
;145:		s = string;
ADDRLP4 0
ADDRFP4 8
INDIRP4
ASGNP4
line 146
;146:		xx = x;
ADDRLP4 4
ADDRFP4 0
INDIRI4
ASGNI4
line 147
;147:		cnt = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $105
JUMPV
LABELV $104
line 148
;148:		while ( *s && cnt < maxChars) {
line 149
;149:			if ( Q_IsColorString( s ) ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $107
ADDRLP4 36
CNSTI4 94
ASGNI4
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ADDRLP4 36
INDIRI4
NEI4 $107
ADDRLP4 40
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $107
ADDRLP4 40
INDIRI4
ADDRLP4 36
INDIRI4
EQI4 $107
line 150
;150:				s += 2;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 2
ADDP4
ASGNP4
line 151
;151:				continue;
ADDRGP4 $105
JUMPV
LABELV $107
line 153
;152:			}
;153:			CG_DrawChar( xx + 2, y + 2, charWidth, charHeight, *s );
ADDRLP4 44
CNSTI4 2
ASGNI4
ADDRLP4 4
INDIRI4
ADDRLP4 44
INDIRI4
ADDI4
ARGI4
ADDRFP4 4
INDIRI4
ADDRLP4 44
INDIRI4
ADDI4
ARGI4
ADDRFP4 24
INDIRI4
ARGI4
ADDRFP4 28
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ARGI4
ADDRGP4 CG_DrawChar
CALLV
pop
line 154
;154:			cnt++;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 155
;155:			xx += charWidth;
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRFP4 24
INDIRI4
ADDI4
ASGNI4
line 156
;156:			s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 157
;157:		}
LABELV $105
line 148
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $109
ADDRLP4 8
INDIRI4
ADDRFP4 32
INDIRI4
LTI4 $104
LABELV $109
line 158
;158:	}
LABELV $99
line 161
;159:
;160:	// draw the colored text
;161:	s = string;
ADDRLP4 0
ADDRFP4 8
INDIRP4
ASGNP4
line 162
;162:	xx = x;
ADDRLP4 4
ADDRFP4 0
INDIRI4
ASGNI4
line 163
;163:	cnt = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 164
;164:	trap_R_SetColor( setColor );
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
ADDRGP4 $111
JUMPV
LABELV $110
line 165
;165:	while ( *s && cnt < maxChars) {
line 166
;166:		if ( Q_IsColorString( s ) ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $113
ADDRLP4 32
CNSTI4 94
ASGNI4
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ADDRLP4 32
INDIRI4
NEI4 $113
ADDRLP4 36
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $113
ADDRLP4 36
INDIRI4
ADDRLP4 32
INDIRI4
EQI4 $113
line 167
;167:			if ( !forceColor ) {
ADDRFP4 16
INDIRI4
CNSTI4 0
NEI4 $115
line 168
;168:				memcpy( color, g_color_table[ColorIndex(*(s+1))], sizeof( color ) );
ADDRLP4 12
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
CNSTI4 48
SUBI4
CNSTI4 7
BANDI4
CNSTI4 4
LSHI4
ADDRGP4 g_color_table
ADDP4
ARGP4
CNSTI4 16
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 169
;169:				color[3] = setColor[3];
ADDRLP4 12+12
ADDRFP4 12
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ASGNF4
line 170
;170:				trap_R_SetColor( color );
ADDRLP4 12
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 171
;171:			}
LABELV $115
line 172
;172:			s += 2;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 2
ADDP4
ASGNP4
line 173
;173:			continue;
ADDRGP4 $111
JUMPV
LABELV $113
line 175
;174:		}
;175:		CG_DrawChar( xx, y, charWidth, charHeight, *s );
ADDRLP4 4
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 24
INDIRI4
ARGI4
ADDRFP4 28
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ARGI4
ADDRGP4 CG_DrawChar
CALLV
pop
line 176
;176:		xx += charWidth;
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRFP4 24
INDIRI4
ADDI4
ASGNI4
line 177
;177:		cnt++;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 178
;178:		s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 179
;179:	}
LABELV $111
line 165
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $118
ADDRLP4 8
INDIRI4
ADDRFP4 32
INDIRI4
LTI4 $110
LABELV $118
line 180
;180:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 181
;181:}
LABELV $96
endproc CG_DrawStringExt 48 20
export CG_DrawBigString
proc CG_DrawBigString 28 36
line 183
;182:
;183:void CG_DrawBigString( int x, int y, const char *s, float alpha ) {
line 186
;184:	float	color[4];
;185:
;186:	color[0] = color[1] = color[2] = 1.0;
ADDRLP4 16
CNSTF4 1065353216
ASGNF4
ADDRLP4 0+8
ADDRLP4 16
INDIRF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 16
INDIRF4
ASGNF4
ADDRLP4 0
ADDRLP4 16
INDIRF4
ASGNF4
line 187
;187:	color[3] = alpha;
ADDRLP4 0+12
ADDRFP4 12
INDIRF4
ASGNF4
line 188
;188:	CG_DrawStringExt( x, y, s, color, qfalse, qtrue, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0 );
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 20
CNSTI4 0
ASGNI4
ADDRLP4 20
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 24
CNSTI4 16
ASGNI4
ADDRLP4 24
INDIRI4
ARGI4
ADDRLP4 24
INDIRI4
ARGI4
ADDRLP4 20
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 189
;189:}
LABELV $119
endproc CG_DrawBigString 28 36
export CG_DrawBigStringColor
proc CG_DrawBigStringColor 8 36
line 191
;190:
;191:void CG_DrawBigStringColor( int x, int y, const char *s, vec4_t color ) {
line 192
;192:	CG_DrawStringExt( x, y, s, color, qtrue, qtrue, BIGCHAR_WIDTH, BIGCHAR_HEIGHT, 0 );
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
CNSTI4 16
ASGNI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 193
;193:}
LABELV $123
endproc CG_DrawBigStringColor 8 36
export CG_DrawSmallString
proc CG_DrawSmallString 24 36
line 195
;194:
;195:void CG_DrawSmallString( int x, int y, const char *s, float alpha ) {
line 198
;196:	float	color[4];
;197:
;198:	color[0] = color[1] = color[2] = 1.0;
ADDRLP4 16
CNSTF4 1065353216
ASGNF4
ADDRLP4 0+8
ADDRLP4 16
INDIRF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 16
INDIRF4
ASGNF4
ADDRLP4 0
ADDRLP4 16
INDIRF4
ASGNF4
line 199
;199:	color[3] = alpha;
ADDRLP4 0+12
ADDRFP4 12
INDIRF4
ASGNF4
line 200
;200:	CG_DrawStringExt( x, y, s, color, qfalse, qfalse, SMALLCHAR_WIDTH, SMALLCHAR_HEIGHT, 0 );
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 20
CNSTI4 0
ASGNI4
ADDRLP4 20
INDIRI4
ARGI4
ADDRLP4 20
INDIRI4
ARGI4
CNSTI4 8
ARGI4
CNSTI4 16
ARGI4
ADDRLP4 20
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 201
;201:}
LABELV $124
endproc CG_DrawSmallString 24 36
export CG_DrawSmallStringColor
proc CG_DrawSmallStringColor 4 36
line 203
;202:
;203:void CG_DrawSmallStringColor( int x, int y, const char *s, vec4_t color ) {
line 204
;204:	CG_DrawStringExt( x, y, s, color, qtrue, qfalse, SMALLCHAR_WIDTH, SMALLCHAR_HEIGHT, 0 );
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRI4
ARGI4
CNSTI4 8
ARGI4
CNSTI4 16
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 CG_DrawStringExt
CALLV
pop
line 205
;205:}
LABELV $128
endproc CG_DrawSmallStringColor 4 36
export CG_DrawStrlen
proc CG_DrawStrlen 20 0
line 214
;206:
;207:/*
;208:=================
;209:CG_DrawStrlen
;210:
;211:Returns character count, skiping color escape codes
;212:=================
;213:*/
;214:int CG_DrawStrlen( const char *str ) {
line 215
;215:	const char *s = str;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 216
;216:	int count = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $131
JUMPV
LABELV $130
line 218
;217:
;218:	while ( *s ) {
line 219
;219:		if ( Q_IsColorString( s ) ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $133
ADDRLP4 12
CNSTI4 94
ASGNI4
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ADDRLP4 12
INDIRI4
NEI4 $133
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $133
ADDRLP4 16
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $133
line 220
;220:			s += 2;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 2
ADDP4
ASGNP4
line 221
;221:		} else {
ADDRGP4 $134
JUMPV
LABELV $133
line 222
;222:			count++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 223
;223:			s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 224
;224:		}
LABELV $134
line 225
;225:	}
LABELV $131
line 218
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $130
line 227
;226:
;227:	return count;
ADDRLP4 4
INDIRI4
RETI4
LABELV $129
endproc CG_DrawStrlen 20 0
proc CG_TileClearBox 16 36
line 238
;228:}
;229:
;230:/*
;231:=============
;232:CG_TileClearBox
;233:
;234:This repeats a 64*64 tile graphic to fill the screen around a sized down
;235:refresh window.
;236:=============
;237:*/
;238:static void CG_TileClearBox( int x, int y, int w, int h, qhandle_t hShader ) {
line 241
;239:	float	s1, t1, s2, t2;
;240:
;241:	s1 = x/64.0;
ADDRLP4 0
ADDRFP4 0
INDIRI4
CVIF4 4
CNSTF4 1115684864
DIVF4
ASGNF4
line 242
;242:	t1 = y/64.0;
ADDRLP4 4
ADDRFP4 4
INDIRI4
CVIF4 4
CNSTF4 1115684864
DIVF4
ASGNF4
line 243
;243:	s2 = (x+w)/64.0;
ADDRLP4 8
ADDRFP4 0
INDIRI4
ADDRFP4 8
INDIRI4
ADDI4
CVIF4 4
CNSTF4 1115684864
DIVF4
ASGNF4
line 244
;244:	t2 = (y+h)/64.0;
ADDRLP4 12
ADDRFP4 4
INDIRI4
ADDRFP4 12
INDIRI4
ADDI4
CVIF4 4
CNSTF4 1115684864
DIVF4
ASGNF4
line 245
;245:	trap_R_DrawStretchPic( x, y, w, h, s1, t1, s2, t2, hShader );
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
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 246
;246:}
LABELV $135
endproc CG_TileClearBox 16 36
export CG_TileClear
proc CG_TileClear 48 20
line 257
;247:
;248:
;249:
;250:/*
;251:==============
;252:CG_TileClear
;253:
;254:Clear around a sized down screen
;255:==============
;256:*/
;257:void CG_TileClear( void ) {
line 261
;258:	int		top, bottom, left, right;
;259:	int		w, h;
;260:
;261:	w = cgs.glconfig.vidWidth;
ADDRLP4 8
ADDRGP4 cgs+20100+11304
INDIRI4
ASGNI4
line 262
;262:	h = cgs.glconfig.vidHeight;
ADDRLP4 20
ADDRGP4 cgs+20100+11308
INDIRI4
ASGNI4
line 264
;263:
;264:	if ( cg.refdef.x == 0 && cg.refdef.y == 0 && 
ADDRLP4 24
CNSTI4 0
ASGNI4
ADDRGP4 cg+109044
INDIRI4
ADDRLP4 24
INDIRI4
NEI4 $141
ADDRGP4 cg+109044+4
INDIRI4
ADDRLP4 24
INDIRI4
NEI4 $141
ADDRGP4 cg+109044+8
INDIRI4
ADDRLP4 8
INDIRI4
NEI4 $141
ADDRGP4 cg+109044+12
INDIRI4
ADDRLP4 20
INDIRI4
NEI4 $141
line 265
;265:		cg.refdef.width == w && cg.refdef.height == h ) {
line 266
;266:		return;		// full screen rendering
ADDRGP4 $136
JUMPV
LABELV $141
line 269
;267:	}
;268:
;269:	top = cg.refdef.y;
ADDRLP4 0
ADDRGP4 cg+109044+4
INDIRI4
ASGNI4
line 270
;270:	bottom = top + cg.refdef.height-1;
ADDRLP4 4
ADDRLP4 0
INDIRI4
ADDRGP4 cg+109044+12
INDIRI4
ADDI4
CNSTI4 1
SUBI4
ASGNI4
line 271
;271:	left = cg.refdef.x;
ADDRLP4 12
ADDRGP4 cg+109044
INDIRI4
ASGNI4
line 272
;272:	right = left + cg.refdef.width-1;
ADDRLP4 16
ADDRLP4 12
INDIRI4
ADDRGP4 cg+109044+8
INDIRI4
ADDI4
CNSTI4 1
SUBI4
ASGNI4
line 275
;273:
;274:	// clear above view screen
;275:	CG_TileClearBox( 0, 0, w, top, cgs.media.backTileShader );
ADDRLP4 28
CNSTI4 0
ASGNI4
ADDRLP4 28
INDIRI4
ARGI4
ADDRLP4 28
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 cgs+152340+268
INDIRI4
ARGI4
ADDRGP4 CG_TileClearBox
CALLV
pop
line 278
;276:
;277:	// clear below view screen
;278:	CG_TileClearBox( 0, bottom, w, h - bottom, cgs.media.backTileShader );
CNSTI4 0
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 20
INDIRI4
ADDRLP4 4
INDIRI4
SUBI4
ARGI4
ADDRGP4 cgs+152340+268
INDIRI4
ARGI4
ADDRGP4 CG_TileClearBox
CALLV
pop
line 281
;279:
;280:	// clear left of view screen
;281:	CG_TileClearBox( 0, top, left, bottom - top + 1, cgs.media.backTileShader );
CNSTI4 0
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 cgs+152340+268
INDIRI4
ARGI4
ADDRGP4 CG_TileClearBox
CALLV
pop
line 284
;282:
;283:	// clear right of view screen
;284:	CG_TileClearBox( right, top, w - right, bottom - top + 1, cgs.media.backTileShader );
ADDRLP4 16
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ADDRLP4 16
INDIRI4
SUBI4
ARGI4
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 cgs+152340+268
INDIRI4
ARGI4
ADDRGP4 CG_TileClearBox
CALLV
pop
line 285
;285:}
LABELV $136
endproc CG_TileClear 48 20
bss
align 4
LABELV $166
skip 16
export CG_FadeColor
code
proc CG_FadeColor 8 0
line 294
;286:
;287:
;288:
;289:/*
;290:================
;291:CG_FadeColor
;292:================
;293:*/
;294:float *CG_FadeColor( int startMsec, int totalMsec ) {
line 298
;295:	static vec4_t		color;
;296:	int			t;
;297:
;298:	if ( startMsec == 0 ) {
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $167
line 299
;299:		return NULL;
CNSTP4 0
RETP4
ADDRGP4 $165
JUMPV
LABELV $167
line 302
;300:	}
;301:
;302:	t = cg.time - startMsec;
ADDRLP4 0
ADDRGP4 cg+107604
INDIRI4
ADDRFP4 0
INDIRI4
SUBI4
ASGNI4
line 304
;303:
;304:	if ( t >= totalMsec ) {
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRI4
LTI4 $170
line 305
;305:		return NULL;
CNSTP4 0
RETP4
ADDRGP4 $165
JUMPV
LABELV $170
line 309
;306:	}
;307:
;308:	// fade out
;309:	if ( totalMsec - t < FADE_TIME ) {
ADDRFP4 4
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CNSTI4 200
GEI4 $172
line 310
;310:		color[3] = ( totalMsec - t ) * 1.0/FADE_TIME;
ADDRGP4 $166+12
CNSTF4 1065353216
ADDRFP4 4
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
CVIF4 4
MULF4
CNSTF4 1128792064
DIVF4
ASGNF4
line 311
;311:	} else {
ADDRGP4 $173
JUMPV
LABELV $172
line 312
;312:		color[3] = 1.0;
ADDRGP4 $166+12
CNSTF4 1065353216
ASGNF4
line 313
;313:	}
LABELV $173
line 314
;314:	color[0] = color[1] = color[2] = 1;
ADDRLP4 4
CNSTF4 1065353216
ASGNF4
ADDRGP4 $166+8
ADDRLP4 4
INDIRF4
ASGNF4
ADDRGP4 $166+4
ADDRLP4 4
INDIRF4
ASGNF4
ADDRGP4 $166
ADDRLP4 4
INDIRF4
ASGNF4
line 316
;315:
;316:	return color;
ADDRGP4 $166
RETP4
LABELV $165
endproc CG_FadeColor 8 0
data
align 4
LABELV $179
byte 4 1065353216
byte 4 1045220557
byte 4 1045220557
byte 4 1065353216
align 4
LABELV $180
byte 4 1045220557
byte 4 1045220557
byte 4 1065353216
byte 4 1065353216
align 4
LABELV $181
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
byte 4 1065353216
align 4
LABELV $182
byte 4 1060320051
byte 4 1060320051
byte 4 1060320051
byte 4 1065353216
export CG_TeamColor
code
proc CG_TeamColor 4 0
line 325
;317:}
;318:
;319:
;320:/*
;321:================
;322:CG_TeamColor
;323:================
;324:*/
;325:float *CG_TeamColor( int team ) {
line 331
;326:	static vec4_t	red = {1, 0.2f, 0.2f, 1};
;327:	static vec4_t	blue = {0.2f, 0.2f, 1, 1};
;328:	static vec4_t	other = {1, 1, 1, 1};
;329:	static vec4_t	spectator = {0.7f, 0.7f, 0.7f, 1};
;330:
;331:	switch ( team ) {
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
EQI4 $185
ADDRLP4 0
INDIRI4
CNSTI4 2
EQI4 $186
ADDRLP4 0
INDIRI4
CNSTI4 3
EQI4 $187
ADDRGP4 $183
JUMPV
LABELV $185
line 333
;332:	case TEAM_RED:
;333:		return red;
ADDRGP4 $179
RETP4
ADDRGP4 $178
JUMPV
LABELV $186
line 335
;334:	case TEAM_BLUE:
;335:		return blue;
ADDRGP4 $180
RETP4
ADDRGP4 $178
JUMPV
LABELV $187
line 337
;336:	case TEAM_SPECTATOR:
;337:		return spectator;
ADDRGP4 $182
RETP4
ADDRGP4 $178
JUMPV
LABELV $183
line 339
;338:	default:
;339:		return other;
ADDRGP4 $181
RETP4
LABELV $178
endproc CG_TeamColor 4 0
export CG_GetColorForHealth
proc CG_GetColorForHealth 16 0
line 350
;340:	}
;341:}
;342:
;343:
;344:
;345:/*
;346:=================
;347:CG_GetColorForHealth
;348:=================
;349:*/
;350:void CG_GetColorForHealth( int health, int armor, vec4_t hcolor ) {
line 356
;351:	int		count;
;352:	int		max;
;353:
;354:	// calculate the total points of damage that can
;355:	// be sustained at the current health / armor level
;356:	if ( health <= 0 ) {
ADDRFP4 0
INDIRI4
CNSTI4 0
GTI4 $189
line 357
;357:		VectorClear( hcolor );	// black
ADDRLP4 8
ADDRFP4 8
INDIRP4
ASGNP4
ADDRLP4 12
CNSTF4 0
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 12
INDIRF4
ASGNF4
ADDRLP4 8
INDIRP4
CNSTI4 4
ADDP4
ADDRLP4 12
INDIRF4
ASGNF4
ADDRLP4 8
INDIRP4
ADDRLP4 12
INDIRF4
ASGNF4
line 358
;358:		hcolor[3] = 1;
ADDRFP4 8
INDIRP4
CNSTI4 12
ADDP4
CNSTF4 1065353216
ASGNF4
line 359
;359:		return;
ADDRGP4 $188
JUMPV
LABELV $189
line 361
;360:	}
;361:	count = armor;
ADDRLP4 0
ADDRFP4 4
INDIRI4
ASGNI4
line 362
;362:	max = health * ARMOR_PROTECTION / ( 1.0 - ARMOR_PROTECTION );
ADDRLP4 4
CNSTF4 1059648963
ADDRFP4 0
INDIRI4
CVIF4 4
MULF4
CNSTF4 1051595899
DIVF4
CVFI4 4
ASGNI4
line 363
;363:	if ( max < count ) {
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRI4
GEI4 $191
line 364
;364:		count = max;
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 365
;365:	}
LABELV $191
line 366
;366:	health += count;
ADDRFP4 0
ADDRFP4 0
INDIRI4
ADDRLP4 0
INDIRI4
ADDI4
ASGNI4
line 369
;367:
;368:	// set the color based on health
;369:	hcolor[0] = 1.0;
ADDRFP4 8
INDIRP4
CNSTF4 1065353216
ASGNF4
line 370
;370:	hcolor[3] = 1.0;
ADDRFP4 8
INDIRP4
CNSTI4 12
ADDP4
CNSTF4 1065353216
ASGNF4
line 371
;371:	if ( health >= 100 ) {
ADDRFP4 0
INDIRI4
CNSTI4 100
LTI4 $193
line 372
;372:		hcolor[2] = 1.0;
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
CNSTF4 1065353216
ASGNF4
line 373
;373:	} else if ( health < 66 ) {
ADDRGP4 $194
JUMPV
LABELV $193
ADDRFP4 0
INDIRI4
CNSTI4 66
GEI4 $195
line 374
;374:		hcolor[2] = 0;
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
CNSTF4 0
ASGNF4
line 375
;375:	} else {
ADDRGP4 $196
JUMPV
LABELV $195
line 376
;376:		hcolor[2] = ( health - 66 ) / 33.0;
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
ADDRFP4 0
INDIRI4
CNSTI4 66
SUBI4
CVIF4 4
CNSTF4 1107558400
DIVF4
ASGNF4
line 377
;377:	}
LABELV $196
LABELV $194
line 379
;378:
;379:	if ( health > 60 ) {
ADDRFP4 0
INDIRI4
CNSTI4 60
LEI4 $197
line 380
;380:		hcolor[1] = 1.0;
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
CNSTF4 1065353216
ASGNF4
line 381
;381:	} else if ( health < 30 ) {
ADDRGP4 $198
JUMPV
LABELV $197
ADDRFP4 0
INDIRI4
CNSTI4 30
GEI4 $199
line 382
;382:		hcolor[1] = 0;
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
CNSTF4 0
ASGNF4
line 383
;383:	} else {
ADDRGP4 $200
JUMPV
LABELV $199
line 384
;384:		hcolor[1] = ( health - 30 ) / 30.0;
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
ADDRFP4 0
INDIRI4
CNSTI4 30
SUBI4
CVIF4 4
CNSTF4 1106247680
DIVF4
ASGNF4
line 385
;385:	}
LABELV $200
LABELV $198
line 386
;386:}
LABELV $188
endproc CG_GetColorForHealth 16 0
export CG_ColorForHealth
proc CG_ColorForHealth 0 12
line 393
;387:
;388:/*
;389:=================
;390:CG_ColorForHealth
;391:=================
;392:*/
;393:void CG_ColorForHealth( vec4_t hcolor ) {
line 395
;394:
;395:	CG_GetColorForHealth( cg.snap->ps.stats[STAT_HEALTH], 
ADDRGP4 cg+36
INDIRP4
CNSTI4 228
ADDP4
INDIRI4
ARGI4
ADDRGP4 cg+36
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CG_GetColorForHealth
CALLV
pop
line 397
;396:		cg.snap->ps.stats[STAT_ARMOR], hcolor );
;397:}
LABELV $201
endproc CG_ColorForHealth 0 12
data
align 4
LABELV propMap
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 -1
byte 4 0
byte 4 0
byte 4 8
byte 4 11
byte 4 122
byte 4 7
byte 4 154
byte 4 181
byte 4 14
byte 4 55
byte 4 122
byte 4 17
byte 4 79
byte 4 122
byte 4 18
byte 4 101
byte 4 122
byte 4 23
byte 4 153
byte 4 122
byte 4 18
byte 4 9
byte 4 93
byte 4 7
byte 4 207
byte 4 122
byte 4 8
byte 4 230
byte 4 122
byte 4 9
byte 4 177
byte 4 122
byte 4 18
byte 4 30
byte 4 152
byte 4 18
byte 4 85
byte 4 181
byte 4 7
byte 4 34
byte 4 93
byte 4 11
byte 4 110
byte 4 181
byte 4 6
byte 4 130
byte 4 152
byte 4 14
byte 4 22
byte 4 64
byte 4 17
byte 4 41
byte 4 64
byte 4 12
byte 4 58
byte 4 64
byte 4 17
byte 4 78
byte 4 64
byte 4 18
byte 4 98
byte 4 64
byte 4 19
byte 4 120
byte 4 64
byte 4 18
byte 4 141
byte 4 64
byte 4 18
byte 4 204
byte 4 64
byte 4 16
byte 4 162
byte 4 64
byte 4 17
byte 4 182
byte 4 64
byte 4 18
byte 4 59
byte 4 181
byte 4 7
byte 4 35
byte 4 181
byte 4 7
byte 4 203
byte 4 152
byte 4 14
byte 4 56
byte 4 93
byte 4 14
byte 4 228
byte 4 152
byte 4 14
byte 4 177
byte 4 181
byte 4 18
byte 4 28
byte 4 122
byte 4 22
byte 4 5
byte 4 4
byte 4 18
byte 4 27
byte 4 4
byte 4 18
byte 4 48
byte 4 4
byte 4 18
byte 4 69
byte 4 4
byte 4 17
byte 4 90
byte 4 4
byte 4 13
byte 4 106
byte 4 4
byte 4 13
byte 4 121
byte 4 4
byte 4 18
byte 4 143
byte 4 4
byte 4 17
byte 4 164
byte 4 4
byte 4 8
byte 4 175
byte 4 4
byte 4 16
byte 4 195
byte 4 4
byte 4 18
byte 4 216
byte 4 4
byte 4 12
byte 4 230
byte 4 4
byte 4 23
byte 4 6
byte 4 34
byte 4 18
byte 4 27
byte 4 34
byte 4 18
byte 4 48
byte 4 34
byte 4 18
byte 4 68
byte 4 34
byte 4 18
byte 4 90
byte 4 34
byte 4 17
byte 4 110
byte 4 34
byte 4 18
byte 4 130
byte 4 34
byte 4 14
byte 4 146
byte 4 34
byte 4 18
byte 4 166
byte 4 34
byte 4 19
byte 4 185
byte 4 34
byte 4 29
byte 4 215
byte 4 34
byte 4 18
byte 4 234
byte 4 34
byte 4 18
byte 4 5
byte 4 64
byte 4 14
byte 4 60
byte 4 152
byte 4 7
byte 4 106
byte 4 151
byte 4 13
byte 4 83
byte 4 152
byte 4 7
byte 4 128
byte 4 122
byte 4 17
byte 4 4
byte 4 152
byte 4 21
byte 4 134
byte 4 181
byte 4 5
byte 4 5
byte 4 4
byte 4 18
byte 4 27
byte 4 4
byte 4 18
byte 4 48
byte 4 4
byte 4 18
byte 4 69
byte 4 4
byte 4 17
byte 4 90
byte 4 4
byte 4 13
byte 4 106
byte 4 4
byte 4 13
byte 4 121
byte 4 4
byte 4 18
byte 4 143
byte 4 4
byte 4 17
byte 4 164
byte 4 4
byte 4 8
byte 4 175
byte 4 4
byte 4 16
byte 4 195
byte 4 4
byte 4 18
byte 4 216
byte 4 4
byte 4 12
byte 4 230
byte 4 4
byte 4 23
byte 4 6
byte 4 34
byte 4 18
byte 4 27
byte 4 34
byte 4 18
byte 4 48
byte 4 34
byte 4 18
byte 4 68
byte 4 34
byte 4 18
byte 4 90
byte 4 34
byte 4 17
byte 4 110
byte 4 34
byte 4 18
byte 4 130
byte 4 34
byte 4 14
byte 4 146
byte 4 34
byte 4 18
byte 4 166
byte 4 34
byte 4 19
byte 4 185
byte 4 34
byte 4 29
byte 4 215
byte 4 34
byte 4 18
byte 4 234
byte 4 34
byte 4 18
byte 4 5
byte 4 64
byte 4 14
byte 4 153
byte 4 152
byte 4 13
byte 4 11
byte 4 181
byte 4 5
byte 4 180
byte 4 152
byte 4 13
byte 4 79
byte 4 93
byte 4 17
byte 4 0
byte 4 0
byte 4 -1
align 4
LABELV propMapB
byte 4 11
byte 4 12
byte 4 33
byte 4 49
byte 4 12
byte 4 31
byte 4 85
byte 4 12
byte 4 31
byte 4 120
byte 4 12
byte 4 30
byte 4 156
byte 4 12
byte 4 21
byte 4 183
byte 4 12
byte 4 21
byte 4 207
byte 4 12
byte 4 32
byte 4 13
byte 4 55
byte 4 30
byte 4 49
byte 4 55
byte 4 13
byte 4 66
byte 4 55
byte 4 29
byte 4 101
byte 4 55
byte 4 31
byte 4 135
byte 4 55
byte 4 21
byte 4 158
byte 4 55
byte 4 40
byte 4 204
byte 4 55
byte 4 32
byte 4 12
byte 4 97
byte 4 31
byte 4 48
byte 4 97
byte 4 31
byte 4 82
byte 4 97
byte 4 30
byte 4 118
byte 4 97
byte 4 30
byte 4 153
byte 4 97
byte 4 30
byte 4 185
byte 4 97
byte 4 25
byte 4 213
byte 4 97
byte 4 30
byte 4 11
byte 4 139
byte 4 32
byte 4 42
byte 4 139
byte 4 51
byte 4 93
byte 4 139
byte 4 32
byte 4 126
byte 4 139
byte 4 31
byte 4 158
byte 4 139
byte 4 25
code
proc UI_DrawBannerString2 52 36
line 563
;398:
;399:
;400:
;401:
;402:// bk001205 - code below duplicated in q3_ui/ui-atoms.c
;403:// bk001205 - FIXME: does this belong in ui_shared.c?
;404:// bk001205 - FIXME: HARD_LINKED flags not visible here
;405:#ifndef Q3_STATIC // bk001205 - q_shared defines not visible here 
;406:/*
;407:=================
;408:UI_DrawProportionalString2
;409:=================
;410:*/
;411:static int	propMap[128][3] = {
;412:{0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1},
;413:{0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1},
;414:
;415:{0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1},
;416:{0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1}, {0, 0, -1},
;417:
;418:{0, 0, PROP_SPACE_WIDTH},		// SPACE
;419:{11, 122, 7},	// !
;420:{154, 181, 14},	// "
;421:{55, 122, 17},	// #
;422:{79, 122, 18},	// $
;423:{101, 122, 23},	// %
;424:{153, 122, 18},	// &
;425:{9, 93, 7},		// '
;426:{207, 122, 8},	// (
;427:{230, 122, 9},	// )
;428:{177, 122, 18},	// *
;429:{30, 152, 18},	// +
;430:{85, 181, 7},	// ,
;431:{34, 93, 11},	// -
;432:{110, 181, 6},	// .
;433:{130, 152, 14},	// /
;434:
;435:{22, 64, 17},	// 0
;436:{41, 64, 12},	// 1
;437:{58, 64, 17},	// 2
;438:{78, 64, 18},	// 3
;439:{98, 64, 19},	// 4
;440:{120, 64, 18},	// 5
;441:{141, 64, 18},	// 6
;442:{204, 64, 16},	// 7
;443:{162, 64, 17},	// 8
;444:{182, 64, 18},	// 9
;445:{59, 181, 7},	// :
;446:{35,181, 7},	// ;
;447:{203, 152, 14},	// <
;448:{56, 93, 14},	// =
;449:{228, 152, 14},	// >
;450:{177, 181, 18},	// ?
;451:
;452:{28, 122, 22},	// @
;453:{5, 4, 18},		// A
;454:{27, 4, 18},	// B
;455:{48, 4, 18},	// C
;456:{69, 4, 17},	// D
;457:{90, 4, 13},	// E
;458:{106, 4, 13},	// F
;459:{121, 4, 18},	// G
;460:{143, 4, 17},	// H
;461:{164, 4, 8},	// I
;462:{175, 4, 16},	// J
;463:{195, 4, 18},	// K
;464:{216, 4, 12},	// L
;465:{230, 4, 23},	// M
;466:{6, 34, 18},	// N
;467:{27, 34, 18},	// O
;468:
;469:{48, 34, 18},	// P
;470:{68, 34, 18},	// Q
;471:{90, 34, 17},	// R
;472:{110, 34, 18},	// S
;473:{130, 34, 14},	// T
;474:{146, 34, 18},	// U
;475:{166, 34, 19},	// V
;476:{185, 34, 29},	// W
;477:{215, 34, 18},	// X
;478:{234, 34, 18},	// Y
;479:{5, 64, 14},	// Z
;480:{60, 152, 7},	// [
;481:{106, 151, 13},	// '\'
;482:{83, 152, 7},	// ]
;483:{128, 122, 17},	// ^
;484:{4, 152, 21},	// _
;485:
;486:{134, 181, 5},	// '
;487:{5, 4, 18},		// A
;488:{27, 4, 18},	// B
;489:{48, 4, 18},	// C
;490:{69, 4, 17},	// D
;491:{90, 4, 13},	// E
;492:{106, 4, 13},	// F
;493:{121, 4, 18},	// G
;494:{143, 4, 17},	// H
;495:{164, 4, 8},	// I
;496:{175, 4, 16},	// J
;497:{195, 4, 18},	// K
;498:{216, 4, 12},	// L
;499:{230, 4, 23},	// M
;500:{6, 34, 18},	// N
;501:{27, 34, 18},	// O
;502:
;503:{48, 34, 18},	// P
;504:{68, 34, 18},	// Q
;505:{90, 34, 17},	// R
;506:{110, 34, 18},	// S
;507:{130, 34, 14},	// T
;508:{146, 34, 18},	// U
;509:{166, 34, 19},	// V
;510:{185, 34, 29},	// W
;511:{215, 34, 18},	// X
;512:{234, 34, 18},	// Y
;513:{5, 64, 14},	// Z
;514:{153, 152, 13},	// {
;515:{11, 181, 5},	// |
;516:{180, 152, 13},	// }
;517:{79, 93, 17},	// ~
;518:{0, 0, -1}		// DEL
;519:};
;520:
;521:static int propMapB[26][3] = {
;522:{11, 12, 33},
;523:{49, 12, 31},
;524:{85, 12, 31},
;525:{120, 12, 30},
;526:{156, 12, 21},
;527:{183, 12, 21},
;528:{207, 12, 32},
;529:
;530:{13, 55, 30},
;531:{49, 55, 13},
;532:{66, 55, 29},
;533:{101, 55, 31},
;534:{135, 55, 21},
;535:{158, 55, 40},
;536:{204, 55, 32},
;537:
;538:{12, 97, 31},
;539:{48, 97, 31},
;540:{82, 97, 30},
;541:{118, 97, 30},
;542:{153, 97, 30},
;543:{185, 97, 25},
;544:{213, 97, 30},
;545:
;546:{11, 139, 32},
;547:{42, 139, 51},
;548:{93, 139, 32},
;549:{126, 139, 31},
;550:{158, 139, 25},
;551:};
;552:
;553:#define PROPB_GAP_WIDTH		4
;554:#define PROPB_SPACE_WIDTH	12
;555:#define PROPB_HEIGHT		36
;556:
;557:/*
;558:=================
;559:UI_DrawBannerString
;560:=================
;561:*/
;562:static void UI_DrawBannerString2( int x, int y, const char* str, vec4_t color )
;563:{
line 576
;564:	const char* s;
;565:	unsigned char	ch; // bk001204 : array subscript
;566:	float	ax;
;567:	float	ay;
;568:	float	aw;
;569:	float	ah;
;570:	float	frow;
;571:	float	fcol;
;572:	float	fwidth;
;573:	float	fheight;
;574:
;575:	// draw the colored text
;576:	trap_R_SetColor( color );
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 578
;577:	
;578:	ax = x * cgs.screenXScale + cgs.screenXBias;
ADDRLP4 8
ADDRFP4 0
INDIRI4
CVIF4 4
ADDRGP4 cgs+31432
INDIRF4
MULF4
ADDRGP4 cgs+31440
INDIRF4
ADDF4
ASGNF4
line 579
;579:	ay = y * cgs.screenXScale;
ADDRLP4 36
ADDRFP4 4
INDIRI4
CVIF4 4
ADDRGP4 cgs+31432
INDIRF4
MULF4
ASGNF4
line 581
;580:
;581:	s = str;
ADDRLP4 4
ADDRFP4 8
INDIRP4
ASGNP4
ADDRGP4 $209
JUMPV
LABELV $208
line 583
;582:	while ( *s )
;583:	{
line 584
;584:		ch = *s & 127;
ADDRLP4 0
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 127
BANDI4
CVIU4 4
CVUU1 4
ASGNU1
line 585
;585:		if ( ch == ' ' ) {
ADDRLP4 0
INDIRU1
CVUI4 1
CNSTI4 32
NEI4 $211
line 586
;586:			ax += ((float)PROPB_SPACE_WIDTH + (float)PROPB_GAP_WIDTH)* cgs.screenXScale;
ADDRLP4 8
ADDRLP4 8
INDIRF4
CNSTF4 1098907648
ADDRGP4 cgs+31432
INDIRF4
MULF4
ADDF4
ASGNF4
line 587
;587:		}
ADDRGP4 $212
JUMPV
LABELV $211
line 588
;588:		else if ( ch >= 'A' && ch <= 'Z' ) {
ADDRLP4 40
ADDRLP4 0
INDIRU1
CVUI4 1
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 65
LTI4 $214
ADDRLP4 40
INDIRI4
CNSTI4 90
GTI4 $214
line 589
;589:			ch -= 'A';
ADDRLP4 0
ADDRLP4 0
INDIRU1
CVUI4 1
CNSTI4 65
SUBI4
CVIU4 4
CVUU1 4
ASGNU1
line 590
;590:			fcol = (float)propMapB[ch][0] / 256.0f;
ADDRLP4 20
CNSTI4 12
ADDRLP4 0
INDIRU1
CVUI4 1
MULI4
ADDRGP4 propMapB
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1132462080
DIVF4
ASGNF4
line 591
;591:			frow = (float)propMapB[ch][1] / 256.0f;
ADDRLP4 16
CNSTI4 12
ADDRLP4 0
INDIRU1
CVUI4 1
MULI4
ADDRGP4 propMapB+4
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1132462080
DIVF4
ASGNF4
line 592
;592:			fwidth = (float)propMapB[ch][2] / 256.0f;
ADDRLP4 28
CNSTI4 12
ADDRLP4 0
INDIRU1
CVUI4 1
MULI4
ADDRGP4 propMapB+8
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1132462080
DIVF4
ASGNF4
line 593
;593:			fheight = (float)PROPB_HEIGHT / 256.0f;
ADDRLP4 32
CNSTF4 1041235968
ASGNF4
line 594
;594:			aw = (float)propMapB[ch][2] * cgs.screenXScale;
ADDRLP4 12
CNSTI4 12
ADDRLP4 0
INDIRU1
CVUI4 1
MULI4
ADDRGP4 propMapB+8
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 cgs+31432
INDIRF4
MULF4
ASGNF4
line 595
;595:			ah = (float)PROPB_HEIGHT * cgs.screenXScale;
ADDRLP4 24
CNSTF4 1108344832
ADDRGP4 cgs+31432
INDIRF4
MULF4
ASGNF4
line 596
;596:			trap_R_DrawStretchPic( ax, ay, aw, ah, fcol, frow, fcol+fwidth, frow+fheight, cgs.media.charsetPropB );
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 36
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 20
INDIRF4
ADDRLP4 28
INDIRF4
ADDF4
ARGF4
ADDRLP4 16
INDIRF4
ADDRLP4 32
INDIRF4
ADDF4
ARGF4
ADDRGP4 cgs+152340+12
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 597
;597:			ax += (aw + (float)PROPB_GAP_WIDTH * cgs.screenXScale);
ADDRLP4 8
ADDRLP4 8
INDIRF4
ADDRLP4 12
INDIRF4
CNSTF4 1082130432
ADDRGP4 cgs+31432
INDIRF4
MULF4
ADDF4
ADDF4
ASGNF4
line 598
;598:		}
LABELV $214
LABELV $212
line 599
;599:		s++;
ADDRLP4 4
ADDRLP4 4
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 600
;600:	}
LABELV $209
line 582
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $208
line 602
;601:
;602:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 603
;603:}
LABELV $204
endproc UI_DrawBannerString2 52 36
export UI_DrawBannerString
proc UI_DrawBannerString 44 16
line 605
;604:
;605:void UI_DrawBannerString( int x, int y, const char* str, int style, vec4_t color ) {
line 612
;606:	const char *	s;
;607:	int				ch;
;608:	int				width;
;609:	vec4_t			drawcolor;
;610:
;611:	// find the width of the drawn text
;612:	s = str;
ADDRLP4 4
ADDRFP4 8
INDIRP4
ASGNP4
line 613
;613:	width = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $226
JUMPV
LABELV $225
line 614
;614:	while ( *s ) {
line 615
;615:		ch = *s;
ADDRLP4 0
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
ASGNI4
line 616
;616:		if ( ch == ' ' ) {
ADDRLP4 0
INDIRI4
CNSTI4 32
NEI4 $228
line 617
;617:			width += PROPB_SPACE_WIDTH;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 12
ADDI4
ASGNI4
line 618
;618:		}
ADDRGP4 $229
JUMPV
LABELV $228
line 619
;619:		else if ( ch >= 'A' && ch <= 'Z' ) {
ADDRLP4 0
INDIRI4
CNSTI4 65
LTI4 $230
ADDRLP4 0
INDIRI4
CNSTI4 90
GTI4 $230
line 620
;620:			width += propMapB[ch - 'A'][2] + PROPB_GAP_WIDTH;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 12
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 propMapB-780+8
ADDP4
INDIRI4
CNSTI4 4
ADDI4
ADDI4
ASGNI4
line 621
;621:		}
LABELV $230
LABELV $229
line 622
;622:		s++;
ADDRLP4 4
ADDRLP4 4
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 623
;623:	}
LABELV $226
line 614
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $225
line 624
;624:	width -= PROPB_GAP_WIDTH;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 4
SUBI4
ASGNI4
line 626
;625:
;626:	switch( style & UI_FORMATMASK ) {
ADDRLP4 28
ADDRFP4 12
INDIRI4
CNSTI4 7
BANDI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $235
ADDRLP4 28
INDIRI4
CNSTI4 1
EQI4 $237
ADDRLP4 28
INDIRI4
CNSTI4 2
EQI4 $238
ADDRGP4 $235
JUMPV
LABELV $237
line 628
;627:		case UI_CENTER:
;628:			x -= width / 2;
ADDRFP4 0
ADDRFP4 0
INDIRI4
ADDRLP4 8
INDIRI4
CNSTI4 2
DIVI4
SUBI4
ASGNI4
line 629
;629:			break;
ADDRGP4 $235
JUMPV
LABELV $238
line 632
;630:
;631:		case UI_RIGHT:
;632:			x -= width;
ADDRFP4 0
ADDRFP4 0
INDIRI4
ADDRLP4 8
INDIRI4
SUBI4
ASGNI4
line 633
;633:			break;
line 637
;634:
;635:		case UI_LEFT:
;636:		default:
;637:			break;
LABELV $235
line 640
;638:	}
;639:
;640:	if ( style & UI_DROPSHADOW ) {
ADDRFP4 12
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $240
line 641
;641:		drawcolor[0] = drawcolor[1] = drawcolor[2] = 0;
ADDRLP4 36
CNSTF4 0
ASGNF4
ADDRLP4 12+8
ADDRLP4 36
INDIRF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 36
INDIRF4
ASGNF4
ADDRLP4 12
ADDRLP4 36
INDIRF4
ASGNF4
line 642
;642:		drawcolor[3] = color[3];
ADDRLP4 12+12
ADDRFP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ASGNF4
line 643
;643:		UI_DrawBannerString2( x+2, y+2, str, drawcolor );
ADDRLP4 40
CNSTI4 2
ASGNI4
ADDRFP4 0
INDIRI4
ADDRLP4 40
INDIRI4
ADDI4
ARGI4
ADDRFP4 4
INDIRI4
ADDRLP4 40
INDIRI4
ADDI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 12
ARGP4
ADDRGP4 UI_DrawBannerString2
CALLV
pop
line 644
;644:	}
LABELV $240
line 646
;645:
;646:	UI_DrawBannerString2( x, y, str, color );
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRGP4 UI_DrawBannerString2
CALLV
pop
line 647
;647:}
LABELV $224
endproc UI_DrawBannerString 44 16
export UI_ProportionalStringWidth
proc UI_ProportionalStringWidth 16 0
line 650
;648:
;649:
;650:int UI_ProportionalStringWidth( const char* str ) {
line 656
;651:	const char *	s;
;652:	int				ch;
;653:	int				charWidth;
;654:	int				width;
;655:
;656:	s = str;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
line 657
;657:	width = 0;
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRGP4 $247
JUMPV
LABELV $246
line 658
;658:	while ( *s ) {
line 659
;659:		ch = *s & 127;
ADDRLP4 8
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 127
BANDI4
ASGNI4
line 660
;660:		charWidth = propMap[ch][2];
ADDRLP4 4
CNSTI4 12
ADDRLP4 8
INDIRI4
MULI4
ADDRGP4 propMap+8
ADDP4
INDIRI4
ASGNI4
line 661
;661:		if ( charWidth != -1 ) {
ADDRLP4 4
INDIRI4
CNSTI4 -1
EQI4 $250
line 662
;662:			width += charWidth;
ADDRLP4 12
ADDRLP4 12
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ASGNI4
line 663
;663:			width += PROP_GAP_WIDTH;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 3
ADDI4
ASGNI4
line 664
;664:		}
LABELV $250
line 665
;665:		s++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 666
;666:	}
LABELV $247
line 658
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $246
line 668
;667:
;668:	width -= PROP_GAP_WIDTH;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 3
SUBI4
ASGNI4
line 669
;669:	return width;
ADDRLP4 12
INDIRI4
RETI4
LABELV $245
endproc UI_ProportionalStringWidth 16 0
proc UI_DrawProportionalString2 48 36
line 673
;670:}
;671:
;672:static void UI_DrawProportionalString2( int x, int y, const char* str, vec4_t color, float sizeScale, qhandle_t charset )
;673:{
line 686
;674:	const char* s;
;675:	unsigned char	ch; // bk001204 - unsigned
;676:	float	ax;
;677:	float	ay;
;678:	float	aw;
;679:	float	ah;
;680:	float	frow;
;681:	float	fcol;
;682:	float	fwidth;
;683:	float	fheight;
;684:
;685:	// draw the colored text
;686:	trap_R_SetColor( color );
ADDRFP4 12
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 688
;687:	
;688:	ax = x * cgs.screenXScale + cgs.screenXBias;
ADDRLP4 12
ADDRFP4 0
INDIRI4
CVIF4 4
ADDRGP4 cgs+31432
INDIRF4
MULF4
ADDRGP4 cgs+31440
INDIRF4
ADDF4
ASGNF4
line 689
;689:	ay = y * cgs.screenXScale;
ADDRLP4 36
ADDRFP4 4
INDIRI4
CVIF4 4
ADDRGP4 cgs+31432
INDIRF4
MULF4
ASGNF4
line 691
;690:
;691:	s = str;
ADDRLP4 4
ADDRFP4 8
INDIRP4
ASGNP4
ADDRGP4 $257
JUMPV
LABELV $256
line 693
;692:	while ( *s )
;693:	{
line 694
;694:		ch = *s & 127;
ADDRLP4 0
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 127
BANDI4
CVIU4 4
CVUU1 4
ASGNU1
line 695
;695:		if ( ch == ' ' ) {
ADDRLP4 0
INDIRU1
CVUI4 1
CNSTI4 32
NEI4 $259
line 696
;696:			aw = (float)PROP_SPACE_WIDTH * cgs.screenXScale * sizeScale;
ADDRLP4 8
CNSTF4 1090519040
ADDRGP4 cgs+31432
INDIRF4
MULF4
ADDRFP4 16
INDIRF4
MULF4
ASGNF4
line 697
;697:		} else if ( propMap[ch][2] != -1 ) {
ADDRGP4 $260
JUMPV
LABELV $259
CNSTI4 12
ADDRLP4 0
INDIRU1
CVUI4 1
MULI4
ADDRGP4 propMap+8
ADDP4
INDIRI4
CNSTI4 -1
EQI4 $262
line 698
;698:			fcol = (float)propMap[ch][0] / 256.0f;
ADDRLP4 20
CNSTI4 12
ADDRLP4 0
INDIRU1
CVUI4 1
MULI4
ADDRGP4 propMap
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1132462080
DIVF4
ASGNF4
line 699
;699:			frow = (float)propMap[ch][1] / 256.0f;
ADDRLP4 16
CNSTI4 12
ADDRLP4 0
INDIRU1
CVUI4 1
MULI4
ADDRGP4 propMap+4
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1132462080
DIVF4
ASGNF4
line 700
;700:			fwidth = (float)propMap[ch][2] / 256.0f;
ADDRLP4 28
CNSTI4 12
ADDRLP4 0
INDIRU1
CVUI4 1
MULI4
ADDRGP4 propMap+8
ADDP4
INDIRI4
CVIF4 4
CNSTF4 1132462080
DIVF4
ASGNF4
line 701
;701:			fheight = (float)PROP_HEIGHT / 256.0f;
ADDRLP4 32
CNSTF4 1037565952
ASGNF4
line 702
;702:			aw = (float)propMap[ch][2] * cgs.screenXScale * sizeScale;
ADDRLP4 8
CNSTI4 12
ADDRLP4 0
INDIRU1
CVUI4 1
MULI4
ADDRGP4 propMap+8
ADDP4
INDIRI4
CVIF4 4
ADDRGP4 cgs+31432
INDIRF4
MULF4
ADDRFP4 16
INDIRF4
MULF4
ASGNF4
line 703
;703:			ah = (float)PROP_HEIGHT * cgs.screenXScale * sizeScale;
ADDRLP4 24
CNSTF4 1104674816
ADDRGP4 cgs+31432
INDIRF4
MULF4
ADDRFP4 16
INDIRF4
MULF4
ASGNF4
line 704
;704:			trap_R_DrawStretchPic( ax, ay, aw, ah, fcol, frow, fcol+fwidth, frow+fheight, charset );
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 36
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 20
INDIRF4
ARGF4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 20
INDIRF4
ADDRLP4 28
INDIRF4
ADDF4
ARGF4
ADDRLP4 16
INDIRF4
ADDRLP4 32
INDIRF4
ADDF4
ARGF4
ADDRFP4 20
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 705
;705:		} else {
ADDRGP4 $263
JUMPV
LABELV $262
line 706
;706:			aw = 0;
ADDRLP4 8
CNSTF4 0
ASGNF4
line 707
;707:		}
LABELV $263
LABELV $260
line 709
;708:
;709:		ax += (aw + (float)PROP_GAP_WIDTH * cgs.screenXScale * sizeScale);
ADDRLP4 12
ADDRLP4 12
INDIRF4
ADDRLP4 8
INDIRF4
CNSTF4 1077936128
ADDRGP4 cgs+31432
INDIRF4
MULF4
ADDRFP4 16
INDIRF4
MULF4
ADDF4
ADDF4
ASGNF4
line 710
;710:		s++;
ADDRLP4 4
ADDRLP4 4
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 711
;711:	}
LABELV $257
line 692
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $256
line 713
;712:
;713:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 714
;714:}
LABELV $252
endproc UI_DrawProportionalString2 48 36
export UI_ProportionalSizeScale
proc UI_ProportionalSizeScale 0 0
line 721
;715:
;716:/*
;717:=================
;718:UI_ProportionalSizeScale
;719:=================
;720:*/
;721:float UI_ProportionalSizeScale( int style ) {
line 722
;722:	if(  style & UI_SMALLFONT ) {
ADDRFP4 0
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $272
line 723
;723:		return 0.75;
CNSTF4 1061158912
RETF4
ADDRGP4 $271
JUMPV
LABELV $272
line 726
;724:	}
;725:
;726:	return 1.00;
CNSTF4 1065353216
RETF4
LABELV $271
endproc UI_ProportionalSizeScale 0 0
export UI_DrawProportionalString
proc UI_DrawProportionalString 44 24
line 735
;727:}
;728:
;729:
;730:/*
;731:=================
;732:UI_DrawProportionalString
;733:=================
;734:*/
;735:void UI_DrawProportionalString( int x, int y, const char* str, int style, vec4_t color ) {
line 740
;736:	vec4_t	drawcolor;
;737:	int		width;
;738:	float	sizeScale;
;739:
;740:	sizeScale = UI_ProportionalSizeScale( style );
ADDRFP4 12
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 UI_ProportionalSizeScale
CALLF4
ASGNF4
ADDRLP4 16
ADDRLP4 24
INDIRF4
ASGNF4
line 742
;741:
;742:	switch( style & UI_FORMATMASK ) {
ADDRLP4 28
ADDRFP4 12
INDIRI4
CNSTI4 7
BANDI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $276
ADDRLP4 28
INDIRI4
CNSTI4 1
EQI4 $278
ADDRLP4 28
INDIRI4
CNSTI4 2
EQI4 $279
ADDRGP4 $276
JUMPV
LABELV $278
line 744
;743:		case UI_CENTER:
;744:			width = UI_ProportionalStringWidth( str ) * sizeScale;
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 UI_ProportionalStringWidth
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 36
INDIRI4
CVIF4 4
ADDRLP4 16
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 745
;745:			x -= width / 2;
ADDRFP4 0
ADDRFP4 0
INDIRI4
ADDRLP4 20
INDIRI4
CNSTI4 2
DIVI4
SUBI4
ASGNI4
line 746
;746:			break;
ADDRGP4 $276
JUMPV
LABELV $279
line 749
;747:
;748:		case UI_RIGHT:
;749:			width = UI_ProportionalStringWidth( str ) * sizeScale;
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 UI_ProportionalStringWidth
CALLI4
ASGNI4
ADDRLP4 20
ADDRLP4 40
INDIRI4
CVIF4 4
ADDRLP4 16
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 750
;750:			x -= width;
ADDRFP4 0
ADDRFP4 0
INDIRI4
ADDRLP4 20
INDIRI4
SUBI4
ASGNI4
line 751
;751:			break;
line 755
;752:
;753:		case UI_LEFT:
;754:		default:
;755:			break;
LABELV $276
line 758
;756:	}
;757:
;758:	if ( style & UI_DROPSHADOW ) {
ADDRFP4 12
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $281
line 759
;759:		drawcolor[0] = drawcolor[1] = drawcolor[2] = 0;
ADDRLP4 36
CNSTF4 0
ASGNF4
ADDRLP4 0+8
ADDRLP4 36
INDIRF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 36
INDIRF4
ASGNF4
ADDRLP4 0
ADDRLP4 36
INDIRF4
ASGNF4
line 760
;760:		drawcolor[3] = color[3];
ADDRLP4 0+12
ADDRFP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ASGNF4
line 761
;761:		UI_DrawProportionalString2( x+2, y+2, str, drawcolor, sizeScale, cgs.media.charsetProp );
ADDRLP4 40
CNSTI4 2
ASGNI4
ADDRFP4 0
INDIRI4
ADDRLP4 40
INDIRI4
ADDI4
ARGI4
ADDRFP4 4
INDIRI4
ADDRLP4 40
INDIRI4
ADDI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 16
INDIRF4
ARGF4
ADDRGP4 cgs+152340+4
INDIRI4
ARGI4
ADDRGP4 UI_DrawProportionalString2
CALLV
pop
line 762
;762:	}
LABELV $281
line 764
;763:
;764:	if ( style & UI_INVERSE ) {
ADDRFP4 12
INDIRI4
CNSTI4 8192
BANDI4
CNSTI4 0
EQI4 $288
line 765
;765:		drawcolor[0] = color[0] * 0.8;
ADDRLP4 0
CNSTF4 1061997773
ADDRFP4 16
INDIRP4
INDIRF4
MULF4
ASGNF4
line 766
;766:		drawcolor[1] = color[1] * 0.8;
ADDRLP4 0+4
CNSTF4 1061997773
ADDRFP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
MULF4
ASGNF4
line 767
;767:		drawcolor[2] = color[2] * 0.8;
ADDRLP4 0+8
CNSTF4 1061997773
ADDRFP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
MULF4
ASGNF4
line 768
;768:		drawcolor[3] = color[3];
ADDRLP4 0+12
ADDRFP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ASGNF4
line 769
;769:		UI_DrawProportionalString2( x, y, str, drawcolor, sizeScale, cgs.media.charsetProp );
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 16
INDIRF4
ARGF4
ADDRGP4 cgs+152340+4
INDIRI4
ARGI4
ADDRGP4 UI_DrawProportionalString2
CALLV
pop
line 770
;770:		return;
ADDRGP4 $274
JUMPV
LABELV $288
line 773
;771:	}
;772:
;773:	if ( style & UI_PULSE ) {
ADDRFP4 12
INDIRI4
CNSTI4 16384
BANDI4
CNSTI4 0
EQI4 $295
line 774
;774:		drawcolor[0] = color[0] * 0.8;
ADDRLP4 0
CNSTF4 1061997773
ADDRFP4 16
INDIRP4
INDIRF4
MULF4
ASGNF4
line 775
;775:		drawcolor[1] = color[1] * 0.8;
ADDRLP4 0+4
CNSTF4 1061997773
ADDRFP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
MULF4
ASGNF4
line 776
;776:		drawcolor[2] = color[2] * 0.8;
ADDRLP4 0+8
CNSTF4 1061997773
ADDRFP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
MULF4
ASGNF4
line 777
;777:		drawcolor[3] = color[3];
ADDRLP4 0+12
ADDRFP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ASGNF4
line 778
;778:		UI_DrawProportionalString2( x, y, str, color, sizeScale, cgs.media.charsetProp );
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRLP4 16
INDIRF4
ARGF4
ADDRGP4 cgs+152340+4
INDIRI4
ARGI4
ADDRGP4 UI_DrawProportionalString2
CALLV
pop
line 780
;779:
;780:		drawcolor[0] = color[0];
ADDRLP4 0
ADDRFP4 16
INDIRP4
INDIRF4
ASGNF4
line 781
;781:		drawcolor[1] = color[1];
ADDRLP4 0+4
ADDRFP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
line 782
;782:		drawcolor[2] = color[2];
ADDRLP4 0+8
ADDRFP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ASGNF4
line 783
;783:		drawcolor[3] = 0.5 + 0.5 * sin( cg.time / PULSE_DIVISOR );
ADDRGP4 cg+107604
INDIRI4
CNSTI4 75
DIVI4
CVIF4 4
ARGF4
ADDRLP4 36
ADDRGP4 sin
CALLF4
ASGNF4
ADDRLP4 0+12
CNSTF4 1056964608
ADDRLP4 36
INDIRF4
MULF4
CNSTF4 1056964608
ADDF4
ASGNF4
line 784
;784:		UI_DrawProportionalString2( x, y, str, drawcolor, sizeScale, cgs.media.charsetPropGlow );
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 16
INDIRF4
ARGF4
ADDRGP4 cgs+152340+8
INDIRI4
ARGI4
ADDRGP4 UI_DrawProportionalString2
CALLV
pop
line 785
;785:		return;
ADDRGP4 $274
JUMPV
LABELV $295
line 788
;786:	}
;787:
;788:	UI_DrawProportionalString2( x, y, str, color, sizeScale, cgs.media.charsetProp );
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRLP4 16
INDIRF4
ARGF4
ADDRGP4 cgs+152340+4
INDIRI4
ARGI4
ADDRGP4 UI_DrawProportionalString2
CALLV
pop
line 789
;789:}
LABELV $274
endproc UI_DrawProportionalString 44 24
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
import CG_DrawString
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
