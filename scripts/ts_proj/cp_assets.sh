#!/bin/bash

src_dir="src"
dest_dir="dist/src"

find "$src_dir" -type f \( -name "*.svg" -o -name "*.png" -o -name "*.jpg" -o -name "*.mp4" \) |
while read -r file; do
  rel_path="${file#$src_dir/}"

  dest_file="$dest_dir/$rel_path"

  mkdir -p "$(dirname "$dest_file")"

  cp "$file" "$dest_file"

  echo "copy : $file to $dest_file"
done

echo "copy assets done"
