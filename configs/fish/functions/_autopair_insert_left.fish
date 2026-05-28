function _autopair_insert_left --description "Insert opening bracket with matching closing bracket"
    set --local left $argv[1]
    set --local right $argv[2]
    commandline --current-token --replace "$left$right"(commandline --current-token)
    commandline -f backward-char
end
