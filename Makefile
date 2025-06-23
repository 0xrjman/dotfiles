.PHONY: help
help:
	@echo "Usage: make <target>"
	@echo ""
	@echo "Main targets:"
	@echo "  install          - Install all configurations by calling all install-* targets."
	@echo "  grant            - Grant executable permissions for scripts."
	@echo "  init             - A prerequisite for other targets, ensures scripts are executable."
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
	@echo "Other utility targets:"
	@echo "  alias            - Set up shell aliases."
	@echo "  gitignore        - Initialize gitignore file."
	@echo "  setup-scripts    - Link custom scripts directory."
	@echo "  link-scripts     - Link specific scripts to /usr/bin."

# ==============================================================================
# Main Targets
# ==============================================================================

.PHONY: install
install: install-zsh install-nvim install-lvim install-yabai install-skhd \
         install-zellij install-alacritty install-fish install-cargo \
         install-sketchybar install-btop install-yazi install-aerospace

.PHONY: grant
grant:
	@echo "Granting executable permissions for all scripts..."
	@chmod +x grant.sh
	@./grant.sh
	@echo "Done."

.PHONY: init
init: grant
	@chmod +x ./launch/common_init.sh

# ==============================================================================
# Utility Targets
# ==============================================================================

.PHONY: alias
alias: init
	@chmod +x ./launch/alias.sh
	@cd launch && ./alias.sh

.PHONY: gitignore
gitignore:
	@echo "Initializing gitignore..."
	@chmod +x ./launch/configs/git/init.sh
	@./launch/configs/git/init.sh

.PHONY: setup-scripts
setup-scripts:
	@echo "Setting up custom scripts..."
	@ln -s -r scripts ~/.scripts

.PHONY: link-scripts
link-scripts:
	@echo "Linking scripts (e.g., notion)..."
	@sudo ln -s ~/.scripts/app/launch_notion.sh /usr/bin/notion

# ==============================================================================
# Individual Installation Targets
# ==============================================================================

# Template for generating installation rules for applications.
# Arguments:
#   1: Application name (e.g., zsh)
#   2: Configuration file name (e.g., .zshrc)
#   3: Target directory (optional, defaults to ~/.config/$(1))
#   4: OS-specific flag (optional, e.g., true)
define install_template
.PHONY: install-$(1)
install-$(1): init
	@echo "Initializing $(1)..."
	./launch/common_init.sh $(1) $(2) '$(if $(3),$(3),$(HOME)/.config/$(1))' $(4)
endef

# Generate rules for standard applications
$(eval $(call install_template,yabai,.yabairc))
$(eval $(call install_template,skhd,.skhdrc))
$(eval $(call install_template,zellij,config.kdl))
$(eval $(call install_template,fish,config.fish))
$(eval $(call install_template,sketchybar,sketchybarrc))
$(eval $(call install_template,btop,btop.conf))
$(eval $(call install_template,aerospace,aerospace.toml))

# Special-case applications
$(eval $(call install_template,zsh,.zshrc,$(HOME)))
$(eval $(call install_template,alacritty,alacritty.yml,,true))
$(eval $(call install_template,cargo,config,$(HOME)/.cargo))

# Applications with custom installation scripts
.PHONY: install-nvim
install-nvim: init
	@echo "Initializing neovim..."
	@chmod +x ./launch/configs/vim/init-nvim.sh
	@./launch/configs/vim/init-nvim.sh

.PHONY: install-lvim
install-lvim: init
	@echo "Initializing lunarvim..."
	@chmod +x ./launch/configs/vim/init-lvim.sh
	@./launch/configs/vim/init-lvim.sh

.PHONY: install-yazi
install-yazi: init
	@echo "Initializing yazi..."
	brew install yazi ffmpeg sevenzip jq poppler fd ripgrep fzf zoxide resvg imagemagick font-symbols-only-nerd-font
	./launch/common_init.sh yazi yazi.toml ~/.config/yazi

# Remove old duplicated targets
.PHONY: remove-old-targets
remove-old-targets:
	@echo "This is a placeholder if you need to manually remove old targets from your shell history or scripts."