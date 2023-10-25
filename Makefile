
.PHONY: grant
grant:
	echo "Grant all the scripts permissions..."
	chmod +x grant.sh
	./grant.sh
	echo "done"

.PHONY: init
init: grant

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

.PHONY: lint-sctipts
link-scripts:
	echo "link scripts(notion) ..."
	sudo ln -s ~/.scripts/app/launch_notion.sh /usr/bin/notion

.PHONY: launch-zsh
launch-zsh:
	echo "Initialize your zsh..."
	chmod +x ./launch/configs/zsh/init.sh
	./launch/configs/zsh/init.sh

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
	chmod +x ./launch/configs/yabai/init.sh
	./launch/configs/yabai/init.sh

.PHONY: launch-skhd
launch-skhd:
	echo "Initialize your skhd..."
	chmod +x ./launch/configs/skhd/init.sh
	./launch/configs/skhd/init.sh

.PHONY: launch-zellij
launch-zellij:
	echo "Initialize your zellij..."
	chmod +x ./launch/configs/zellij/init.sh
	./launch/configs/zellij/init.sh

.PHONY: launch-alacritty
launch-alacritty:
	echo "Initialize your alacritty..."
	chmod +x ./launch/configs/alacritty/init.sh
	./launch/configs/alacritty/init.sh

.PHONY: launch-fish
launch-fish:
	echo "Initialize your fish ..."
	chmod +x ./launch/configs/fish/init.sh
	./launch/configs/fish/init.sh

.PHONY: launch-cargo
launch-cargo:
	echo "Initialize your cargo ..."
	chmod +x ./launch/configs/cargo/init.sh
	./launch/configs/cargo/init.sh

