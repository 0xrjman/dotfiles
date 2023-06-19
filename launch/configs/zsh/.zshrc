# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/rjman/.oh-my-zsh"
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"
ZSH_THEME="powerlevel10k/powerlevel10k"
# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
        autojump
        git
        git-open
        sudo
        zsh-autosuggestions
        zsh-syntax-highlighting
        vi-mode
)
# Enable vi mode
bindkey -v

bindkey ',' autosuggest-accept
HIST_STAMPS="yyyy-mm-dd"
# alias rm="trash"
alias cp="cp -i"
alias nvd="neovide"
alias mount_sandisk='~/Utils/disk/mount_sandisk.sh'
alias mount_mobile_rjman='~/Utils/disk/mount_mobile_rjman.sh'
alias unmount_all='~/Utils/disk/unmount_all.sh'
alias unmount_sandisk='~/Utils/disk/unmount_sandisk.sh'
alias sandisk='mount_sandisk && mount_mobile_rjman && cd ~/Sandisk'
alias matlab='/Applications/MATLAB_R2022b_Beta.app/bin/matlab -nodesktop'

export PATH=$HOME/Applications/bin:$PATH
export PATH=$PATH:$(go env GOPATH)/bin
export PATH=$PATH:$HOME/.local/bin
source $ZSH/oh-my-zsh.sh
export NVM_DIR="$HOME/.nvm"
source $(brew --prefix nvm)/nvm.sh

# Java Runtime
# export MAVEN_HOME=/opt/homebrew/Cellar/maven/3.8.1
# export PATH=$PATH:$MAVEN_HOME/bin

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
# git config --global http.https://github.com.proxy http://127.0.0.1:8889
function git_proxy_on() {
  git config --global http.proxy http://127.0.0.1:7890
  git config --global https.proxy https://127.0.0.1:7890
  echo -e "set git proxy port 7890"
}

# git config --global --unset http.https://github.com.proxy
function git_proxy_off() {
  git config --global --unset http.proxy
  git config --global --unset https.proxy
  echo -e "unset git proxy"
}

function proxy_off(){
        unset http_proxy
        unset https_proxy
        unset ftp_proxy
        unset rsync_proxy
        git_proxy_off
        echo -e "已关闭代理"
        # curl cip.cc
}
function proxy_on() {
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
}
# proxy_on
function conda_on() {
  # >>> conda initialize >>>
  # !! Contents within this block are managed by 'conda init' !!
  __conda_setup="$('/opt/homebrew/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
  if [ $? -eq 0 ]; then
      eval "$__conda_setup"
  else
      if [ -f "/opt/homebrew/anaconda3/etc/profile.d/conda.sh" ]; then
# . "/opt/homebrew/anaconda3/etc/profile.d/conda.sh"  # commented out by conda initialize
      else
# export PATH="/opt/homebrew/anaconda3/bin:$PATH"  # commented out by conda initialize
      fi
  fi
  unset __conda_setup
  # <<< conda initialize <<<
}

function conda_off() {
    conda deactivate
}

function cv() {
    conda_on
    conda activate cv
}
function dev() {
    conda_on
    conda activate dev
}

function rjman() {
    conda_on
    conda activate rjman
}

function ryan() {
    conda_on
    conda activate ryan
}

function stable() {
    conda_on
    conda activate stable
}
function jump_server() {
    chmod 400 ~/.ssh/id_rsa.pem
}

function temp_redis() {
    # brew services restart redis
    /opt/homebrew/opt/redis/bin/redis-server /opt/homebrew/etc/redis.conf
}

function temp_psql() {
    # brew services restart postgresql
    /opt/homebrew/opt/postgresql@14/bin/postgres -D /opt/homebrew/var/postgres
    # /opt/homebrew/opt/postgresql/bin/postgres -D /opt/homebrew/var/postgres
}
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Java configuration
# export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-8.jdk/Contents/Home
# export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home
export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-11.jdk/Contents/Home
# export JAVA_HOME=/Library/Java/JavaVirtualMachines/temurin-19.jdk/Contents/Home

