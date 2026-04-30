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
- `private_dot_openclaw/openclaw.json.tmpl` - OpenClaw config, secrets from Keychain
- `private_dot_openclaw/identity/device.json.tmpl` - Device keypair, from Keychain base64
- `private_dot_openclaw/private_devices/paired.json.tmpl` - Paired device tokens, from Keychain base64
- `private_dot_openclaw/credentials/telegram-default-allowFrom.json.tmpl` - Telegram allowlist

## Skills

### Chezmoi Dotfiles Safety (`/chezmoi`)

**Purpose**: Prevent editing target files directly instead of their chezmoi source files. Auto-redirect to source and guide proper workflows.

**Triggers automatically when:**
- User asks to edit a dotfile path in home directory (`~/.zshrc`, `~/.tmux.conf`, etc.)
- After editing source files (suggests `chezmoi apply`)
- Working with template files (offers to preview/diff)

**What it does:**
- Redirects `~/.zshrc` → `dot_zshrc` edits automatically
- Suggests apply commands after source changes
- Guides template testing workflow (`execute-template`, `diff`, `apply`)
- Translates chezmoi file naming conventions

**When to invoke manually:**
```bash
# If you need chezmoi workflow guidance
/chezmoi
```

**Key Files:**
- `private_dot_claude/skills/chezmoi.md` - Skill definition

## Architecture

### Permission System

**How it works**: Claude Code settings define pre-approved commands and patterns that bypass permission prompts. This enables fluid workflows for common operations while maintaining security for risky actions.

**Permission Types** (`private_dot_claude/settings.json.tmpl`):
- `permissions.allow[]` - Pre-approved tool calls (Read paths, specific Bash commands)
- `permissions.bash.alwaysAllowCommands[]` - Simple utilities that never need approval
- `permissions.bash.alwaysAllowPatterns[]` - Regex patterns for read-only operations

**Pre-approved Operations**:
- Read access to this repository and `/tmp`
- Git commands (status, diff, log, add, commit, push, branch, show)
- Chezmoi commands (cd, apply, diff, data)
- Tmux integration scripts (state management, navigation)
- Brew read operations (list, search, info, install)
- Development tools (npm, yarn, make, nvim headless)
- Simple utilities (echo, wc, sort, date, pwd, etc.)

**Workflow Integration**: Glean MCP search and Atlassian plugin are enabled. Permission prompts are skipped when matched by allow rules (`skipAutoPermissionPrompt: true`).

**Key Files**:
- `private_dot_claude/settings.json.tmpl` - Permission rules and patterns

### Tool Usage Validation

**How it works**: A PreToolUse hook intercepts Bash tool calls and blocks patterns that should use native Claude Code tools instead. This enforces the tool preferences defined in the global CLAUDE.md.

**Validation Rules** (`private_dot_claude/hooks/executable_validate-tool-usage.sh.tmpl`):
- Blocks `cat >`, `echo >`, heredocs → Use Write tool
- Blocks inline scripts (`python <<`, `ruby <<`) → Use Write then Bash
- Blocks `cat`, `head`, `tail`, `less`, `bat` → Use Read tool
- Blocks `grep`, `rg`, `ag`, `ack` → Use Grep tool
- Blocks `find`, `ls -R`, `tree` → Use Glob tool
- Blocks `sed -i`, `awk -i` → Use Edit tool
- Blocks `cat *.json | jq` → Use Read + native parsing
- Blocks complex multi-stage jq pipelines → Use Read + native parsing

**Why**: Native tools provide better user experience, easier review, and avoid permission prompts. The hook runs before every tool execution and exits with code 1 to block disallowed patterns.

**Key Files**:
- `private_dot_claude/hooks/executable_validate-tool-usage.sh.tmpl` - Validation hook
- `private_dot_claude/settings.json.tmpl` - Hook configuration (PreToolUse section)

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

### OpenClaw (Claude Agent Daemon)

**How it works**: OpenClaw is a Claude agent orchestration daemon installed via Homebrew. It runs locally and exposes a gateway for agent interactions via Telegram, web UI (Tailscale serve), and iOS (Clawket app).

**Config managed by chezmoi** (`private_dot_openclaw/`):

