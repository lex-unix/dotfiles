# Personal dotfiles

![neovim screenshot](docs/neovim-screenshot.png)

This repository contains configuration for neovim, fish, tmux, and more. Everything is primarily managed through **Nix** and **Home-Manager**.

## Neovim

- **LSP**: `nvim-lspconfig`, `mason.nvim`, `mason-lspconfig.nvim`
- **Completion**: `blink.cmp`
- **Formatting**: `conform.nvim`
- **UI**: `snacks.nvim` (picker), `oil.nvim` (explorer), `lualine.nvim`, `bufferline.nvim`
- **DAP**: `nvim-dap`
- **Syntax**: `treesitter` with custom queries for Go, TypeScript, Markdown
- **Themes**:
    - Dark: [gruvbox-material](https://github.com/sainnhe/gruvbox-material)
    - Light: [github-nvim-theme](https://github.com/projekt0n/github-nvim-theme)

## Fish Shell

- Managed via home-manager (`nix-darwin/modules/home-manager/fish.nix`)
- Plugins:
    - [`patrickf1/fzf.fish`](https://github.com/patrickf1/fzf.fish)
- Custom aliases and functions for tmux sessionizing, path management, and more

## Tmux

- Managed via home-manager (`nix-darwin/modules/home-manager/tmux.nix`)
- Vi key mode, custom status line, themed colors, and sensible keybindings

## Version Control

- **Jujutsu (jj)**: Now used as the primary tool for version control, replacing the standard Git workflow.
  Uses [delta](https://github.com/dandavison/delta) for diffs.
- **Git**: Managed via home-manager (`nix-darwin/modules/home-manager/git.nix`) as the backend.

## Legacy configuration

The branch `before-nix-darwin` contains my previous dotfiles setup, before migrating to Nix.
You may find it useful for reference, comparison, or if you want to see how things were managed without Nix.
