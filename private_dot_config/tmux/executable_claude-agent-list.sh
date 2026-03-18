#!/usr/bin/env bash
# claude-agent-list.sh - Interactive agent selector with fzf
# Bound to: prefix + g (Go to agent)

set -euo pipefail

STATE_SCRIPT="${HOME}/.config/tmux/claude-state.sh"

if [ ! -x "$STATE_SCRIPT" ]; then
    tmux display-message "Claude state script not found"
    exit 1
fi

# Get list of agents
agents=$("$STATE_SCRIPT" list 2>/dev/null)

if [ -z "$agents" ]; then
    tmux display-message "No Claude agents found"
    exit 0
fi

# Count agents
agent_count=$(echo "$agents" | wc -l | tr -d ' ')

if [ "$agent_count" -eq 1 ]; then
    # Only one agent, jump directly
    pane=$(echo "$agents" | awk '{print $1}')
    tmux select-pane -t "$pane"
    exit 0
fi

# Multiple agents - use fzf if available
if command -v fzf >/dev/null 2>&1; then
    # Format for fzf: "pane | agent_id | state | tool"
    selection=$(echo "$agents" | \
        awk '{printf "%-8s | %-12s | %-8s | %s\n", $1, substr($2,1,12), $3, $4}' | \
        fzf --height=40% \
            --header="Select Claude Agent (${agent_count} active)" \
            --border=rounded \
            --prompt="Agent> " \
            --preview-window=hidden \
            --no-info)

    if [ -n "$selection" ]; then
        pane=$(echo "$selection" | awk '{print $1}')
        tmux select-pane -t "$pane"
    fi
else
    # Fallback: Display in split pane
    tmux split-window -v -l 10 "echo '$agents' | awk '{printf \"Pane: %-8s  Agent: %-12s  State: %-8s  Tool: %s\n\", \$1, substr(\$2,1,12), \$3, \$4}' && echo '' && echo 'Press Enter to close' && read"
fi
