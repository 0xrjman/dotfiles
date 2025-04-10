# Refer to https://github.com/GeorgeKiritsis/Dotfiles

# echo "Installing Dependencies"
# # Packages
# brew install lua
# brew install switchaudio-osx
# brew install nowplaying-cli

# brew tap FelixKratz/formulae
# brew install sketchybar

# # Fonts
# brew install --cask sf-symbols
# brew install --cask homebrew/cask-fonts/font-sf-mono
# brew install --cask homebrew/cask-fonts/font-sf-pro

# curl -L https://github.com/kvndrsslr/sketchybar-app-font/releases/download/v2.0.5/sketchybar-app-font.ttf -o $HOME/Library/Fonts/sketchybar-app-font.ttf

# # SbarLua
# (git clone https://github.com/FelixKratz/SbarLua.git /tmp/SbarLua && cd /tmp/SbarLua/ && make install && rm -rf /tmp/SbarLua/)

echo "Cloning Config"

name="sketchybar"
cur_dir=$(pwd)
pre_dir=$(dirname $cur_dir)
source_dir=$pre_dir/sketchybar
second_source_dir=$pre_dir/dotfiles/launch/configs/sketchybar
target_dir=~/.config/sketchybar
target_backup=$target_dir-backup


if [ ! -e "$source_dir" ]; then
  # echo "$source_dir not exists, try to find it in configs"
  source_dir=$second_source_dir
fi

if [ -e "$source_dir" ]; then
  echo "source $source_dir exists"
  if [ -e "$target_dir" ]; then
    echo "$target_dir exists, try make a backup"
    if [ -e "$target_backup" ]; then
      echo "you already have a backup $name config => $target_backup, please check it."
      exit
    else
      echo "your origin config was move to $target_backup"
      mv $target_dir $target_backup
    fi
  fi
else
  echo "source $source_dir not exists, please check"
  exit
fi

echo "set $source_dir => $target_dir as your $name root dir..."
ln -s $source_dir $target_dir

echo "^()^ done"

brew services restart sketchybar
