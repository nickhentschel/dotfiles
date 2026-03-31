# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

Personal dotfiles managed by [chezmoi](https://www.chezmoi.io/). This is the **source directory** (`~/.local/share/chezmoi`) where changes are made. When applied, chezmoi processes templates and copies files to their target locations (`~/.zshrc`, `~/.config/nvim/`, etc.).

## Chezmoi Workflow

### Making Changes

**ALWAYS edit files in this source directory, never the target locations directly.**

```bash
# Edit source files here
vim dot_zshrc

# Apply changes to home directory
chezmoi apply

# Preview what would change
chezmoi diff

# Apply specific file
chezmoi apply ~/.zshrc
```

### File Naming Conventions

Chezmoi uses special prefixes that determine how files are processed:

- `dot_` → `.` (e.g., `dot_zshrc` → `~/.zshrc`)
- `private_` → File excluded from diffs/external viewing
- `executable_` → File gets +x permissions
- `.tmpl` → Template processed with Go text/template syntax

**Examples**:
- `dot_zshrc` → `~/.zshrc`
- `private_dot_config/nvim/init.lua` → `~/.config/nvim/init.lua` (private)
- `executable_claude-tmux.sh` → `claude-tmux.sh` (executable)
- `dot_gitconfig.tmpl` → `~/.gitconfig` (template + dot)

### Template System

Files ending in `.tmpl` are processed as Go templates. Access chezmoi data with:

```tmpl
{{- .chezmoi.os }}                    # darwin, linux, etc.
{{- .chezmoi.homeDir }}               # /Users/nickhe
{{- .email }}                         # From .chezmoi.toml data section
{{- if eq .chezmoi.os "darwin" -}}    # Conditional
  macOS-specific content
{{- end }}
```

**Active templates**:
- `.chezmoi.toml.tmpl` - Prompts for data variables on first run
- `dot_gitconfig.tmpl` - Uses `{{ .email }}` variable
- `dot_tmux.conf.tmpl` - Uses OS conditionals for clipboard commands
- `executable_claude-notify.sh.tmpl` - macOS vs Linux notification systems
- `executable_ai-cmd-gen.tmpl` - AWS profile configuration

## Architecture

### Tmux + Claude Code Integration

**How it works**: Custom hooks in Claude Code settings call bash scripts that manage state via tmux pane options. This enables multi-agent workflows with visual state indicators.

**State Flow**:
1. Claude Code triggers hook (PreToolUse, PostToolUse, Stop, Notification)
2. Hook calls script: `~/.config/tmux/claude-tmux.sh state set <state> <tool>`
3. Script updates tmux pane option: `@claude_state`, `@claude_tool`, `@claude_id`
4. Script changes pane border color based on state
5. Status bar shows aggregated state: `C<total> <working>w <waiting>!`

**Key Files**:
- `private_dot_claude/settings.json.tmpl` - Hook definitions that call scripts
- `private_dot_config/tmux/executable_claude-tmux.sh` - State management, navigation commands
- `private_dot_config/tmux/executable_claude-notify.sh.tmpl` - Attention handler (OS notifications + tmux visuals)
- `dot_tmux.conf.tmpl` - Pane border format, keybindings (prefix+g/n/s), status bar integration

**State storage**: Uses tmux pane options (`@claude_*`) instead of files. Automatically cleaned up when pane closes.

### AI Command Generation (Ctrl+X)

**How it works**: ZSH widget that calls AWS Bedrock → Claude to generate shell commands from natural language, displayed in fzf for selection.

**Flow**:
1. User presses Ctrl+X
2. ZLE widget `ai_command_generate()` prompts for input
3. Calls `~/.local/bin/ai-cmd-gen` with prompt text
4. Script calls AWS Bedrock Claude API via AWS CLI
5. Returns JSON with ranked command suggestions
6. Widget parses JSON, displays in fzf with preview pane
7. Selected command inserted at cursor position

**Key Files**:
- `private_dot_local/bin/executable_ai-cmd-gen.tmpl` - Backend script (AWS CLI + jq)
- `dot_zshrc` lines 294-346 - ZLE widget and keybinding

**Environment Variables**:
- `AI_CMD_AWS_PROFILE` - AWS profile with Bedrock access (default: zillow-sandbox)
- `AI_CMD_MODEL` - Claude model ID
- `AI_CMD_MAX_SUGGESTIONS` - Number of suggestions to generate

### ZSH Prompt Performance

Custom prompt with git branch caching to avoid slowdown in large repos.

**Caching Strategy** (`dot_zshrc` lines 359-375):
- Git info cached for 5 seconds in `_CACHED_GIT_INFO` + `_CACHED_GIT_TIMESTAMP`
- Prompt components calculated once at startup in `_setup_prompt_elements()`
- Only vi mode indicator updates on every prompt render

### Neovim Configuration

**Plugin Manager**: lazy.nvim (auto-installs on first launch)

**Module Structure**:
- `init.lua` - Bootstrap lazy.nvim, import modules
- `lua/settings.lua` - All `vim.opt.*` and autocommands
- `lua/keymaps.lua` - All key mappings
- `lua/plugins/*.lua` - Plugin definitions by category

**Separate VSCode Config**: `vscode.vim` loaded when running inside VSCode/Cursor Neovim extension (minimal plugin set).

## Testing Changes

### ZSH Changes

```bash
chezmoi apply ~/.zshrc
exec zsh  # Reload shell
```

### Tmux Changes

```bash
chezmoi apply ~/.tmux.conf
tmux source ~/.tmux.conf  # Reload config
# Or restart tmux: tmux kill-server && tmux
```

### Neovim Changes

```bash
chezmoi apply ~/.config/nvim/
# Restart nvim
# Or reload config: :source $MYVIMRC
```

### Claude Code Settings

```bash
chezmoi apply ~/.claude/settings.json
# Restart Claude Code session
```

### Template Changes

After modifying any `.tmpl` file:

```bash
# Regenerate target file
chezmoi apply

# View what template generates (without applying)
chezmoi execute-template < dot_gitconfig.tmpl
```

## Common Tasks

### Add New Dotfile to Repository

```bash
# Add existing file to chezmoi
chezmoi add ~/.somefile

# Or create new file
chezmoi add --template ~/.newfile

# Edit it
chezmoi edit ~/.newfile

# Apply
chezmoi apply
```

### Update Homebrew Packages

```bash
# Edit Brewfile
vim Brewfile

# Install new packages
brew bundle

# Update lock file
brew bundle dump --force
```

### Sync to New Machine

```bash
# Initialize and apply
chezmoi init https://github.com/nickhentschel/dotfiles.git
chezmoi apply

# Install packages
brew bundle
```

### Debug Tmux Integration

```bash
# Check current pane state
~/.config/tmux/claude-tmux.sh state get

# View all Claude agents
~/.config/tmux/claude-tmux.sh list

# Status summary
~/.config/tmux/claude-tmux.sh status
```

## Directory Structure

```
.
├── .chezmoi.toml.tmpl              # Config with data variables
├── Brewfile                         # Homebrew package list
├── dot_zshrc                        # ZSH configuration
├── dot_tmux.conf.tmpl              # Tmux configuration (template)
├── dot_gitconfig.tmpl              # Git config (uses email variable)
├── private_dot_config/
│   ├── nvim/                       # Neovim Lua config
│   │   ├── init.lua
│   │   └── lua/
│   │       ├── settings.lua
│   │       ├── keymaps.lua
│   │       └── plugins/            # Plugin specs
│   └── tmux/                       # Claude-tmux integration scripts
│       ├── executable_claude-tmux.sh
│       └── executable_claude-notify.sh.tmpl
├── private_dot_local/
│   └── bin/
│       └── executable_ai-cmd-gen.tmpl  # AI command generation backend
└── private_dot_claude/
    ├── settings.json.tmpl          # Claude Code settings (hooks)
    └── CLAUDE.md                   # Global Claude Code instructions
```
