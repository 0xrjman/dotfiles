#!/bin/bash

find src/ -type f \( -name "*.ts" -o -name "*.tsx" \) | while read file; do
    depth=$(echo "$file" | tr -cd '/' | wc -c)

    if [ $depth -eq 1 ]; then
        prefix="./"
    else
        prefix=$(printf '../%.0s' $(seq 1 $(($depth - 2))))
    fi

    sed -i '' "s|@/|$prefix|g" "$file"
done
