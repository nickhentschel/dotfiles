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
  - AI command generation (Ctrl+X) - see below
- **Editor settings**:
  - Neovim: Lua config with lazy.nvim, lualine, nvim-tree, ALE, vim-go, vim-polyglot, and Claude AI via codecompanion.nvim — see `private_dot_config/nvim/README.md`
  - Cursor (VSCode-based) setup with extensions
- **Package management**:
  - Brewfile for macOS dependencies
  - Auto-installation of core tools
- **Git configuration**:
  - Global gitconfig and gitignore
  - Optimized settings

AI Command Generation
---------------------

Generate shell commands from natural language descriptions using AWS Bedrock + Claude.

**Usage:**
1. Press `Ctrl+X` from anywhere on the command line
2. Type your request in the popup: `find python files changed this week`
3. Press Enter - AI generates ranked suggestions
4. Select from fzf menu (preview pane shows explanations)
5. Press Enter - command is inserted at your cursor, ready to edit/run

**Keybindings:**
- `Ctrl+X` - Trigger AI command generation
- `Ctrl+Y` (in fzf) - Copy selected command to clipboard

**Requirements:**
- AWS CLI configured with Bedrock access
- Default profile: `zillow-sandbox` (override with `AI_CMD_AWS_PROFILE`)

**Configuration (env vars):**
```bash
AI_CMD_MODEL="us.anthropic.claude-sonnet-4-20250514-v1:0"  # Claude model
AI_CMD_MAX_SUGGESTIONS=5                                    # Number of suggestions
AI_CMD_AWS_PROFILE="zillow-sandbox"                         # AWS profile
AI_CMD_AWS_REGION="us-west-2"                               # AWS region
```

**Files:**
- `~/.local/bin/ai-cmd-gen` - Backend script calling Bedrock API
- `~/.zshrc` - ZLE widget and keybinding

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
