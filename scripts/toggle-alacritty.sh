#!/bin/bash
# Toggle Alacritty — fast yabai-based toggle
#
# REQUIRES: manage=on (yabai --space/--focus fail with manage=off)
# Strategy: yabai space movement — fast and no animation.
#           Auto-floats on show to preserve floating-terminal UX.
#           Uses "is window on current space?" instead of "is app focused?"
#           so toggle works regardless of which window is focused.
#
# CRITICAL: pgrep uses LOWERCASE ("alacritty"), not app name ("Alacritty").
#
# HOTWIN CENTERING: on show, the window is floated AND centered on the current
# display (90% x 95%).  yabai --move/--resize is used instead of osascript
# (~5ms vs ~700ms).

APP="Alacritty"        # macOS app name (for yabai queries)
PROC="alacritty"       # process name (LOWERCASE for pgrep — pit #17)

# 1. Not running → launch
if ! pgrep -x "$PROC" >/dev/null 2>&1; then
    open -a "$APP"
    exit 0
fi

# 2. Running → find its window
WIN_ID=$(yabai -m query --windows 2>/dev/null | jq -r ".[] | select(.app == \"$APP\") | .id" | head -1)
CUR_SPACE=$(yabai -m query --spaces --space 2>/dev/null | jq -r '.index')

if [ -z "$WIN_ID" ]; then
    # Window not tracked by yabai (shouldn't happen with manage=on)
    # Fallback: activate via osascript
    osascript -e "tell application \"$APP\" to activate"
    exit 0
fi

# Get the space the window is currently on
WIN_SPACE=$(yabai -m query --windows --window "$WIN_ID" 2>/dev/null | jq -r '.space // 0')

if [ "$WIN_SPACE" = "$CUR_SPACE" ]; then
    # Window is on the current space → HIDE it
    # Pick a stash space != current space (use space 1, or 2 if on space 1)
    STASH=1
    [ "$CUR_SPACE" = "1" ] && STASH=2
    yabai -m window "$WIN_ID" --space "$STASH"
else
    # Window is hidden on another space → SHOW it (hotwin-style: float + center)
    yabai -m window "$WIN_ID" --space "$CUR_SPACE"
    sleep 0.1
    # Ensure float: yabai preserves float state across space moves, so the
    # window stays floating. But if it somehow got un-floated, toggle it.
    IS_FLOAT=$(yabai -m query --windows --window "$WIN_ID" 2>/dev/null | jq -r '."is-floating"')
    if [ "$IS_FLOAT" = "false" ]; then
        yabai -m window "$WIN_ID" --toggle float 2>/dev/null
        sleep 0.05
    fi
    # Center the window on the current display (80% x 85% of screen)
    # CRITICAL: yabai returns floats like 1512.0000 — strip .* for bash math
    DISPLAY=$(yabai -m query --windows --window "$WIN_ID" 2>/dev/null | jq -r '.display')
    DW=$(yabai -m query --displays --display "$DISPLAY" 2>/dev/null | jq -r '.frame.w'); DW=${DW%.*}
    DH=$(yabai -m query --displays --display "$DISPLAY" 2>/dev/null | jq -r '.frame.h'); DH=${DH%.*}
    WW=$(( DW * 90 / 100 ))
    WH=$(( DH * 95 / 100 ))
    WX=$(( (DW - WW) / 2 ))
    WY=$(( (DH - WH) / 2 ))
    yabai -m window "$WIN_ID" --move abs:$WX:$WY
    yabai -m window "$WIN_ID" --resize abs:$WW:$WH
    yabai -m window --focus "$WIN_ID"
fi
