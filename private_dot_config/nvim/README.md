# Neovim Configuration

Lua-based Neovim config using [lazy.nvim](https://github.com/folke/lazy.nvim) for plugin management.
Plugins install automatically on first launch — no manual setup script needed.

## File Structure

```
~/.config/nvim/
├── init.lua                  # Entry point: lazy.nvim bootstrap + module imports
├── vscode.vim                # Separate config for VSCode/Cursor Neovim extension
└── lua/
    ├── settings.lua          # All vim.opt.* options and autocommands
    ├── keymaps.lua           # All key mappings
    └── plugins/
        ├── core.lua          # tpope suite, vim-tmux-navigator, tabular, fzf
        ├── ui.lua            # lualine, nvim-tree, indent-blankline, codedark theme
        ├── editor.lua        # nvim-autopairs, vim-go, vim-polyglot, ALE
        └── claude.lua        # codecompanion.nvim (Claude AI integration)
```

## Bootstrap

Open `nvim` — lazy.nvim clones itself on first run, then installs all plugins automatically.
After the initial sync completes, restart nvim.

To manually manage plugins:

```
:Lazy          # open plugin manager UI
:Lazy sync     # update all plugins
:Lazy clean    # remove unused plugins
```

## Plugins

### Core

| Plugin | Purpose |
|---|---|
| `tpope/vim-commentary` | `gc` to toggle comments |
| `tpope/vim-endwise` | Auto-close `end`/`endif`/etc. |
| `tpope/vim-repeat` | Repeat plugin actions with `.` |
| `tpope/vim-sleuth` | Auto-detect indentation from file |
| `tpope/vim-surround` | `cs`, `ds`, `ys` to change/delete/add surrounds |
| `tpope/vim-unimpaired` | `[`/`]` pairs for common navigation |
| `christoomey/vim-tmux-navigator` | `<C-h/j/k/l>` seamless pane navigation |
| `godlygeek/tabular` | Align text on a delimiter |
| `junegunn/fzf` + `fzf.vim` | Fuzzy finder for files, buffers, grep |

### UI

| Plugin | Purpose |
|---|---|
| `tomasiser/vim-code-dark` | Active colorscheme (GitHub dark-style) |
| `nvim-lualine/lualine.nvim` | Status bar |
| `nvim-tree/nvim-tree.lua` | File explorer sidebar |
| `lukas-reineke/indent-blankline.nvim` | Indent guide lines |
| `nvim-tree/nvim-web-devicons` | Icons for nvim-tree and lualine |

### Editor

| Plugin | Purpose |
|---|---|
| `windwp/nvim-autopairs` | Auto-close brackets/quotes |
| `fatih/vim-go` | Go tooling (lazy-loaded on `.go` files); handles `gofmt` on save |
| `sheerun/vim-polyglot` | Syntax for 100+ languages (replaces 9 individual plugins) |
| `dense-analysis/ale` | Async linting (see ALE section below) |

### AI

| Plugin | Purpose |
|---|---|
| `olimorris/codecompanion.nvim` | Claude AI chat and inline assist |

## Key Mappings

Leader key: `<Space>`

### Navigation

| Key | Action |
|---|---|
| `<C-p>` | FZF file finder |
| `<C-o>` | FZF buffer list |
| `<C-i>` | FZF ripgrep search (`:Find`) |
| `<C-h/j/k/l>` | Navigate vim splits and tmux panes |
| `gt` / `gT` | Next / previous buffer |
| `<C-c>` | Close current buffer |

### Editing

| Key | Action |
|---|---|
| `jk` | Exit insert mode |
| `<C-s>` | Save (insert, normal, visual) |
| `<Leader>=` | Tabularize on `=` |
| `<Leader>>` | Tabularize on `=>` |
| `Y` | Yank to end of line |
| `c*` / `c#` | Change word under cursor (repeatable with `.`) |
| `zj` / `zk` | Insert blank line below/above without entering insert |
| `g=` | Re-indent entire file, restore cursor |
| `gQ` | Hard-wrap entire file, restore cursor |

### Tools

| Key | Action |
|---|---|
| `<Leader>t` | Toggle nvim-tree file explorer |
| `<Leader>f` | ALEFix (format current file) |
| `<Leader>cc` | Toggle CodeCompanion chat panel |
| `<Leader>ca` | CodeCompanion actions menu |

### Misc

| Key | Action |
|---|---|
| `;` / `:` | Swapped — `;` opens command line |
| `n` / `N` | Search next/prev, centered |
| `<C-q>` | `<C-a>` increment (frees `<C-a>` for tmux) |
| `w!!` | Write file as sudo |

## ALE (Linting)

Linters are explicit — ALE only runs what's listed:

| Filetype | Linter | Install |
|---|---|---|
| `sh` | shellcheck | `brew install shellcheck` |
| `yaml` | yamllint | `pip install yamllint` |
| `dockerfile` | hadolint | `brew install hadolint` |

Errors appear in the location list (`:lopen`). Quickfix is disabled.

## CodeCompanion (Claude)

Requires `ANTHROPIC_API_KEY` in the environment. Add to `~/.zshenv`:

```zsh
export ANTHROPIC_API_KEY="sk-ant-..."
```

Note: this is separate from Claude Code CLI auth, which manages its own credentials.

- `<Leader>cc` — open/close chat panel
- `<Leader>ca` — action menu (explain, refactor, generate tests, etc.)

## VSCode / Cursor

`vscode.vim` is loaded instead of `init.lua` when running inside the VSCode Neovim extension.
It has its own minimal plugin set managed separately via `setup_plugins.sh`.
