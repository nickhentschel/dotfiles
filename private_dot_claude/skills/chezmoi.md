# Chezmoi Dotfiles Safety Skill

## Purpose

Prevent the critical mistake of editing target files directly instead of their chezmoi source files. Guide proper chezmoi workflows for this dotfiles repository.

## When to Use

**Proactively intercept when:**
- User asks to edit/modify a dotfile path in home directory that's managed by chezmoi
- User runs Edit/Write tool on paths like `~/.zshrc`, `~/.tmux.conf`, `~/.config/nvim/*`, `~/.gitconfig`, etc.
- User asks to "change my zsh config", "update tmux settings", etc. without specifying source path

**After source file edits:**
- Suggest `chezmoi apply` to activate changes
- For template files (`.tmpl`), offer to show diff before applying

**Template workflow assistance:**
- User modifying `.tmpl` files and needs to test output
- Uncertain about template syntax or available variables

## What This Skill Does

### 1. Redirect Target → Source

When user attempts to edit a managed dotfile in home directory:

```
User: "Edit ~/.zshrc to add an alias"

✅ Skill response:
"That file is managed by chezmoi. I'll edit the source file instead:
/Users/nickhe/.local/share/chezmoi/dot_zshrc

After changes, I'll run `chezmoi apply ~/.zshrc` to activate them."

[Then proceed with Edit on dot_zshrc]
```

**Common target → source mappings:**
- `~/.zshrc` → `dot_zshrc`
- `~/.tmux.conf` → `dot_tmux.conf.tmpl`
- `~/.gitconfig` → `dot_gitconfig.tmpl`
- `~/.config/nvim/init.lua` → `private_dot_config/nvim/init.lua`
- `~/.config/tmux/claude-tmux.sh` → `private_dot_config/tmux/executable_claude-tmux.sh`
- `~/.local/bin/ai-cmd-gen` → `private_dot_local/bin/executable_ai-cmd-gen.tmpl`
- `~/.claude/settings.json` → `private_dot_claude/settings.json.tmpl`

### 2. Post-Edit Workflow

After editing source files in this repository:

```
✅ After editing dot_zshrc:
"Changes made to dot_zshrc. To activate:

chezmoi apply ~/.zshrc
exec zsh  # Reload shell

Should I run these?"
```

```
✅ After editing dot_tmux.conf.tmpl:
"Changes made to template. Preview diff before applying?

chezmoi diff ~/.tmux.conf   # See what would change
chezmoi apply ~/.tmux.conf  # Apply
tmux source ~/.tmux.conf    # Reload

Should I proceed?"
```

**Apply strategies by component:**
- ZSH: `chezmoi apply ~/.zshrc && exec zsh`
- Tmux: `chezmoi apply ~/.tmux.conf && tmux source ~/.tmux.conf`
- Neovim: `chezmoi apply ~/.config/nvim/` (restart nvim to load)
- Claude Code settings: `chezmoi apply ~/.claude/settings.json` (restart Claude session)

### 3. Template Workflow Assistance

For `.tmpl` files, guide the proper testing workflow:

```
User: "I modified dot_gitconfig.tmpl but want to see the output"

✅ Skill response:
"To preview template output without applying:

chezmoi execute-template < dot_gitconfig.tmpl

To see what would change in target:

chezmoi diff ~/.gitconfig

To apply:

chezmoi apply ~/.gitconfig

Want me to show the preview first?"
```

**Template debugging:**
- Show available variables: `chezmoi data`
- Test template syntax: `chezmoi execute-template < file.tmpl`
- Preview changes: `chezmoi diff <target-path>`

### 4. File Naming Translation

Help translate chezmoi naming conventions:

```
User: "Add a new executable script at ~/.local/bin/myscript"

✅ Skill response:
"I'll create the source file with proper chezmoi naming:

private_dot_local/bin/executable_myscript

The prefixes mean:
- private_ → excluded from diffs/viewing
- executable_ → gets +x permissions

After creating, I'll run `chezmoi apply ~/.local/bin/myscript`"
```

**Naming rules:**
- `dot_` → `.` prefix in target
- `private_` → excluded from external viewing
- `executable_` → gets +x permissions
- `.tmpl` suffix → processed as Go template

## What This Skill Does NOT Do

**Out of scope:**
- Explaining basic chezmoi concepts (CLAUDE.md covers this comprehensively)
- Complex migrations or initialization (one-time setup operations)
- Repository sync operations (`chezmoi init`, `chezmoi update`)
- Adding new files to chezmoi (straightforward: `chezmoi add <file>`)

**Trust the documentation for:**
- Architecture details (see CLAUDE.md Architecture section)
- Template syntax and variables (see CLAUDE.md Template System section)
- Debugging commands (see CLAUDE.md Common Tasks section)

## Implementation Guidelines

**Be proactive but not annoying:**
- ✅ Auto-redirect target edits without asking
- ✅ Suggest apply after edits (but let user decide)
- ❌ Don't block or warn on every chezmoi operation
- ❌ Don't repeat explanations user already knows

**When in doubt:**
- Check if path starts with `~/` and matches a known dotfile → redirect to source
- After editing files in this repo → suggest apply if appropriate
- Template files being edited → offer to preview/diff

**Error recovery:**
- If user edited target file directly: "Changes to target will be overwritten. Copy to source instead?"
- If apply fails: Show error, suggest `chezmoi diff` to debug
- If uncertain about mapping: `chezmoi managed | grep <filename>` to find source

## Success Metrics

This skill is working well if it:
- Catches >90% of accidental target file edit attempts before they happen
- Makes the "edit source → apply → test" cycle feel natural
- Saves time on template debugging workflows
- Never feels intrusive or over-explanatory
