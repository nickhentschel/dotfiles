#!/usr/bin/env bash
# claude-state.sh - Central state manager for Claude Code agents in tmux
# Provides atomic operations for tracking agent state across multiple concurrent sessions

set -euo pipefail

STATE_FILE="${HOME}/.claude/agent-state.json"
LOCK_FILE="${HOME}/.claude/.agent-state.lock"
LOCK_TIMEOUT=5

# Acquire lock with timeout
acquire_lock() {
    local end=$((SECONDS + LOCK_TIMEOUT))
    while [ $SECONDS -lt $end ]; do
        if mkdir "$LOCK_FILE" 2>/dev/null; then
            trap 'rm -rf "$LOCK_FILE"' EXIT
            return 0
        fi
        sleep 0.1
    done
    echo "ERROR: Could not acquire lock after ${LOCK_TIMEOUT}s" >&2
    return 1
}

# Initialize state file
init_state() {
    mkdir -p "$(dirname "$STATE_FILE")"
    if [ ! -f "$STATE_FILE" ]; then
        cat > "$STATE_FILE" <<'EOF'
{
  "agents": {},
  "summary": {
    "total": 0,
    "working": 0,
    "waiting": 0,
    "idle": 0
  },
  "last_update": 0
}
EOF
        echo "Initialized state file: $STATE_FILE"
    else
        echo "State file already exists: $STATE_FILE"
    fi
}

# Register new agent
register_agent() {
    local agent_id="$1"
    local pane_id="${TMUX_PANE:-unknown}"
    local timestamp=$(date +%s)

    if ! command -v jq >/dev/null 2>&1; then
        echo "ERROR: jq not found" >&2
        return 1
    fi

    acquire_lock || return 1

    # Add agent to state
    jq --arg id "$agent_id" \
       --arg pane "$pane_id" \
       --argjson ts "$timestamp" \
       '.agents[$id] = {
          "state": "idle",
          "tool": null,
          "pane": $pane,
          "created": $ts,
          "updated": $ts
        } |
        .summary.total += 1 |
        .summary.idle += 1 |
        .last_update = $ts' \
       "$STATE_FILE" > "${STATE_FILE}.tmp" && mv "${STATE_FILE}.tmp" "$STATE_FILE"

    echo "Registered agent: $agent_id in pane $pane_id"
}

# Update agent state
update_agent() {
    local agent_id="$1"
    local new_state="$2"
    local tool="${3:-null}"
    local timestamp=$(date +%s)

    if ! command -v jq >/dev/null 2>&1; then
        echo "ERROR: jq not found" >&2
        return 1
    fi

    acquire_lock || return 1

    # Check if agent exists
    if ! jq -e ".agents[\"$agent_id\"]" "$STATE_FILE" >/dev/null 2>&1; then
        echo "ERROR: Agent $agent_id not found" >&2
        return 1
    fi

    # Get old state for counter adjustments
    local old_state=$(jq -r ".agents[\"$agent_id\"].state" "$STATE_FILE")

    # Update agent and adjust counters
    local tool_arg
    if [ "$tool" = "null" ]; then
        tool_arg="null"
    else
        tool_arg="\"$tool\""
    fi

    jq --arg id "$agent_id" \
       --arg state "$new_state" \
       --argjson tool "$tool_arg" \
       --argjson ts "$timestamp" \
       --arg old_state "$old_state" \
       '.agents[$id].state = $state |
        .agents[$id].tool = $tool |
        .agents[$id].updated = $ts |
        (if $old_state == "working" then .summary.working -= 1 else . end) |
        (if $old_state == "waiting" then .summary.waiting -= 1 else . end) |
        (if $old_state == "idle" then .summary.idle -= 1 else . end) |
        (if $state == "working" then .summary.working += 1 else . end) |
        (if $state == "waiting" then .summary.waiting += 1 else . end) |
        (if $state == "idle" then .summary.idle += 1 else . end) |
        .last_update = $ts' \
       "$STATE_FILE" > "${STATE_FILE}.tmp" && mv "${STATE_FILE}.tmp" "$STATE_FILE"

    echo "Updated agent $agent_id: $old_state -> $new_state (tool: $tool)"
}

