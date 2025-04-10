#!/usr/bin/env bash
# filepath: /Users/rjman/Workspace/Tool/dotfiles/launch/common_init.sh.en

set -euo pipefail

if [ "$#" -lt 2 ]; then
  echo "Usage: $0 <config_name> <config_file_name> [target_directory] [needs_os_specific_config]"
  echo "Example: $0 btop btop.conf"
  echo "Example: $0 alacritty alacritty.yml ~/.config/alacritty true"
  exit 1
fi

name="$1"
config_name="$2"
target_dir="${3:-$HOME/.config/$name}"
os_specific="${4:-false}"

script_dir=$(dirname "$(realpath "$0")")
config_dir="$script_dir/configs/$name"
target_backup="${target_dir}-backup"

echo "Initializing $name configuration..."

if [[ ! -d "$config_dir" ]]; then
  echo "❌! Error: Configuration directory $config_dir does not exist, please check"
  exit 1
fi

echo "Configuration source directory $config_dir exists"

if [[ -e "$target_dir" ]]; then
  echo "$target_dir already exists, attempting to create backup"
  if [[ -e "$target_backup" ]]; then
    echo "❌! Error: You already have a backup configuration at $target_backup, please check"
    exit 1
  else
    echo "Your original configuration has been moved to $target_backup"
    mv "$target_dir" "$target_backup"
  fi
fi

if [[ "$os_specific" == "true" ]]; then
  echo "System: $(uname)"
  os_type="$(uname)"
  case "$os_type" in
  "Darwin")
    echo "Setting $config_dir/${name}-darwin.yml as your $name configuration..."
    ln -sf "$config_dir/${name}-darwin.yml" "$config_dir/${name}.yml"
    ;;
  "Linux")
    echo "Setting $config_dir/${name}-linux.yml as your $name configuration..."
    ln -sf "$config_dir/${name}-linux.yml" "$config_dir/${name}.yml"
    ;;
  *)
    echo "❌! Error: Your platform ($os_type) is not supported."
    exit 1
    ;;
  esac
fi

mkdir -p "$(dirname "$target_dir")"

echo "Setting $config_dir => $target_dir as your $name root directory..."
ln -sf "$config_dir" "$target_dir"

echo "^_^ Done! ✅"
