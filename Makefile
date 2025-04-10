.PHONY: grant
grant:
	echo "Grant all the scripts permissions..."
	chmod +x grant.sh
	./grant.sh
	echo "done"

.PHONY: init
init: grant
	chmod +x ./launch/common_init.sh

.PHONY: alias
alias:
	chmod +x ./launch/alias.sh
	cd launch && ./alias.sh

.PHONY: launch-gitignore
launch-gitignore:
	echo "Initialize your gitignore..."
	chmod +x ./launch/configs/git/init.sh
	./launch/configs/git/init.sh

.PHONY: setup-scripts
setup-scripts:
	echo "setup custom scripts..."
	ln -s -r scripts ~/.scripts

.PHONY: link-scripts
link-scripts:
	echo "link scripts(notion) ..."
	sudo ln -s ~/.scripts/app/launch_notion.sh /usr/bin/notion

.PHONY: launch-zsh
launch-zsh:
	echo "Initialize your zsh..."
	./launch/common_init.sh zsh .zshrc ~
.PHONY: launch-nvim
launch-nvim:
	echo "Initialize your neovim..."
	chmod +x ./launch/configs/vim/init-nvim.sh
	./launch/configs/vim/init-nvim.sh

.PHONY: launch-lvim
launch-lvim:
	echo "Initialize your lunarvim..."
	chmod +x ./launch/configs/vim/init-lvim.sh
	./launch/configs/vim/init-lvim.sh

.PHONY: launch-yabai
launch-yabai:
	echo "Initialize your yabai..."
	./launch/common_init.sh yabai .yabairc ~/.config/yabai
.PHONY: launch-skhd
launch-skhd:
	echo "Initialize your skhd..."
	./launch/common_init.sh skhd .skhdrc ~/.config/skhd
.PHONY: launch-zellij
launch-zellij:
	echo "Initialize your zellij..."
	./launch/common_init.sh zellij config.kdl ~/.config/zellij
.PHONY: launch-alacritty
launch-alacritty:
	echo "Initialize your alacritty..."
	./launch/common_init.sh alacritty alacritty.yml ~/.config/alacritty true
.PHONY: launch-fish
launch-fish:
	echo "Initialize your fish ..."
	./launch/common_init.sh fish config.fish ~/.config/fish
.PHONY: launch-cargo
launch-cargo:
	echo "Initialize your cargo ..."
	./launch/common_init.sh cargo config ~/.cargo
.PHONY: launch-sketchybar
launch-sketchybar:
	echo "Initialize your sketchybar ..."
	./launch/common_init.sh sketchybar sketchybarrc ~/.config/sketchybar

.PHONY: launch-btop
launch-btop:
	echo "Initialize your btop ..."
	./launch/common_init.sh btop btop.conf ~/.config/btop