# Remove agent
remove_agent() {
    local agent_id="$1"
    local timestamp=$(date +%s)

    if ! command -v jq >/dev/null 2>&1; then
        echo "ERROR: jq not found" >&2
        return 1
    fi

    acquire_lock || return 1

    # Check if agent exists
    if ! jq -e ".agents[\"$agent_id\"]" "$STATE_FILE" >/dev/null 2>&1; then
        echo "Agent $agent_id not found (may already be removed)"
        return 0
    fi

    # Get state for counter adjustment
    local state=$(jq -r ".agents[\"$agent_id\"].state" "$STATE_FILE")

    # Remove agent and adjust counters
    jq --arg id "$agent_id" \
       --argjson ts "$timestamp" \
       --arg state "$state" \
       'del(.agents[$id]) |
        .summary.total -= 1 |
        (if $state == "working" then .summary.working -= 1 else . end) |
        (if $state == "waiting" then .summary.waiting -= 1 else . end) |
        (if $state == "idle" then .summary.idle -= 1 else . end) |
        .last_update = $ts' \
       "$STATE_FILE" > "${STATE_FILE}.tmp" && mv "${STATE_FILE}.tmp" "$STATE_FILE"

    echo "Removed agent: $agent_id"
}

# Get current state summary
get_summary() {
    if ! command -v jq >/dev/null 2>&1; then
        echo "ERROR: jq not found" >&2
        return 1
    fi

    if [ ! -f "$STATE_FILE" ]; then
        echo "{}"
        return 0
    fi

    cat "$STATE_FILE"
}

# Get list of agents in specific state
list_agents() {
    local filter_state="${1:-}"

    if ! command -v jq >/dev/null 2>&1; then
        echo "ERROR: jq not found" >&2
        return 1
    fi

    if [ ! -f "$STATE_FILE" ]; then
        echo "[]"
        return 0
    fi

    if [ -z "$filter_state" ]; then
        jq -r '.agents | to_entries[] | "\(.value.pane)\t\(.key)\t\(.value.state)\t\(.value.tool // "idle")"' "$STATE_FILE"
    else
        jq -r --arg state "$filter_state" \
           '.agents | to_entries[] | select(.value.state == $state) | "\(.value.pane)\t\(.key)\t\(.value.state)\t\(.value.tool // "idle")"' \
           "$STATE_FILE"
    fi
}

# Main command dispatcher
case "${1:-}" in
    init)
        init_state
        ;;
    register)
        if [ $# -lt 2 ]; then
            echo "Usage: $0 register <agent-id>" >&2
            exit 1
        fi
        register_agent "$2"
        ;;
    update)
        if [ $# -lt 3 ]; then
            echo "Usage: $0 update <agent-id> <state> [tool]" >&2
            exit 1
        fi
        update_agent "$2" "$3" "${4:-null}"
        ;;
    remove)
        if [ $# -lt 2 ]; then
            echo "Usage: $0 remove <agent-id>" >&2
            exit 1
        fi
        remove_agent "$2"
        ;;
    summary)
        get_summary
        ;;
    list)
        list_agents "${2:-}"
        ;;
    *)
        echo "Usage: $0 {init|register|update|remove|summary|list} [args...]" >&2
        echo "" >&2
        echo "Commands:" >&2
        echo "  init                     - Initialize state file" >&2
        echo "  register <agent-id>      - Register new agent" >&2
        echo "  update <id> <state> [tool] - Update agent state (idle/working/waiting)" >&2
        echo "  remove <agent-id>        - Remove agent" >&2
        echo "  summary                  - Get current state as JSON" >&2
        echo "  list [state]             - List agents (optionally filtered by state)" >&2
        exit 1
        ;;
esac
