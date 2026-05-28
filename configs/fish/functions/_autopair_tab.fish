function _autopair_tab --description "Jump out of closing pair on tab"
    set --local next (commandline --current-token | string sub --length 1)

    if set --query autopair_right
        contains -- $next $autopair_right
        and commandline -f forward-char
        or commandline -f complete
    else
        commandline -f complete
    end
end
