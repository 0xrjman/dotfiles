#!/bin/bash
# Toggle Neovide — fast yabai-based toggle (same logic as toggle-alacritty.sh)
#
# REQUIRES: manage=on (yabai --space/--focus fail with manage=off)
# Strategy: yabai space movement — fast and no animation.
#           Auto-floats on show to preserve floating-window UX.
#           Uses "is window on current space?" instead of "is app focused?"
#
# KEY INSIGHT: use jq (not python3) for yabai JSON — jq ~2ms vs python ~150ms.
#
# HOTWIN CENTERING: on show, the window is floated AND centered on the current
# display (90% x 95%).  yabai --move/--resize is used instead of osascript
# (~5ms vs ~700ms).  This matches the expected "hotkey window" UX.

APP="neovide"
PROC="neovide"
NEOVIDE_BIN="/Users/rjman/.local/bin/neovide"
LVIM_BIN="/Users/rjman/.local/bin/lvim"

# 1. Not running → launch
if ! pgrep -x "$PROC" >/dev/null 2>&1; then
    nohup "$NEOVIDE_BIN" --frame=transparent --neovim-bin "$LVIM_BIN" --chdir ~/notes >/dev/null 2>&1 &
    # Wait for window to appear, then float + center once
    for i in $(seq 1 10); do
        sleep 0.15
        WIN_ID=$(yabai -m query --windows 2>/dev/null | jq -r ".[] | select(.app == \"$APP\") | .id" | head -1)
        if [ -n "$WIN_ID" ]; then
            # Float it so it doesn't get tiled
            yabai -m window "$WIN_ID" --toggle float 2>/dev/null
            # Center the window (one-shot osascript — only on first launch)
            osascript -e "
tell application \"System Events\"
    set frontmost of process \"$PROC\" to true
    delay 0.1
    tell process \"$PROC\"
        set win to window 1
        set winSize to size of win
        set winPos to position of win
    end tell
end tell
tell application \"Finder\"
    set desktopBounds to bounds of window of desktop
end tell
set screenW to item 3 of desktopBounds
set screenH to item 4 of desktopBounds
set targetW to (screenW * 0.9) as integer
set targetH to (screenH * 0.95) as integer
set posX to (screenW - targetW) div 2
set posY to (screenH - targetH) div 2
tell application \"System Events\"
    tell process \"$PROC\"
        set size of window 1 to {targetW, targetH}
        set position of window 1 to {posX, posY}
    end tell
end tell
" 2>/dev/null &
            break
        fi
    done
    exit 0
fi

# 2. Running → find its window
WIN_ID=$(yabai -m query --windows 2>/dev/null | jq -r ".[] | select(.app == \"$APP\") | .id" | head -1)
CUR_SPACE=$(yabai -m query --spaces --space 2>/dev/null | jq -r '.index')

if [ -z "$WIN_ID" ]; then
    # Window not tracked (shouldn't happen with manage=on)
    osascript -e "tell application \"$APP\" to activate"
    exit 0
fi

# Get the space the window is currently on
WIN_SPACE=$(yabai -m query --windows --window "$WIN_ID" 2>/dev/null | jq -r '.space // 0')

if [ "$WIN_SPACE" = "$CUR_SPACE" ]; then
    # Window is on the current space → HIDE it
    # Pick a stash space well outside the user's normal rotation.
    # User has spaces 1-6; stash to 7 so it never appears when navigating.
    STASH=7
    [ "$CUR_SPACE" = "$STASH" ] && STASH=8
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
