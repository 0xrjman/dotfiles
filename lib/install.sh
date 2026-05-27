#!/usr/bin/env bash
#
# Generic dotfiles installer — supports file symlinks and directory symlinks.
#
# Usage:
#   ./lib/install.sh <name> <source_rel> <target_path> [os_specific] [post_cmd]
#
# Arguments:
#   name         Config name (e.g., "zsh", "alacritty") — maps to configs/<name>/
#   source_rel   Relative path inside configs/<name>/ to symlink.
#                Use "." to symlink the entire config directory.
#                Use a filename (e.g., ".zshrc") to symlink a single file.
#   target_path  Absolute path where the symlink should be created.
#   os_specific  Optional. "true" = enable OS-specific config (alacritty).
#   post_cmd     Optional. Shell command to run after successful install.
#
# Examples:
#   ./lib/install.sh zsh .zshrc ~/.zshrc                         # file mode
#   ./lib/install.sh alacritty . ~/.config/alacritty true        # dir mode + OS
#   ./lib/install.sh sketchybar . ~/.config/sketchybar "" "brew services restart sketchybar"

set -euo pipefail

if [ "$#" -lt 3 ]; then
  echo "Usage: $0 <name> <source_rel> <target_path> [os_specific] [post_cmd]"
  echo ""
  echo "Examples:"
  echo "  $0 zsh .zshrc ~/.zshrc                        # file mode"
  echo "  $0 alacritty . ~/.config/alacritty true       # dir mode + OS"
  echo "  $0 sketchybar . ~/.config/sketchybar '' 'brew services restart sketchybar'"
  exit 1
fi

name="$1"
source_rel="$2"
target_path="$3"
os_specific="${4:-false}"
post_cmd="${5:-}"

script_dir="$(cd "$(dirname "$0")" && pwd)"
config_dir="$(cd "$script_dir/../configs/$name" && pwd 2>/dev/null)" || {
  echo "Error: Configuration directory configs/$name does not exist"
  exit 1
}

target_backup="${target_path}-backup"

echo "==> Installing $name configuration..."

# ---- OS-specific config resolution (alacritty) ----
if [[ "$os_specific" == "true" ]]; then
  os_type="$(uname)"
  case "$os_type" in
    "Darwin")
      echo "    System: macOS — using ${name}-darwin.yml"
      ln -sf "$config_dir/${name}-darwin.yml" "$config_dir/${name}.yml"
      ;;
    "Linux")
      echo "    System: Linux — using ${name}-linux.yml"
      ln -sf "$config_dir/${name}-linux.yml" "$config_dir/${name}.yml"
      ;;
    *)
      echo "Error: Unsupported platform ($os_type)"
      exit 1
      ;;
  esac
fi

# ---- Resolve source ----
if [[ "$source_rel" == "." ]]; then
  # Directory mode: symlink the entire config directory
  source_path="$config_dir"
else
  # File mode: symlink a specific file from the config directory
  source_path="$config_dir/$source_rel"
  if [[ ! -f "$source_path" ]]; then
    echo "Error: Source file '$source_path' does not exist"
    exit 1
  fi
fi

# ---- Backup existing target ----
if [[ -e "$target_path" ]]; then
  echo "    $target_path already exists, creating backup..."
  if [[ -e "$target_backup" ]]; then
    echo "Error: Backup already exists at $target_backup — please check manually"
    exit 1
  fi
  mv "$target_path" "$target_backup"
  echo "    Original moved to $target_backup"
fi

# ---- Create parent directory and symlink ----
mkdir -p "$(dirname "$target_path")"
ln -sf "$source_path" "$target_path"
echo "    Linked: $source_path → $target_path"

# ---- Post-install hook ----
if [[ -n "$post_cmd" ]]; then
  echo "    Running post-install: $post_cmd"
  eval "$post_cmd"
fi

echo "==> Done."
