#!/usr/bin/env bash
# claude-tool-track.sh - Track tool usage and update agent state
# Called by PreToolUse and PostToolUse hooks

set -euo pipefail

AGENT_ID="${CLAUDE_SESSION_ID:-}"
TOOL_NAME="${CLAUDE_TOOL_NAME:-unknown}"
HOOK_TYPE="${CLAUDE_HOOK_TYPE:-}"

if [ -z "$AGENT_ID" ]; then
    exit 0
fi

STATE_SCRIPT="${HOME}/.config/tmux/claude-state.sh"

if [ ! -x "$STATE_SCRIPT" ]; then
    exit 0
fi

case "$HOOK_TYPE" in
    PreToolUse)
        # Agent is working on a tool
        "$STATE_SCRIPT" update "$AGENT_ID" working "$TOOL_NAME" 2>/dev/null || true
        ;;
    PostToolUse)
        # Tool completed, agent is idle
        "$STATE_SCRIPT" update "$AGENT_ID" idle null 2>/dev/null || true
        ;;
esac
