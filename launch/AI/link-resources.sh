#!/bin/bash
link_dir=~/Documents/AI/resources

while true
do
  echo "which dirname you want to set?"
  read folder
  # echo "Input dirname is $folder"
  if [ ! -d "${folder}" ]; then
    # conflict: mkdir && ln -s
    # mkdir "$folder"
    # echo "mkdir ${folder} done"
    echo "create link file: $PWD/$folder => $PWD/$link_dir"
    # ln -s "$link_dir" "$PWD/$folder"
    ln -s $link_dir $PWD/$folder
    echo "link to $PWD/$folder"
    echo "list items:"
    ls $PWD/$folder
    break
  else
    echo "dirname ${folder} exist, please change a name."
  fi
done

