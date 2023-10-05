export PATH="/home/rjman/.local/bin:$PATH"

function switch_gcc
  sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-12 100 --slave /usr/bin/g++ g++ /usr/bin/g++-12 --slave /usr/bin/gcov gcov /usr/bin/gcov-12
  sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-10 70 --slave /usr/bin/g++ g++ /usr/bin/g++-10 --slave /usr/bin/gcov gcov /usr/bin/gcov-10
  sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 50 --slave /usr/bin/g++ g++ /usr/bin/g++-8 --slave /usr/bin/gcov gcov /usr/bin/gcov-8
  sudo update-alternatives --config gcc
end

function git_proxy_on
  git config --global http.proxy http://127.0.0.1:7890
  git config --global https.proxy https://127.0.0.1:7890
  echo -e "set git proxy port 7890"
end

function git_proxy_off
  git config --global --unset http.proxy
  git config --global --unset https.proxy
  echo -e "unset git proxy"
end

function proxy_on
        export no_proxy="localhost,127.0.0.1,localaddress,.localdomain.com"
        export http_proxy="http://127.0.0.1:7890"
        export https_proxy=$http_proxy
        export ftp_proxy=$http_proxy
        export rsync_proxy=$http_proxy
        export HTTP_PROXY=$http_proxy
        export HTTPS_PROXY=$http_proxy
        export FTP_PROXY=$http_proxy
        export RSYNC_PROXY=$http_proxy
        git_proxy_on
        echo -e "已开启代理"
        curl cip.cc
end

function proxy_off
        set --erase http_proxy
        set --erase https_proxy
        set --erase ftp_proxy
        set --erase rsync_proxy
        git_proxy_off
        echo -e "已关闭代理"
        # curl cip.cc
end

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /home/rjman/miniconda3/bin/conda
    eval /home/rjman/miniconda3/bin/conda "shell.fish" "hook" $argv | source
end
# <<< conda initialize <<<

function ryan
	conda activate ryan
end

function ryanet
	conda activate ryanet
end

function dcn
	conda activate dcn
end

function edter
	conda activate edter
end

function internimage
	conda activate internimage
end

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

# export FZF_DEFAULT_OPTS='--height 60% --layout=reverse --border --cycle --preview-window=wrap --marker="*"'
# fzf_configure_bindings --directory=\cF  \
#                        --history=\cR    \
#                        --git_log=\cL    \
#                        --processe=\cY   \
#                        --git_status=\cI \
#                        --variables=\cV
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

thefuck --alias | source

set -U fish_key_bindings fish_vi_key_bindings

# pnpm
set -gx PNPM_HOME "/home/rjman/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# cuda
set -gx CUDA_HOME "/usr/local/cuda"
set -gx CUDA_HOME_PATH "/usr/local/cuda/bin"
if not string match -q -- $CUDA_HOME_PATH $PATH
  set -gx PATH "$CUDA_HOME_PATH" $PATH
  set -gx LD_LIBRARY_PATH "/usr/local/cuda/lib64" $LD_LIBRARY_PATH
end
# cuda end

function switch_cuda_10_1
  sudo rm /usr/local/cuda
  sudo ln -s /usr/local/cuda-10.1 /usr/local/cuda
end

function switch_cuda_11_7
  sudo rm /usr/local/cuda
  sudo ln -s /usr/local/cuda-11.7 /usr/local/cuda
end

function switch_cuda_12_2
  sudo rm /usr/local/cuda
  sudo ln -s /usr/local/cuda-12.2 /usr/local/cuda
end
