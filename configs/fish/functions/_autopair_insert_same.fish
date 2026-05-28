function _autopair_insert_same --description "Insert symmetric pairs like quotes"
    set --local char $argv[1]
    set --local next (commandline --current-token | string sub --length 1)

    if test "$next" = "$char"
        commandline -f forward-char
    else
        commandline --current-token --replace "$char$char"(commandline --current-token)
        commandline -f backward-char
    end
end
