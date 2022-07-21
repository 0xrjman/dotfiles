cur_dir=$(pwd)
pre_dir=$(dirname $cur_dir)
target_dir=$pre_dir/vim/nvim

nvim_dir=~/.config/nvim
nvim_dir_backup=$nvim_dir-backup

if [ -d "$nvim_dir" ]; then
  echo "$nvim_dir exists."
  if [ -d "$nvim_dir_backup" ]; then
    echo "you already have a backup nvim config, please check"
    exit
  else
    echo "your origin config was move to $nvim_dir-backup" 
    mv $nvim_dir $nvim_dir-backup
  fi
fi

echo "set $target_dir as your neovim root dir..."
ln -s $target_dir ~/.config/nvim

echo "done"
