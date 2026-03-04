#!/usr/bin/env bash

STATE_FILE="/tmp/wvkbd.state"

if [ -f "$STATE_FILE" ]; then
    pkill -x wvkbd-deskintl
    rm -f "$STATE_FILE"
else
    setsid wvkbd-deskintl >/dev/null 2>&1 &
    touch "$STATE_FILE"
fi