export PATH="$PATH:/Users/rjman/.bin"
export PATH="$PATH:/Users/rjman/.foundry/bin"
alias vim='nvim'
alias vi='nvim'
alias v='nvim'
alias dk='docker'
alias nv='neovide --multigrid --frame=none'
alias pn='pnpm'
alias git-cm='git commit -m'

alias rm-node-modules='find . -name "node_modules" -type d -prune -exec rm -rf '{}' +'
alias s='neofetch | lolcat'

function python_310() {
  export PATH="/opt/homebrew/opt/python@3.10/bin:$PATH"
  export LDFLAGS="-L/opt/homebrew/opt/python@3.10/lib"
  export PKG_CONFIG_PATH="/opt/homebrew/opt/python@3.10/lib/pkgconfig"
}

function python_39() {
  export PATH="/opt/homebrew/opt/python/bin:$PATH"
  export LDFLAGS="-L/opt/homebrew/opt/python/lib"
  export PKG_CONFIG_PATH="/opt/homebrew/opt/python/lib/pkgconfig"
}
export PATH="$PATH:/opt/homebrew/anaconda3/bin"
# export PYTHONPATH="/opt/homebrew/anaconda3/envs/stable/lib/python39.zip', '/opt/homebrew/anaconda3/envs/stable/lib/python3.9', '/opt/homebrew/anaconda3/envs/stable/lib/python3.9/lib-dynload', '/Users/rjman/.local/lib/python3.9/site-packages', '/opt/homebrew/anaconda3/envs/stable/lib/python3.9/site-packages"
# export PYTHONPATH="/opt/homebrew/anaconda3/envs/rjman/lib/python39.zip', '/opt/homebrew/anaconda3/envs/rjman/lib/python3.9', '/opt/homebrew/anaconda3/envs/rjman/lib/python3.9/lib-dynload', '/Users/rjman/.local/lib/python3.9/site-packages', '/opt/homebrew/anaconda3/envs/rjman/lib/python3.9/site-packages"

# alias python='python3'
# alias py='python'

# git configurations
alias git-current-branch='git symbolic-ref --short HEAD'
alias gps='git push -u origin $(git-current-branch)'
alias gpl='git pull'
alias gplr='git pull --rebase --autostash'
function git_commit() {
  echo "Input commit message: "
  read msg
  git commit -m ${msg}
}
alias gcm=git_commit
alias grv='git reset HEAD^'
alias gst='git status'
alias glg='git log'
alias tlg='tig log'
alias cl='clear'
alias gck='git checkout'
alias para-cli='npx @paraspace-liquidator/cmd@latest para-cli'
# pnpm
export PNPM_HOME="/Users/rjman/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

# dotfiles launch script
function launch_script() {
  ll ~/Workspace/Tool/dotfiles/launch/
  echo "~/Workspace/Tool/dotfiles/launch/"
}
# alias ls='exa'
alias ls='lsd'

export AI_RESOURCES="/Users/rjman/Workspace/AI/resources"

function yabai_start() {
  yabai --start-service
  # outdated cmd: https://github.com/koekeishiya/yabai/blob/a8d62d65ca2f599ed6ed8f0d4831e4b41246baf5/CHANGELOG.md?plain=1#LL13C1-L13C1
  # brew services start yabai
  # brew services start skhd
}

function yabai_stop() {
  yabai --stop-service
  # outdated cmd: https://github.com/koekeishiya/yabai/blob/a8d62d65ca2f599ed6ed8f0d4831e4b41246baf5/CHANGELOG.md?plain=1#LL13C1-L13C1
  # brew services stop yabai
  # brew services stop skhd
}
function verify_cmd() {
  # shasum -a 256 $(which rg)
}

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# =============================================================================
#
# Utility functions for zoxide.
#

