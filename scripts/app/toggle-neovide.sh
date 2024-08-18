#!/bin/bash

# Properly assign the output to hotkey_window_id. Use command substitution $() and quotes.
hotkey_window_id=$(yabai -m query --windows | jq -r 'map(select(.app == "Neovide" and ."is-floating" == true)) | .[0].id')
FRAME_ARG="--frame=none"
WAIT_TIME=0.5

# Check if hotkey_window_id is null or an empty string.
if [ "$hotkey_window_id" == "null" ] || [ -z "$hotkey_window_id" ]; then
  # Open Neovide if it is not open
  export NVIM_APPNAME="${NVIM_APPNAME:-"lvim"}"
  export LUNARVIM_RUNTIME_DIR="${LUNARVIM_RUNTIME_DIR:-"$HOME/.local/share/lunarvim"}"
  export LUNARVIM_CONFIG_DIR="${LUNARVIM_CONFIG_DIR:-"$HOME/.config/lvim"}"
  export LUNARVIM_CACHE_DIR="${LUNARVIM_CACHE_DIR:-"$HOME/.cache/lvim"}"
  export LUNARVIM_BASE_DIR="${LUNARVIM_BASE_DIR:-"$HOME/.local/share/lunarvim/lvim"}"
	# cd $HOME
	open -na Neovide --args $FRAME_ARG -- -u "$LUNARVIM_RUNTIME_DIR/lvim/init.lua" "$@"
  # open -na Neovide --args $FRAME_ARG -u "$LUNARVIM_RUNTIME_DIR/lvim/init.lua"
	# exec /Applications/Neovide.app/Contents/MacOS/neovide $FRAME_ARG -- -u "$LUNARVIM_RUNTIME_DIR/lvim/init.lua" "$@"
  # give system some time to open the window
	sleep $WAIT_TIME

  # current_hotkey_window_id=$(yabai -m query --windows | jq -r 'map(select(.app == "Neovide" and ."is-floating" == false)) | .[0].id')
	yabai -m window --toggle float --grid 40:40:1:1:38:38 --opacity 0.8
else
	# Check if the window is not hidden
	is_hidden=$(yabai -m query --windows --window "$hotkey_window_id" | jq -r '."is-hidden"')
	has_focus=$(yabai -m query --windows --window "$hotkey_window_id" | jq -r '."has-focus"')
	if [ "$is_hidden" == false ] && [ "$has_focus" == true ]; then
		skhd -k "cmd -h"
	else
		current_space_id=$(yabai -m query --spaces --space | jq -r '.index')
		# Show and focus the window
		yabai -m window "$hotkey_window_id" --space $current_space_id
		yabai -m window "$hotkey_window_id" --focus
	fi
fi
