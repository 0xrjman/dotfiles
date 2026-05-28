function _autopair_insert_right --description "Insert closing bracket and skip if already present"
    set --local char $argv[1]
    set --local next (commandline --current-token | string sub --length 1)

    if test "$next" = "$char"
        commandline -f forward-char
    else
        commandline --current-token --replace "$char"(commandline --current-token)
    end
end
