
# dotfiles

Personal macOS development environment, configured through a unified `make` interface.

## Quick Start

```sh
make install          # Install everything
./dotman              # Interactive TUI manager
```

## Usage

### CLI

| Command | Description |
|---------|-------------|
| `make install` | Install all configurations |
| `make install-<app>` | Install a single app config (e.g., `make install-nvim`) |
| `make init` | Ensure install.sh is executable |
| `make help` | List all available targets |
| `./dotman` | Interactive TUI manager |
| `./dotman status` | Print compact config status |
| `./dotman install` | Install everything from TUI |
| `./dotman repair` | Fix broken symlinks |
| `./dotman browse` | Browse configs with preview |

### TUI (Interactive)

Run `./dotman` for a full-screen terminal UI:

```
  [i] Install all    [r] Repair broken    [v] View config
  [b] Browse         [s] Scripts          [f] Fix one / [o] Install one
  [q] Quit           [?] Help
```

Browse mode shows a preview panel — select a config and see its file contents on the right.

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
└── scripts/           # Utility scripts
```

## Requirements

- macOS
- [Homebrew](https://brew.sh)
- [make](https://www.gnu.org/software/make/)
