.PHONY: help
help:
	@echo "Usage: make <target>"
	@echo ""
	@echo "Main targets:"
	@echo "  install          - Install all configurations"
	@echo ""
	@echo "Individual installation targets:"
	@echo "  install-zsh"
	@echo "  install-nvim"
	@echo "  install-lvim"
	@echo "  install-yabai"
	@echo "  install-skhd"
	@echo "  install-zellij"
	@echo "  install-alacritty"
	@echo "  install-fish"
	@echo "  install-cargo"
	@echo "  install-sketchybar"
	@echo "  install-btop"
	@echo "  install-yazi"
	@echo "  install-aerospace"
	@echo ""
	@echo "Utility targets:"
	@echo "  gitignore        - Link global gitignore"
	@echo "  setup-scripts    - Link scripts to ~/.scripts"

# ==============================================================================
# Main Targets
# ==============================================================================

.PHONY: install
install: install-zsh install-nvim install-lvim install-yabai install-skhd \
         install-zellij install-alacritty install-fish install-cargo \
         install-sketchybar install-btop install-yazi install-aerospace

.PHONY: init
init:
	@chmod +x lib/install.sh

# ==============================================================================
# Utility Targets
# ==============================================================================

.PHONY: gitignore
gitignore:
	@echo "Linking global gitignore..."
	@ln -sf "$(PWD)/configs/git/.gitignore_global" ~/.gitignore_global
	@git config --global core.excludesfile ~/.gitignore_global

.PHONY: setup-scripts
setup-scripts:
	@echo "Linking scripts to ~/.scripts..."
	@ln -sfn "$(PWD)/scripts" ~/.scripts

# ==============================================================================
# Installation Framework
# ==============================================================================
#
# lib/install.sh <name> <source_rel> <target_path> [os_specific] [post_cmd]
#
#   source_rel   "." = symlink entire configs/<name>/ directory
#                "filename" = symlink configs/<name>/<filename>
#   os_specific  "true" = OS-aware config selection (alacritty)
#   post_cmd     Command to run after install (sketchybar restart)

define install_template
.PHONY: install-$(1)
install-$(1): init
	@./lib/install.sh $(1) $(2) $(3) $(4) $(5)
endef

# --- File-mode configs (single file symlink) ---
$(eval $(call install_template,zsh,.zshrc,$(HOME)/.zshrc))
$(eval $(call install_template,yabai,.yabairc,$(HOME)/.yabairc))
$(eval $(call install_template,skhd,.skhdrc,$(HOME)/.skhdrc))
$(eval $(call install_template,cargo,config,$(HOME)/.cargo/config))

# --- Directory-mode configs (whole dir symlink) ---
$(eval $(call install_template,fish,.,$(HOME)/.config/fish))
$(eval $(call install_template,zellij,.,$(HOME)/.config/zellij))
$(eval $(call install_template,sketchybar,.,$(HOME)/.config/sketchybar,,'brew services restart sketchybar'))
$(eval $(call install_template,btop,.,$(HOME)/.config/btop))
$(eval $(call install_template,aerospace,.,$(HOME)/.config/aerospace))
$(eval $(call install_template,alacritty,.,$(HOME)/.config/alacritty,true))

# --- Custom install scripts (not using the template) ---
.PHONY: install-nvim
install-nvim: init
	@echo "Initializing neovim..."
	@./configs/vim/init-nvim.sh

.PHONY: install-lvim
install-lvim: init
	@echo "Initializing lunarvim..."
	@./configs/vim/init-lvim.sh

.PHONY: install-yazi
install-yazi: init
	@echo "Initializing yazi..."
	@brew install yazi ffmpeg sevenzip jq poppler fd ripgrep fzf zoxide resvg imagemagick font-symbols-only-nerd-font
	./lib/install.sh yazi . ~/.config/yazi
