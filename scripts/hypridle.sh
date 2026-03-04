#!/usr/bin/env bash
set -uo pipefail

# =============================================================================
# Config
# =============================================================================
WAYBAR_SIGNAL=9          # Must match Waybar module signal
PROC="hypridle"
TIMEOUT=5                # Seconds

# =============================================================================
# Helpers
# =============================================================================
running() { pgrep -x "$PROC" >/dev/null; }

notify() {
    command -v notify-send >/dev/null || return
    notify-send -u "$1" -t 2000 "$2" "$3" -i "$4"
}

refresh_waybar() {
    pkill -RTMIN+"$WAYBAR_SIGNAL" waybar 2>/dev/null || true
}

# =============================================================================
# Toggle Logic
# =============================================================================
if running; then
    # Disable (Coffee Mode)
    pkill -TERM -x "$PROC" 2>/dev/null || true

    for _ in $(seq 1 $((TIMEOUT * 10))); do
        running || break
        sleep 0.1
    done

    running && pkill -KILL -x "$PROC" 2>/dev/null

    if running; then
        notify critical "Error" "Failed to stop $PROC" dialog-error
        exit 1
    fi

    notify low "Suspend Inhibited" \
        "Coffee Mode On ☕ (Automatic suspend is now OFF)." dialog-warning
else
    # Enable
    command -v "$PROC" >/dev/null || {
        notify critical "Error" "$PROC not found in PATH" dialog-error
        exit 1
    }

    "$PROC" &>/dev/null & disown
    sleep 0.3

    running || {
        notify critical "Error" "Failed to start $PROC" dialog-error
        exit 1
    }

    notify low "Suspend Enabled" \
        "Coffee Mode Off ☕ (Automatic suspend is now ON)." dialog-information
fi

refresh_waybar
exit 0