| Source file | Target | Contents |
|---|---|---|
| `openclaw.json.tmpl` | `~/.openclaw/openclaw.json` | Main config: models, gateway, Telegram channel, MCP servers |
| `identity/device.json.tmpl` | `~/.openclaw/identity/device.json` | ed25519 device keypair |
| `private_devices/paired.json.tmpl` | `~/.openclaw/devices/paired.json` | Paired device registry + tokens |
| `credentials/telegram-pairing.json` | `~/.openclaw/credentials/telegram-pairing.json` | Pairing requests (static empty) |
| `credentials/telegram-default-allowFrom.json.tmpl` | `~/.openclaw/credentials/telegram-default-allowFrom.json` | Telegram allowlist |

**Secrets stored in macOS Keychain** (service=openclaw):

| account | description |
|---|---|
| `gateway_token` | Gateway auth token |
| `telegram_bot_token` | Telegram bot token |
| `tailscale_hostname` | Machine hostname in Tailscale (update per machine) |
| `telegram_group_id` | Telegram group ID |
| `telegram_allow_from` | Telegram user ID allowed to chat |

service=openclaw-identity: `device_json_b64` (base64 of device.json)
service=openclaw-devices: `paired_json_b64` (base64 of paired.json)

**Database backups** (agent memory + flow definitions → iCloud Drive):
```bash
openclaw-backup    # Run periodically; keeps last 5 snapshots in ~/Library/Mobile Documents/com~apple~CloudDocs/openclaw-backup/
openclaw-restore   # Restore most recent snapshot to ~/.openclaw/
```

**Seeding Keychain** (run once on each machine):
```bash
openclaw-seed-keychain   # Extracts from existing config, or prompts interactively
```

**Key files**:
- `private_dot_openclaw/` - Source directory (all OpenClaw config templates)
- `private_dot_local/bin/executable_openclaw-backup` - Database backup script
- `private_dot_local/bin/executable_openclaw-restore` - Database restore script
- `private_dot_local/bin/executable_openclaw-seed-keychain` - One-time Keychain seeder

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

### Hook Changes

After modifying hooks in `private_dot_claude/hooks/`:

```bash
# Apply hook changes
chezmoi apply ~/.claude/hooks/

# Test validation hook directly (should exit 0 for allowed, 1 for blocked)
~/.claude/hooks/validate-tool-usage.sh "Bash" '{"command":"cat file.txt"}'
~/.claude/hooks/validate-tool-usage.sh "Bash" '{"command":"git status"}'

# Restart Claude Code session to reload hooks
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
# 1. Prerequisites
xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install chezmoi

# 2. Clone dotfiles
chezmoi init https://github.com/nickhentschel/dotfiles.git

# 3. Seed Keychain BEFORE applying (OpenClaw templates need it)
#    On current Mac: openclaw-seed-keychain extracts values automatically
#    On fresh Mac:   it prompts interactively
chezmoi apply ~/.local/bin/openclaw-seed-keychain
openclaw-seed-keychain

# 4. Apply all dotfiles
chezmoi apply

# 5. Install packages
brew bundle

# 6. Restore OpenClaw memory + flow definitions from iCloud
openclaw-restore

# 7. Start OpenClaw and verify
openclaw
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
│       ├── executable_ai-cmd-gen.tmpl        # AI command generation backend
│       ├── executable_openclaw-backup        # Backup memory + flows to iCloud
│       ├── executable_openclaw-restore       # Restore memory + flows from iCloud
│       └── executable_openclaw-seed-keychain # One-time Keychain seeder
├── private_dot_openclaw/                     # OpenClaw config (Claude agent daemon)
│   ├── openclaw.json.tmpl                    # Main config (secrets from Keychain)
│   ├── identity/
│   │   └── device.json.tmpl                 # ed25519 keypair (from Keychain base64)
│   ├── private_devices/
│   │   └── paired.json.tmpl                 # Paired device tokens (from Keychain base64)
│   └── credentials/
│       ├── telegram-pairing.json             # Static (empty pairing requests)
│       └── telegram-default-allowFrom.json.tmpl
└── private_dot_claude/
    ├── settings.json.tmpl          # Claude Code settings (hooks, permissions)
    ├── hooks/
    │   └── executable_validate-tool-usage.sh.tmpl  # Tool usage enforcement
    ├── skills/
    │   └── chezmoi.md              # Chezmoi dotfiles safety skill
    └── CLAUDE.md                   # Global Claude Code instructions
```