# pwd based on the value of _ZO_RESOLVE_SYMLINKS.
function __zoxide_pwd() {
    \builtin pwd -L
}

# cd + custom logic based on the value of _ZO_ECHO.
function __zoxide_cd() {
    # shellcheck disable=SC2164
    \builtin cd -- "$@" >/dev/null
}

# =============================================================================
#
# Hook configuration for zoxide.
#

# Hook to add new entries to the database.
function __zoxide_hook() {
    # shellcheck disable=SC2312
    \command zoxide add -- "$(__zoxide_pwd)"
}

# Initialize hook.
# shellcheck disable=SC2154
if [[ ${precmd_functions[(Ie)__zoxide_hook]:-} -eq 0 ]] && [[ ${chpwd_functions[(Ie)__zoxide_hook]:-} -eq 0 ]]; then
    precmd_functions+=(__zoxide_hook)
fi

# =============================================================================
#
# When using zoxide with --no-cmd, alias these internal functions as desired.
#

__zoxide_z_prefix='z#'

# Jump to a directory using only keywords.
function __zoxide_z() {
    # shellcheck disable=SC2199
    if [[ "$#" -eq 0 ]]; then
        __zoxide_cd ~
    elif [[ "$#" -eq 1 ]] && { [[ -d "$1" ]] || [[ "$1" = '-' ]] || [[ "$1" =~ ^[-+][0-9]$ ]]; }; then
        __zoxide_cd "$1"
    elif [[ "$@[-1]" == "${__zoxide_z_prefix}"* ]]; then
        # shellcheck disable=SC2124
        \builtin local result="${@[-1]}"
        __zoxide_cd "${result:${#__zoxide_z_prefix}}"
    else
        \builtin local result
        # shellcheck disable=SC2312
        result="$(\command zoxide query --exclude "$(__zoxide_pwd)" -- "$@")" &&
            __zoxide_cd "${result}"
    fi
}

# Jump to a directory using interactive search.
function __zoxide_zi() {
    \builtin local result
    result="$(\command zoxide query -i -- "$@")" && __zoxide_cd "${result}"
}

# =============================================================================
#
# Commands for zoxide. Disable these using --no-cmd.
#

\builtin unalias z &>/dev/null || \builtin true
function z() {
    __zoxide_z "$@"
}

\builtin unalias zi &>/dev/null || \builtin true
function zi() {
    __zoxide_zi "$@"
}

if [[ -o zle ]]; then
    function __zoxide_z_complete() {
        # Only show completions when the cursor is at the end of the line.
        # shellcheck disable=SC2154
        [[ "${#words[@]}" -eq "${CURRENT}" ]] || return

        if [[ "${#words[@]}" -eq 2 ]]; then
            _files -/
        elif [[ "${words[-1]}" == '' ]]; then
            \builtin local result
            # shellcheck disable=SC2086,SC2312
            if result="$(\command zoxide query --exclude "$(__zoxide_pwd)" -i -- ${words[2,-1]})"; then
                __zoxide_result="${result}"
            else
                __zoxide_result=''
            fi
            \builtin printf '\e[5n'
        fi
    }

    function __zoxide_z_complete_helper() {
        \builtin local result="${__zoxide_z_prefix}${__zoxide_result}"
        # shellcheck disable=SC2296
        [[ -n "${__zoxide_result}" ]] && LBUFFER="${LBUFFER}${(q-)result}"
        \builtin zle reset-prompt
    }

    \builtin zle -N __zoxide_z_complete_helper
    \builtin bindkey "\e[0n" __zoxide_z_complete_helper
    if [[ "${+functions[compdef]}" -ne 0 ]]; then
        \compdef -d z
        \compdef -d zi
        \compdef __zoxide_z_complete z
    fi
fi

# =============================================================================
#
# To initialize zoxide, add this to your configuration (usually ~/.zshrc):
#
eval "$(zoxide init zsh)"
