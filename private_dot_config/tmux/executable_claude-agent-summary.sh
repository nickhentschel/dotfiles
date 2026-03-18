#!/usr/bin/env bash
# claude-agent-summary.sh - Show detailed agent summary
# Bound to: prefix + s (Summary)

set -euo pipefail

STATE_SCRIPT="${HOME}/.config/tmux/claude-state.sh"

if [ ! -x "$STATE_SCRIPT" ]; then
    echo "ERROR: Claude state script not found"
    exit 1
fi

# Get summary
summary=$("$STATE_SCRIPT" summary 2>/dev/null)

if [ -z "$summary" ]; then
    echo "ERROR: Could not read state"
    exit 1
fi

# Check if jq is available
if ! command -v jq >/dev/null 2>&1; then
    echo "ERROR: jq not found"
    exit 1
fi

# Extract summary stats
total=$(echo "$summary" | jq -r '.summary.total')
working=$(echo "$summary" | jq -r '.summary.working')
waiting=$(echo "$summary" | jq -r '.summary.waiting')
idle=$(echo "$summary" | jq -r '.summary.idle')

# Build output
output="=== Claude Code Agent Summary ===\n"
output="${output}Total Agents: ${total}\n"
output="${output}Working: ${working} ⚡\n"
output="${output}Waiting: ${waiting} ⏸\n"
output="${output}Idle: ${idle} 💤\n"

if [ "$total" -gt 0 ]; then
    output="${output}\n=== Active Agents ===\n"

    # Get agent list
    agents=$("$STATE_SCRIPT" list 2>/dev/null)

    while IFS=$'\t' read -r pane agent_id state tool; do
        short_id=$(echo "$agent_id" | tail -c 13)
        output="${output}[${state}] ${short_id} in pane ${pane}"
        if [ "$tool" != "idle" ] && [ "$tool" != "null" ]; then
            output="${output} - ${tool}"
        fi
        output="${output}\n"
    done <<< "$agents"
fi

# Display in popup if tmux 3.2+, otherwise split pane
tmux_version=$(tmux -V | cut -d' ' -f2)
if [ "$(printf '%s\n3.2\n' "$tmux_version" | sort -V | head -n1)" = "3.2" ]; then
    # Use popup (tmux 3.2+)
    echo -e "$output" | tmux display-popup -E -w 60 -h 15
else
    # Fallback to split pane
    tmux split-window -v -l 15 "echo -e '$output' && echo '' && echo 'Press Enter to close' && read"
fi
