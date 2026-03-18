#!/usr/bin/env bash
# claude-agent-start.sh - Register agent when started
# Called by SubagentStart hook

set -euo pipefail

AGENT_ID="${CLAUDE_SESSION_ID:-}"

if [ -z "$AGENT_ID" ]; then
    exit 0
fi

STATE_SCRIPT="${HOME}/.config/tmux/claude-state.sh"

if [ ! -x "$STATE_SCRIPT" ]; then
    exit 0
fi

"$STATE_SCRIPT" register "$AGENT_ID" 2>/dev/null || true
