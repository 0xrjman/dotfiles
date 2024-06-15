# >>> ===================================== <<<
# >>>  0xrjman fish config for Mac and Linux  <<<
# >>> ===================================== <<<

# >>> ===================================== <<<
# >>> ========== 0. General Start ========= <<<
# >>> ===================================== <<<
set -gx FISH_HOME /bin/fish
set -x PATH $PATH $HOME/.local/bin
set -U fish_key_bindings fish_vi_key_bindings

alias ls "exa"
alias ll "exa -alh"
alias cp="cp -i"
alias nvd="neovide"
alias vim 'nvim'
alias vi 'nvim'
alias v 'nvim'
alias dk 'docker'
alias nv 'neovide --multigrid --frame=none'
alias pn 'pnpm'
alias git-cm 'git commit -m'
alias git-current-branch 'git symbolic-ref --short HEAD'
alias gps 'git push -u origin (git-current-branch)'
alias gpl 'git pull'
alias gplr 'git pull --rebase --autostash'
alias gcm git_commit
alias grv 'git reset HEAD^'
alias gst 'git status'
alias glg 'git log'
alias tlg 'tig log'
alias cl 'clear'
alias gck 'git checkout'
alias para-cli 'npx @paraspace-liquidator/cmd@latest para-cli'
alias s 'neofetch | lolcat'

function git_commit
    echo "Input commit message: "
    read msg
    git commit -m $msg
end

function rm-node-modules
    find . -name "node_modules" -type d -prune -exec rm -rf '{}' +
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

function forward_port_to_local
    if test -n "$argv[1]" -a -n "$argv[2]"
        ssh -N -L (math $argv[3] -- $argv[2] localhost $argv[2]) $argv[1]
    end
end

if status is-interactive
    # Commands to run in interactive sessions can go here
end

# printf '\eP$f{"hook": "SourcedRcFileForWarp", "value": { "shell": "fish" }}\x9c'

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

# >>> ===================================== <<<
# >>> ========== 0. General End ========= <<<
# >>> ===================================== <<<

if uname | grep -qi "linux"
# >>> ===================================== <<<
# >>> =========== 1. Linux Start ========== <<<
# >>> ===================================== <<<
# echo "load fish config for Linux OS ..."

# cuda
set -gx CUDA_HOME "/usr/local/cuda"
set -gx CUDA_HOME_PATH "/usr/local/cuda/bin"
if not string match -q -- $CUDA_HOME_PATH $PATH
  set -gx PATH "$CUDA_HOME_PATH" $PATH
  set -gx LD_LIBRARY_PATH "/usr/local/cuda/lib64" $LD_LIBRARY_PATH
end
# cuda end

# pnpm
set -gx PNPM_HOME "/home/rjman/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

function switch_gcc
  sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-12 100 --slave /usr/bin/g++ g++ /usr/bin/g++-12 --slave /usr/bin/gcov gcov /usr/bin/gcov-12
  sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-10 70 --slave /usr/bin/g++ g++ /usr/bin/g++-10 --slave /usr/bin/gcov gcov /usr/bin/gcov-10
  sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 50 --slave /usr/bin/g++ g++ /usr/bin/g++-8 --slave /usr/bin/gcov gcov /usr/bin/gcov-8
  sudo update-alternatives --config gcc
end

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
# >>> ===================================== <<<
# >>> ============ 1. Linux End =========== <<<
# >>> ===================================== <<<

else if uname | grep -qi "darwin"
# >>> ===================================== <<<
# >>> ============ 2. Mac Start =========== <<<
# >>> ===================================== <<<
# echo "load fish config for Macintosh OS"

