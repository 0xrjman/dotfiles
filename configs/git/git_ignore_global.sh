target_dir=~/.gitignore_global

if [ -d "$target_dir" ]; then
    echo "$target_dir exists."
else
    ln -s $PWD/configs/git/.gitignore_global $target_dir
fi

git config --global core.excludesfile ~/.gitignore_global

echo "config git_global_core.excludesfile done"