Dotfiles
========

My dotfiles. Everything here is managed by [chezmoi](https://github.com/twpayne/chezmoi).

Quick Install
------------

```bash
chezmoi init https://github.com/nickhentschel/dotfiles.git
chezmoi apply
```

Detailed Setup
-------------

1. Install [chezmoi](https://www.chezmoi.io/install/)
2. Initialize the dotfiles repository:

   ```bash
   chezmoi init https://github.com/nickhentschel/dotfiles.git
   ```

3. Apply the configuration:

   ```bash
   chezmoi apply
   ```

4. Install Homebrew packages:

   ```bash
   brew bundle
   ```

The setup script will automatically:

- Install all required Homebrew packages
- Set up Cursor editor with extensions
- Configure the optimized ZSH environment

What's Included
---------------

- **Shell configuration**:
  - ZSH with optimized prompt (git status caching for performance)
  - Custom aliases and functions
  - Performance-optimized configuration
- **Editor settings**:
  - Neovim configuration
  - Cursor (VSCode-based) setup with extensions
- **Package management**:
  - Brewfile for macOS dependencies
  - Auto-installation of core tools
- **Git configuration**:
  - Global gitconfig and gitignore
  - Optimized settings

Cursor/VSCode Settings
----------------------

Cursor settings are stored in `private_Library/private_Application
Support/private_Cursor/User/settings.json` for macOS and will be applied
automatically when using chezmoi.

The setup ensures that:

- Cursor is installed via Homebrew
- Command-line tools are configured
- Required extensions are automatically installed

Homebrew Packages
----------------

The Brewfile contains all the packages needed. Install them with:

```bash
brew bundle
```

Updates and Maintenance
---------------------

To update your configuration:

```bash
# Pull the latest changes
chezmoi update

# Apply specific updates
chezmoi edit ~/.zshrc
chezmoi apply
```

More customization and automation to come.
