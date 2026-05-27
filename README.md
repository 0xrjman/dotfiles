
# dotfiles

Personal macOS development environment, configured through a unified `make` interface.

## Quick Start

```sh
make install
```

## Usage

| Command | Description |
|---------|-------------|
| `make install` | Install all configurations |
| `make install-<app>` | Install a single app config (e.g., `make install-nvim`) |
| `make init` | Ensure all scripts are executable |
| `make help` | List all available targets |

## Managed Applications

| Category | Apps |
|----------|------|
| Shell | zsh, fish |
| Editor | neovim, lunarvim |
| Terminal | alacritty, zellij |
| Window Manager | yabai + skhd, aerospace |
| Status Bar | sketchybar |
| File Manager | yazi |
| System Monitor | btop |
| Tools | git, cargo, conda, pip |

## Structure

```
.
├── Makefile          # Unified entry point
├── configs/           # Application configurations (flat)
├── lib/               # Installation framework
├── scripts/           # Utility scripts
└── .config -> configs  # Symlink for tool discovery
```

## Requirements

- macOS
- [Homebrew](https://brew.sh)
- [make](https://www.gnu.org/software/make/)
