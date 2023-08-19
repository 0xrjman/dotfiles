#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title neovide
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🤖
# @raycast.packageName dev

# Documentation:
# @raycast.description open neovide in tranparent mode
# @raycast.author rjman
# @raycast.authorURL https://raycast.com/rjman

# echo "Hello World!"

APP_NAME="Neovide"
# FRAME_ARG="--frame=transparent"
FRAME_ARG="--frame=none"

if pgrep -f "$APP_NAME" >/dev/null
then
	open /Applications/Neovide.app
else
  export NVIM_APPNAME="${NVIM_APPNAME:-"lvim"}"
  export LUNARVIM_RUNTIME_DIR="${LUNARVIM_RUNTIME_DIR:-"$HOME/.local/share/lunarvim"}"
  export LUNARVIM_CONFIG_DIR="${LUNARVIM_CONFIG_DIR:-"$HOME/.config/lvim"}"
  export LUNARVIM_CACHE_DIR="${LUNARVIM_CACHE_DIR:-"$HOME/.cache/lvim"}"
  export LUNARVIM_BASE_DIR="${LUNARVIM_BASE_DIR:-"$HOME/.local/share/lunarvim/lvim"}"
	cd $HOME
	exec /Applications/Neovide.app/Contents/MacOS/neovide $FRAME_ARG -- -u "$LUNARVIM_RUNTIME_DIR/lvim/init.lua" "$@"
fi

# exec -a "$NVIM_APPNAME" nvim -u "$LUNARVIM_BASE_DIR/init.lua" "$@"

# if pgrep -xq "$APP_NAME"; then
    # echo "Neovide is running"
#    osascript -e 'tell application "'"$APP_NAME"'" to set collapsed of windows to true'
# else
#    open -a "$APP_NAME" --args "$FRAME_ARG" -- -u "$LUNARVIM_BASE_DIR/init.lua" "$@"
# fi
