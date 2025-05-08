Dotfiles
========

My dotfiles. Everything here is managed by [chezmoi](https://github.com/twpayne/chezmoi).

To install:

```
chezmoi init https://github.com/nickhentschel/dotfiles.git
```

## What's Included

- **Shell configuration**: ZSH with custom prompt, aliases, and functions
- **Editor settings**: Neovim and Cursor (VSCode) configuration
- **Terminal**: Alacritty and tmux configuration
- **Package management**: Brewfile for macOS dependencies
- **Git configuration**: Global gitconfig and gitignore

## Cursor/VSCode Settings

Cursor settings are stored in `private_Library/private_Application Support/private_Cursor/User/settings.json` for macOS and will be applied automatically when using chezmoi.

## Homebrew Packages

The Brewfile contains all the packages needed. Install them with:

```
brew bundle
```

More customization and automation to come.
