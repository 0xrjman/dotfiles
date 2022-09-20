
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

