# Builder Workflow — Claude Code Global Config

## User Info
- **Name**: Nick Hentschel
- **Identity**: Senior Engineering Manager - Public Cloud Foundations

---

## Delivery Standards

- **Small Batch**: ≤15 files or ≤400 lines net change per commit
- **Self-verify**: Run lint/build/test before declaring done—read output to confirm PASS
- **Tests**: Must work offline (use mocks/fixtures)

### Handoff Checklist (before session-end)
- [ ] Code committed and passes lint/build/test
- [ ] Remaining issues and improvements noted

---

## Collaboration Preferences

- Act as advisor and devil's advocate—proactively point out blind spots
- **Auto-execute**: P0/P1 bugs, bug fixes, ≤100 line refactors
- **Auto-intercept**:
  * **New project/service** → Ask: "Can a platform service replace self-hosting?"
  * **Tech stack choices** → Prefer low-scaffolding (single feature ≤200 lines, single service ≤3000 lines)
- **Require confirmation** (stop and check in):
  * Tech stack choices (framework/library/architecture)
  * Data model changes (schema/API contract)
  * Account/wallet/fund flow changes
  * Features outside roadmap
  * >100 line refactors
  * Trade-offs (performance vs maintainability)
- **Never self-decide**: Delete projects, production deploys, fund operations

---

## Tmux Multi-Agent Integration

When running in tmux, Claude Code has native integration for multi-agent workflows.

### State Management
```bash
~/.config/tmux/claude-tmux.sh state get    # Check current pane state
~/.config/tmux/claude-tmux.sh list         # View all agents
~/.config/tmux/claude-tmux.sh status       # Status bar: C<total> <working>w <waiting>!
```

### Spawning Parallel Agents
```bash
tmux split-window -h -c '#{pane_current_path}' claude  # Or use prefix+N
```

### Agent Navigation
| Command | Action |
|---------|--------|
| `~/.config/tmux/claude-tmux.sh menu` | Agent selector (prefix+g) |
| `~/.config/tmux/claude-tmux.sh next` | Jump to waiting agent (prefix+n) |
| `~/.config/tmux/claude-tmux.sh summary` | Agent summary (prefix+s) |

### When to Use Multiple Agents
- Parallel research while main agent codes
- Long-running tasks (builds/tests) in background
- Independent subtasks without dependencies

### Pane Border Colors
| Color | State |
|-------|-------|
| Gray | Idle |
| Green | Working |
| Yellow (bold) | Waiting for permission |
| Red (bold) | Error |

---

*Last updated: 2026-03-23*