set -x PATH $PATH $HOME/.bin
set -x PATH $PATH $HOME/.cargo/bin
set -x PATH $PATH /opt/homebrew/bin
set -x PATH $PATH $HOME/.foundry/bin
set -x PATH $PATH /opt/homebrew/anaconda3/bin
set -x PATH $HOME/Applications/bin $PATH
set -x NVM_DIR $HOME/.nvm
set -x JAVA_HOME /Library/Java/JavaVirtualMachines/zulu-11.jdk/Contents/Home
set -x PATH $PATH (go env GOPATH)/bin
set -gx FISH_HOME /opt/homebrew/bin/fish

alias mount_sandisk='~/Utils/disk/mount_sandisk.sh'
alias mount_mobile_rjman='~/Utils/disk/mount_mobile_rjman.sh'
alias unmount_all='~/Utils/disk/unmount_all.sh'
alias unmount_sandisk='~/Utils/disk/unmount_sandisk.sh'
alias sandisk='mount_sandisk && mount_mobile_rjman && cd ~/Sandisk'
alias matlab='/Applications/MATLAB_R2023a.app/bin/matlab -nodesktop'

set -x PNPM_HOME $HOME/Library/pnpm
set -x PATH $PNPM_HOME $PATH
set -x AI_RESOURCES $HOME/Workspace/AI/resources

thefuck --alias | source

function fuck -d "Correct your previous console command"
  set -l fucked_up_command $history[1]
  env TF_SHELL=fish TF_ALIAS=fuck PYTHONIOENCODING=utf-8 thefuck $fucked_up_command THEFUCK_ARGUMENT_PLACEHOLDER $argv | read -l unfucked_command
  if [ "$unfucked_command" != "" ]
    eval $unfucked_command
    builtin history delete --exact --case-sensitive -- $fucked_up_command
    builtin history merge
  end
end

function launch_script
    ll $HOME/Workspace/Tool/dotfiles/launch/
    echo $HOME/Workspace/Tool/dotfiles/launch/
end

function yabai_start
    yabai --start-service
    # outdated cmd: https://github.com/koekeishiya/yabai/blob/a8d62d65ca2f599ed6ed8f0d4831e4b41246baf5/CHANGELOG.md?plain=1#LL13C1-L13C1
    # brew services start yabai
    # brew services start skhd
end

function yabai_stop
    yabai --stop-service
    # outdated cmd: https://github.com/koekeishiya/yabai/blob/a8d62d65ca2f599ed6ed8f0d4831e4b41246baf5/CHANGELOG.md?plain=1#LL13C1-L13C1
    # brew services stop yabai
    # brew services stop skhd
end

function temp_redis
    /opt/homebrew/opt/redis/bin/redis-server /opt/homebrew/etc/redis.conf
end

function temp_psql
    /opt/homebrew/opt/postgresql\@14/bin/postgres -D /opt/homebrew/var/postgres
end

function python_310
    set -x PATH /opt/homebrew/opt/python@3.10/bin $PATH
    set -x LDFLAGS "-L/opt/homebrew/opt/python@3.10/lib"
    set -x PKG_CONFIG_PATH "/opt/homebrew/opt/python@3.10/lib/pkgconfig"
end

function python_39
    set -x PATH /opt/homebrew/opt/python/bin $PATH
    set -x LDFLAGS "-L/opt/homebrew/opt/python/lib"
    set -x PKG_CONFIG_PATH "/opt/homebrew/opt/python/lib/pkgconfig"
end

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /opt/homebrew/anaconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

function cv
    conda_on
    conda activate cv
end

function dev
    conda_on
    conda activate dev
end

function rjman
    conda_on
    conda activate rjman
end

function dcn
    conda_on
    conda activate dcn
end

function llm
    conda_on
    conda activate llm
end

function sdwebui
    conda_on
    conda activate sdwebui
end

function ryan
    conda_on
    conda activate ryan
end

function stable
    conda_on
    conda activate stable
end

# >>> ===================================== <<<
# >>> ============= 2. Mac End ============ <<<
# >>> ===================================== <<<
end

# echo "done"
export PATH="$HOME/.fuelup/bin:$PATH"
