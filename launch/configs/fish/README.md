# Usage

```sh
cd ..

make launch-fish

# install fisher
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher

# install fisher plugins
fisher install jethrokuan/z jorgebucaran/nvm.fish andreiborisov/sponge jorgebucaran/autopair.fish wookayin/fzf-fasd
```

### Theme

https://github.com/oh-my-fish/oh-my-fish/blob/master/docs/Themes.md

```sh
# fish_config

curl -L https://get.oh-my.fish | fish

omf install budspencer
omf theme budspencer
set budspencer_colors 000000 333333 666666 ffffff ff005a ff6600 ff0000 ff0033 3300ff 0000ff 00ffff 00ff00
```
