/*
===========================================================================
Copyright (C) 1999-2005 Id Software, Inc.

This file is part of Quake III Arena source code.

Quake III Arena source code is free software; you can redistribute it
and/or modify it under the terms of the GNU General Public License as
published by the Free Software Foundation; either version 2 of the License,
or (at your option) any later version.

Quake III Arena source code is distributed in the hope that it will be
useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Foobar; if not, write to the Free Software
Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
===========================================================================
*/
#include "../client/client.h"
#include "../qcommon/qcommon.h"
#include "win_local.h"

/*
========================================================================

EVENT LOOP

========================================================================
*/

#define	MAX_QUED_EVENTS		256
#define	MASK_QUED_EVENTS	( MAX_QUED_EVENTS - 1 )

static sysEvent_t	eventQue[MAX_QUED_EVENTS];
static int			eventHead;	// 次のイベントを入れる位置(一番新しいイベントの次の位置)
static int			eventTail;	// 次にイベントを取り出す位置(一番古いイベントの位置)
static byte		sys_packetReceived[MAX_MSGLEN];

/*
================
Sys_QueEvent

A time of 0 will get the current time
Ptr should either be null, or point to a block of data that can
be freed by the game later.
================
*/
void Sys_QueEvent( int time, sysEventType_t type, int value, int value2, int ptrLength, void *ptr ) {
	sysEvent_t	*ev;

	ev = &eventQue[ eventHead & MASK_QUED_EVENTS ];
	if ( eventHead - eventTail >= MAX_QUED_EVENTS ) {
		// イベントキューが一杯(256個)の場合、一番古いイベントを捨ててしまう。
		Com_Printf("Sys_QueEvent: overflow\n");
		// we are discarding an event, but don't leak memory
		if ( ev->evPtr ) {
			Z_Free( ev->evPtr );
		}
		eventTail++;
	}

	eventHead++;

	ev->evTime = (time == 0) ? Sys_Milliseconds() : time;	// このメンバーにセットされるのはtimeであればWindows起動からの経過時間、Sys_Milliseconds()であればゲーム起動からの経過時間…
	ev->evType = type;
	ev->evValue = value;
	ev->evValue2 = value2;
	ev->evPtrLength = ptrLength;
	ev->evPtr = ptr;
}

/*
================
Sys_GetEvent
マウス、ジョイスティックなどのQ3A独自のイベントキュー、Windowsのイベントキュー、コンソールに入力されたコマンド、通信パケットをチェックし、
一つのイベントだけを返す。
================
*/
sysEvent_t Sys_GetEvent( void ) {
    MSG			msg;
	sysEvent_t	ev;
	char		*s;
	msg_t		netmsg;
	netadr_t	adr;

	// return if we have data
	if (eventHead > eventTail) {
		eventTail++;
		return eventQue[(eventTail - 1) & MASK_QUED_EVENTS];
	}

	// pump the message loop
	while (PeekMessage (&msg, NULL, 0, 0, PM_NOREMOVE)) {
		if (!GetMessage (&msg, NULL, 0, 0)) {
			Com_Quit_f();	// 非常事態で、アプリケーションを終わらせてしまうらしい。(Com_は、Command等ではなく、Commonの略らしい。)
		}

		// save the msg time, because wndprocs don't have access to the timestamp
		g_wv.sysMsgTime = msg.time;	// システム起動からの経過時間(単位ms)

		TranslateMessage(&msg);
      	DispatchMessage(&msg);
	}

	// check for console commands
	s = Sys_ConsoleInput();
	if (s) {
		char *b;
		int len;

		len = strlen(s) + 1;
		b = Z_Malloc(len);
		Q_strncpyz(b, s, len - 1);
		Sys_QueEvent(0, SE_CONSOLE, 0, 0, len, b);
	}

	// check for network packets
	MSG_Init(&netmsg, sys_packetReceived, sizeof(sys_packetReceived));
	if (Sys_GetPacket(&adr, &netmsg)) {
		netadr_t *buf;
		int len;

		// copy out to a seperate buffer for qeueing
		// the readcount stepahead is for SOCKS support
		len = sizeof(netadr_t) + netmsg.cursize - netmsg.readcount;
		buf = Z_Malloc(len);
		*buf = adr;
		memcpy(buf + 1, &netmsg.data[netmsg.readcount], netmsg.cursize - netmsg.readcount);
		Sys_QueEvent(0, SE_PACKET, 0, 0, len, buf);
	}

	// return if we have data
	if (eventHead > eventTail) {
		eventTail++;
		return eventQue[(eventTail - 1) & MASK_QUED_EVENTS];
	}

	// create an empty event to return
	memset(&ev, 0, sizeof(ev));
	ev.evTime = timeGetTime();	// Windows起動からの経過時間(ms単位)

	return ev;
}
