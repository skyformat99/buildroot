#!/bin/sh

if [ "$#" != 2 ]; then
	echo "usage: $0 ALARM VALUE" >&2
	exit 1
fi

VOLHI=92
VOLLO=80

if [ -f /root/config ]; then
	. /root/config
fi

ALARM="$1"
VALUE="$2"
shift
shift

case "$ALARM:$VALUE" in
sleeptimer:1)
	mpc volume $VOLLO
	mplay 100 playlist "$ALARM"
	;;
*:1)
	mpc -q repeat off
	mpc -q consume on
	mpc -q volume $VOLHI

	mplay 100 playlist "$ALARM"
	;;
*:0|*:snoozed)
	mpc -q pause
	;;
esac

