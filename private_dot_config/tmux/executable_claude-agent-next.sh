#!/usr/bin/env bash
# claude-agent-next.sh - Jump to next agent in "waiting" state
# Bound to: prefix + n (Next agent)

set -euo pipefail

STATE_SCRIPT="${HOME}/.config/tmux/claude-state.sh"

if [ ! -x "$STATE_SCRIPT" ]; then
    tmux display-message "Claude state script not found"
    exit 1
fi

# Get first waiting agent
waiting_agent=$("$STATE_SCRIPT" list waiting 2>/dev/null | head -n 1)

if [ -z "$waiting_agent" ]; then
    # No waiting agents, try working agents
    working_agent=$("$STATE_SCRIPT" list working 2>/dev/null | head -n 1)

    if [ -z "$working_agent" ]; then
        tmux display-message "No agents waiting or working"
        exit 0
    fi

    pane=$(echo "$working_agent" | awk '{print $1}')
    state=$(echo "$working_agent" | awk '{print $3}')
    tmux select-pane -t "$pane"
    tmux display-message "Jumped to agent in state: $state"
else
    pane=$(echo "$waiting_agent" | awk '{print $1}')
    tmux select-pane -t "$pane"
    tmux display-message "Jumped to waiting agent in pane $pane"
fi
