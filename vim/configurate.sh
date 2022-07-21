#!/bin/bash

# cat>>~/.zshrc<<EOF
# alias vim='nvim'
# alias vi='nvim'
# alias v='nvim'
# EOF

while true
do
    echo 'which string to replace `nvim`? type `exit` to quit'
    read name
    if [ $name == "exit" ]
    then
    # if [ -z "$name" ]; then
        echo 'exit'
        break
    fi
    echo "alias ${name}='nvim'">>~/.zshrc
done

echo "configurate nvim done"
