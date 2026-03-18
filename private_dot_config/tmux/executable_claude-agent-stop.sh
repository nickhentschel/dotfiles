#!/usr/bin/env bash
# claude-agent-stop.sh - Remove agent when stopped
# Called by SubagentStop and Stop hooks

set -euo pipefail

AGENT_ID="${CLAUDE_SESSION_ID:-}"

if [ -z "$AGENT_ID" ]; then
    exit 0
fi

STATE_SCRIPT="${HOME}/.config/tmux/claude-state.sh"

if [ ! -x "$STATE_SCRIPT" ]; then
    exit 0
fi

"$STATE_SCRIPT" remove "$AGENT_ID" 2>/dev/null || true
