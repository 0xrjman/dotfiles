name="alacritty.yml"
cur_dir=$(pwd)
pre_dir=$(dirname $cur_dir)
source_dir=$pre_dir/alacritty
second_source_dir=$pre_dir/dotfiles/launch/configs/alacritty
target_dir=~/.config/alacritty
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

echo "System: $(uname)"
if [ "$(uname)" == "Darwin" ]; then
  echo "set $source_dir/alacritty-darwin.yml => $target_dir/alacritty.yml as your $name config..."
  ln -s $source_dir/alacritty-darwin.yml $source_dir/alacritty.yml
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
  echo "set $source_dir/alacritty-linux.yml => $target_dir/alacritty.yml as your $name config..."
  ln -s $source_dir/alacritty-linux.yml $source_dir/alacritty.yml
else
  echo "Your platform ($(uname -a)) is not supported."
  exit
fi

echo "set $source_dir => $target_dir as your $name root dir..."
ln -s $source_dir $target_dir

echo "^()^ done"
