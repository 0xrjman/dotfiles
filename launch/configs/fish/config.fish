if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias ls "exa"
alias ll "exa -alh"
# printf '\eP$f{"hook": "SourcedRcFileForWarp", "value": { "shell": "fish" }}\x9c'

function fuck -d "Correct your previous console command"
  set -l fucked_up_command $history[1]
  env TF_SHELL=fish TF_ALIAS=fuck PYTHONIOENCODING=utf-8 thefuck $fucked_up_command THEFUCK_ARGUMENT_PLACEHOLDER $argv | read -l unfucked_command
  if [ "$unfucked_command" != "" ]
    eval $unfucked_command
    builtin history delete --exact --case-sensitive -- $fucked_up_command
    builtin history merge
  end
end

export FZF_DEFAULT_OPTS='--height 60% --layout=reverse --border --cycle --preview-window=wrap --marker="*"'

fzf_configure_bindings --directory=\cF  \
                       --history=\cR    \
                       --git_log=\cL    \
                       --processe=\cY   \
                       --git_status=\cI \
                       --variables=\cV

# export PATH="$PATH:/Users/rjman/.bin"
# export PATH="$PATH:/Users/rjman/.foundry/bin"
# export PATH="$PATH:/opt/homebrew/anaconda3/bin"
# export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-11.jdk/Contents/Home
# export PNPM_HOME="/Users/rjman/Library/pnpm"
# export PATH="$PNPM_HOME:$PATH"
# export PATH=$HOME/Applications/bin:$PATH
# export PATH=$PATH:$(go env GOPATH)/bin
# export PATH=$PATH:$HOME/.local/bin
# export NVM_DIR="$HOME/.nvm"
# export AI_RESOURCES="/Users/rjman/Workspace/AI/resources"
# source $(brew --prefix nvm)/nvm.sh


# echo
# fortune
# echo

# function conda_on
#     # >>> conda initialize >>>
#     # !! Contents within this block are managed by 'conda init' !!
#     set __conda_setup ("/opt/homebrew/anaconda3/bin/conda" "shell.fish" "hook" ^/dev/null)
#     if test $status -eq 0
#         eval "$__conda_setup"
#     else if test -f "/opt/homebrew/anaconda3/etc/fish/conf.d/conda.fish"
#         # source "/opt/homebrew/anaconda3/etc/fish/conf.d/conda.fish"  # commented out by conda initialize
#     else
#         # set -gx PATH "/opt/homebrew/anaconda3/bin" $PATH  # commented out by conda initialize
#     end
#     end
#     set -e __conda_setup
#     # <<< conda initialize <<<
# end

# function conda_off
#     conda deactivate
# end

thefuck --alias | source
