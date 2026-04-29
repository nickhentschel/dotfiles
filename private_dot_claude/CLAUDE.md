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

## Tool Rules (enforced by pre-tool hook)

These are **hard rules**, not preferences. A hook blocks violations before execution.

| Task | Required tool | Prohibited Bash equivalents |
|------|--------------|----------------------------|
| Read a file | `Read` | `cat`, `head`, `tail`, `less`, `bat` |
| Search file contents | `Grep` | `grep`, `rg`, `ag`, `ack` |
| Find / list files | `Glob` | `ls`, `find`, `tree` |
| Edit a file | `Edit` | `sed -i`, `awk -i` |
| Create a file | `Write` | `echo >`, `cat >`, heredocs |
| Bash for everything else | `Bash` | — |

**These apply everywhere** — including inside `$(...)` subshells, `&&` chains, and loop bodies like `for f in $(ls ...); do head ...`. The hook catches all of these.

**JSON**: Use `Read` to load JSON files, then reason over the content directly. Simple `jq '.field'` one-liners are OK in scripts. Multi-stage `jq` pipelines (`select | map | ...`) are blocked.

**Never** use Python/Node/Ruby for text formatting, JSON parsing, or data transformation — output results as formatted text directly.

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

## Skills Reference

Invoke with `/skill-name` syntax. Use these at the described trigger points.

### Daily / Recurring
- **`/slack:standup`** — Generate standup from Slack activity. Run each morning before standup.
- **`/program-status-updates`** — Generate status update for a Jira epic or feature. Use before stakeholder reviews and MBRs.

### Jira / Atlassian

**Rule: For ANY Jira task — lookup, search, create, update, transition, comment — invoke `/jira-cli` first. Never use Glean for Jira; it is context-heavy and Jira data is better accessed directly via acli.**

- **`/jira-cli`** — Reference guide for acli (Atlassian CLI): JQL patterns, field limitations, data extraction. **Invoke whenever a task involves Jira tickets, issues, epics, sprints, or boards.**
- **`/atlassian-groom-backlog`** — Analyze ZNET or INFRA backlog against OKRs, sort into grooming categories. Use before sprint planning.
- **`/atlassian-classify-tickets`** — Classify Jira tickets by product category. Use for bulk tagging/cleanup.

### Email & Google Workspace

**Rule: For email search and Google Workspace queries, use `/gws-cli` with `gws gmail` commands instead of Glean's `gmail_search` MCP tool. Glean email results are context-heavy; gws returns compact, structured output.**

- **`/gws-cli`** — Reference guide for Google Workspace CLI (gws): Drive, Gmail, Calendar, Sheets, Docs. **Invoke whenever a task involves searching email, finding calendar events, or accessing Google Workspace data.**

### Research & Analysis
- **`/research`** → **`/research-deep`** — For strategic analysis (vendor evals, feasibility studies, benchmarking). Start with `/research` to outline, then `/research-deep` for parallel deep-dives.
- **`/glean-guard`** — **Always invoke before any Glean MCP call (except email — use `/gws-cli` instead).** Prevents context blowout from large search results.

### Documentation
- **`/doc-coauthoring`** — Structured workflow for co-authoring docs, proposals, charters, and specs.
- **`/review`** — PR review with code quality analysis.

### Context Management
- **`/compact`** — Run when session exceeds ~30 min or context feels heavy. Preserves key decisions while freeing context window.

---

*Last updated: 2026-04-28*

