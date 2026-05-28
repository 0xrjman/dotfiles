function _autopair_backspace --description "Remove matching pair when backspacing"
    set --local left (commandline --current-token | string sub --length 1)
    set --local right (commandline --current-token | string sub --start 2 --length 1)

    if set --query autopair_pairs
        for pair in $autopair_pairs
            set --local l (string sub --length 1 $pair)
            set --local r (string sub --start 2 --length 1 $pair)
            if test "$left" = "$l" -a "$right" = "$r"
                commandline --current-token --replace (commandline --current-token | string sub --start 3)
                return 0
            end
        end
    end

    commandline -f backward-delete-char
end
