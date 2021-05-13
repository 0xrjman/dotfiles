# upgrade zsh
brew install zsh
# oh-my-zsh
brew install wget
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh
# or sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

# spaceship theme
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

# oh-my-zsh plugins
brew install autojump
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/paulirish/git-open.git $ZSH_CUSTOM/plugins/git-open
brew install trash
brew install brew
brew install nvim

# configuration
nvim ~/.zshrc
## ZSH_THEME="spaceship"
## plugin(... autojump ...)
## HIST_STAMPS="yyyy-mm-dd"
## alias rm="trash"
## alias cp="cp -i"
## bindkey ',' autosuggest-accept
source ~/.zshrc

