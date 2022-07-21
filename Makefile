.PHONY: init
launch-nvim:
	echo "Initialize your neovim..."
	chmod +x ./launch/init-nvim.sh
	cd launch && ./init-nvim.sh
