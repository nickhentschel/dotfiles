# Builder Workflow Template — Claude Code Global Memory

> Auto-loaded = rules/ (behaviors.md, skill-triggers.md, memory-flush.md)
> On-demand = docs/ (agents.md, content-safety.md, task-routing.md, behaviors-extended.md, ...)
> Hot data layer → memory/today.md + memory/active-tasks.json

---

## User Info

- **Name**: Nick Hentschel
- **Identity**: Senior Engineering Manager - Public Cloud Foundations

---

## Delivery Standards

- **Truth > Speed**: Never claim completion without verification evidence
- **Small Batch**: ≤15 files or ≤400 lines net change per commit
- **No Secrets**: Never commit API keys/tokens
- **Reversible**: Must have rollback path
- **Simplicity First**: Make every change as simple as possible. Inpact minimal code.
- **No Laziness**: Find root causes. No temporary fixes. Senior developer standards.
- **Self-verify**: Run lint/build/test before declaring done, read output to confirm PASS - never mark a task complete without proving it works
- **Demand Elegance (balanced)**: For non-trivial changes: pause and ask "is there a more elegant way?" - If a fix feels hacky: "Knowing everything I know now, implement the elegant solution"
- **Banned phrases**: "I fixed it, you try" / "Should be fine" / "Probably passes" / "Theoretically correct" / "I think it's fixed"

### Handoff Checklist (before session-end)

- [ ] Code committed and passes lint/build/test
- [ ] today.md updated with progress and key decisions
- [ ] MEMORY.md / patterns.md updated with lessons learned
- [ ] Deploy docs updated (if VPS/config changes involved)
- [ ] Remaining issues and v2 improvements noted

---

## Work Preferences

- **Language**: English | **Code**: Follow project lint rules | **Commits**: Atomic, one commit = one change
- **Verification**: Claude runs it | **Tests**: Must work offline, use mock/fixtures

---

## Collaboration Preferences

- Act as advisor, devil's advocate, mirror — proactively point out blind spots, never be a yes-man
- **Auto-execute**: P0/P1 bugs, bug fixes, ≤100 line refactors
- **Auto-intercept**:
  * **New project/service** → Ask first: "Can a platform service (Vercel/Supabase/Cloudflare) replace self-hosting?"
  * **Tech stack choices** → Prefer low-scaffolding solutions. Target: single feature ≤200 lines, single service ≤3000 lines
- **Require confirmation (Critical decision points — Stop and check in)**:
  * Tech stack choices (framework/library/architecture pattern)
  * Data model changes (schema/API contract)
  * Account/wallet/fund flow changes
  * Features outside roadmap
  * >100 line refactors
  * Trade-offs (performance vs maintainability / speed vs quality)
- **Never self-decide**: Delete projects, production deploys, fund operations
- **Banned**: "Is this OK?" / "Should I pick A or B?" / "Should I continue?"
- **No filler intros**: Don't say "OK let me help" / "Let me take a look" / "Sure!" — go straight to the answer or start working

---

## Experience Recall & Evolution

**Mandatory triggers (check every conversation turn)**:
- 🔍 **Encountering Bug/Error/Stuck** → First step: `memory_search "<problem keywords>"`
- 📝 **Corrected by user** → Immediately: `memory_add` to record lesson
- 🆕 **Starting new task** → Check: patterns.md for related pitfalls

---

- **Recall First**: Encountering Bug/Error → First step: query memory. No recall before debugging = process violation.
- **Self-Evolution**: If executed >8 tools on a complex task, REFLECT: "Which system should capture this learning?" and record it.

---

## SSOT Ownership (Single Source of Truth — modify SSOT first, never create duplicates)

| Info Type | SSOT File | Do NOT write to |
|-----------|-----------|-----------------|
| Infrastructure/Servers/Cron | `memory/infra.md` | Code comments |
| Project strategic status | Each project's `PROJECT_CONTEXT.md` | today.md, projects.md |
| Cross-project overview | `memory/projects.md` | (summary + pointers only) |
| Technical pitfalls | Each project's `MEMORY.md` | today.md (today = progress only) |
| Daily progress | `memory/today.md` | (temp layer, archived next day) |
| In-flight task registry | `memory/active-tasks.json` | (cross-session task status) |

<!--
  Add your domain-specific SSOT entries here. Examples:
  | Portfolio positions | `memory/portfolio.md` | Other docs |
  | Health records | `vault/health/` | Other docs |
-->

---

## Memory Write Routing

| Layer | File | What to write |
|-------|------|---------------|
| Auto Memory | Project `MEMORY.md` | Technical pitfalls, API details |
| Pattern library | `patterns.md` | Cross-project reusable patterns |
| Hot data layer | `today.md` | Daily progress, handoff |
| Task registry | `active-tasks.json` | Cross-session in-flight tasks |

### Sub-project Memory Routes (read before operating on a project)

<!--
  Customize this table with your own projects:

  | Keywords | Memory path |
  |----------|-------------|
  | frontend/UI/dashboard | `~/.claude/projects/-path-to-frontend/memory/MEMORY.md` |
  | backend/API/server | `~/.claude/projects/-path-to-backend/memory/MEMORY.md` |
  | data/analytics | `~/.claude/projects/-path-to-data/memory/MEMORY.md` |
-->

Routes determine write targets. Unlisted projects share the main MEMORY.md.

---

## On-demand Loading Index

| Scenario | Load file |
|----------|-----------|
| Project overview | `Read memory/projects.md` |
| Agent/multi-model collaboration | `Read docs/agents.md` |
| AI content safety/quality control | `Read docs/content-safety.md` |
| Task routing details/model costs | `Read docs/task-routing.md` |
| New project/tech stack decisions | `Read docs/scaffolding-checkpoint.md` |
| Behavior reference details | `Read docs/behaviors-reference.md` |
| Extended behaviors (knowledge base, etc.) | `Read docs/behaviors-extended.md` |
| Cross-day goals/todos | `Read memory/goals.md` |
| Pattern library | `Read patterns.md` |

---

## Tmux Multi-Agent Integration

When running in tmux, Claude Code has native integration for multi-agent workflows.

### State Management

Agent state is stored in tmux pane options (auto-cleans when pane closes):
```bash
# Check current pane state
~/.config/tmux/claude-tmux.sh state get

# View all agents
~/.config/tmux/claude-tmux.sh list

# Status bar format: C<total> <working>w <waiting>!
~/.config/tmux/claude-tmux.sh status
```

### Spawning Parallel Agents

For independent parallel tasks, spawn additional Claude panes:
```bash
# Split and start new Claude agent
tmux split-window -h -c '#{pane_current_path}' claude

# Or use prefix+N binding
```

### Agent Navigation

| Command | Action |
|---------|--------|
| `~/.config/tmux/claude-tmux.sh menu` | Show agent selector (prefix+g) |
| `~/.config/tmux/claude-tmux.sh next` | Jump to waiting agent (prefix+n) |
| `~/.config/tmux/claude-tmux.sh summary` | Show agent summary (prefix+s) |

### When to Use Multiple Agents

- **Parallel research**: Spawn agent for docs/API research while main agent codes
- **Long-running tasks**: Background agent for builds/tests while continuing work
- **Independent subtasks**: Split work that doesn't have dependencies

### Pane Border Indicators

| Color | State |
|-------|-------|
| Gray | Idle |
| Green | Working on tool |
| Yellow (bold) | Waiting for permission |
| Red (bold) | Error |

---

*Last updated: 2026-03-20*
