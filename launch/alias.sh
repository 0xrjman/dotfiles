#!/bin/bash

# cat>>~/.zshrc<<EOF
# alias vim='nvim'
# alias vi='nvim'
# alias v='nvim'
# EOF

echo "which command you want to replace?"
read target
while true
do
    echo "which string to replace ${target}? type exit to quit"
    read name
    if [ $name == "exit" ]
    then
    # if [ -z "$name" ]; then
        echo 'exit'
        break
    fi
    echo "alias ${name}=${target}">>~/.zshrc
done

echo "configurate ${target} done"
