# Neovim Setup for VSCode/Cursor

This directory contains configuration files for using Neovim with VSCode/Cursor.

## Files

- `init.vim`: Main Neovim configuration file
- `vscode.vim`: Configuration specifically for VSCode Neovim integration
- `setup_plugins.sh`: Script to install vim-plug and all required plugins

## Setup Instructions

### 1. Install Neovim

```bash
# macOS
brew install neovim

# Ubuntu/Debian
sudo apt update
sudo apt install neovim

# Other platforms
# See https://github.com/neovim/neovim/wiki/Installing-Neovim
```

### 2. Install VSCode Neovim Extension

1. Open VSCode/Cursor
2. Go to Extensions (Ctrl+Shift+X or Cmd+Shift+X)
3. Search for "Neovim" and install the extension by asvetliakov

### 3. Install Plugins

Run the setup script to install vim-plug and all plugins defined in vscode.vim:

```bash
~/.config/nvim/setup_plugins.sh
```

### 4. Configure VSCode Settings

Add these settings to your VSCode/Cursor settings.json:

```json
"vscode-neovim.neovimInitVimPaths.darwin": "~/.config/nvim/vscode.vim",
"vscode-neovim.neovimInitVimPaths.linux": "~/.config/nvim/vscode.vim",
"vscode-neovim.neovimInitVimPaths.win32": "~/.config/nvim/vscode.vim",
```

## Starting from Scratch

If you're setting up on a new machine:

1. Clone this repository or copy these configuration files to `~/.config/nvim/`
2. Make the setup script executable: `chmod +x ~/.config/nvim/setup_plugins.sh`
3. Run the setup script: `~/.config/nvim/setup_plugins.sh`
4. Configure VSCode/Cursor as described above