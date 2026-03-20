#!/usr/bin/env bash
# claude-tmux.sh - Unified tmux-native Claude Code integration
# Replaces: claude-state.sh, claude-agent-*.sh, claude-tool-track.sh
#
# State stored in tmux pane options (auto-cleanup when pane closes):
#   @claude_state  - idle/working/waiting
#   @claude_tool   - current tool name
#   @claude_id     - session ID (short)

set -euo pipefail

# Colors for status bar
COLOR_WORKING="#[fg=colour46]"   # Green
COLOR_WAITING="#[fg=colour226]"  # Yellow
COLOR_IDLE="#[fg=colour243]"     # Gray
COLOR_ICON="#[fg=colour39]"      # Blue
COLOR_RESET="#[fg=white]"

#-----------------------------------------------
# STATE MANAGEMENT (via tmux pane options)
#-----------------------------------------------

state_set() {
    local state="${1:-idle}"
    local tool="${2:-}"
    local pane="${TMUX_PANE:-}"
    local session_id="${CLAUDE_SESSION_ID:-}"

    [ -z "$pane" ] && return 0
    [ -z "$TMUX" ] && return 0

    # Store state in pane options
    tmux set-option -p -t "$pane" @claude_state "$state" 2>/dev/null || true

    if [ -n "$tool" ]; then
        tmux set-option -p -t "$pane" @claude_tool "$tool" 2>/dev/null || true
    else
        tmux set-option -p -t "$pane" -u @claude_tool 2>/dev/null || true
    fi

    if [ -n "$session_id" ]; then
        tmux set-option -p -t "$pane" @claude_id "${session_id: -8}" 2>/dev/null || true
    fi

    # Update pane border based on state
    case "$state" in
        working)
            tmux set-option -p -t "$pane" pane-border-style 'fg=colour46' 2>/dev/null || true
            ;;
        waiting)
            tmux set-option -p -t "$pane" pane-border-style 'fg=colour226,bold' 2>/dev/null || true
            ;;
        *)
            tmux set-option -p -t "$pane" pane-border-style 'fg=colour238' 2>/dev/null || true
            ;;
    esac
}

state_get() {
    local pane="${1:-$TMUX_PANE}"
    [ -z "$pane" ] && return 0
    [ -z "$TMUX" ] && return 0

    local state tool id
    state=$(tmux display -p -t "$pane" '#{@claude_state}' 2>/dev/null || echo "")
    tool=$(tmux display -p -t "$pane" '#{@claude_tool}' 2>/dev/null || echo "")
    id=$(tmux display -p -t "$pane" '#{@claude_id}' 2>/dev/null || echo "")

    echo "state=$state tool=$tool id=$id"
}

state_clear() {
    local pane="${1:-$TMUX_PANE}"
    [ -z "$pane" ] && return 0
    [ -z "$TMUX" ] && return 0

    tmux set-option -p -t "$pane" -u @claude_state 2>/dev/null || true
    tmux set-option -p -t "$pane" -u @claude_tool 2>/dev/null || true
    tmux set-option -p -t "$pane" -u @claude_id 2>/dev/null || true
    tmux set-option -p -t "$pane" pane-border-style 'fg=colour238' 2>/dev/null || true
}

#-----------------------------------------------
# AGENT DISCOVERY (scan all panes)
#-----------------------------------------------

list_agents() {
    [ -z "$TMUX" ] && return 0

    local filter_state="${1:-}"

    # Iterate all panes in all windows
    tmux list-panes -a -F '#{pane_id} #{window_index}.#{pane_index} #{@claude_state} #{@claude_tool} #{@claude_id}' 2>/dev/null | \
    while read -r pane_id pane_idx state tool id; do
        [ -z "$state" ] && continue
        [ "$filter_state" != "" ] && [ "$state" != "$filter_state" ] && continue
        echo "$pane_id	$pane_idx	$state	${tool:-idle}	${id:-unknown}"
    done
}

count_agents() {
    local total=0 working=0 waiting=0 idle=0

    while IFS=$'\t' read -r pane_id pane_idx state tool id; do
        [ -z "$state" ] && continue
        ((total++))
        case "$state" in
            working) ((working++)) ;;
            waiting) ((waiting++)) ;;
            idle) ((idle++)) ;;
        esac
    done < <(list_agents)

    echo "$total $working $waiting $idle"
}

#-----------------------------------------------
# NAVIGATION
#-----------------------------------------------

show_menu() {
    [ -z "$TMUX" ] && return 0

    local agents menu_args=()
    agents=$(list_agents)

    if [ -z "$agents" ]; then
        tmux display-message "No Claude agents found"
        return 0
    fi

    # Build menu entries
    local idx=1
    while IFS=$'\t' read -r pane_id pane_idx state tool id; do
        local label="Pane $pane_idx"
        [ -n "$id" ] && label="$label ($id)"

        case "$state" in
            working) label="$label - working [$tool]" ;;
            waiting) label="$label - WAITING [$tool]" ;;
            idle) label="$label - idle" ;;
        esac

        menu_args+=("$label" "$idx" "select-pane -t $pane_id")
        ((idx++))
    done <<< "$agents"

    # Add separator and cancel
    menu_args+=("" "" "")
    menu_args+=("Cancel" "q" "")

    tmux display-menu -T "Claude Agents" "${menu_args[@]}"
}

jump_next() {
    [ -z "$TMUX" ] && return 0

    # Try waiting first, then working
    local target
    target=$(list_agents "waiting" | head -n1)

    if [ -z "$target" ]; then
        target=$(list_agents "working" | head -n1)
    fi

    if [ -z "$target" ]; then
        tmux display-message "No agents waiting or working"
        return 0
    fi

    local pane_id state
    pane_id=$(echo "$target" | cut -f1)
    state=$(echo "$target" | cut -f3)

    tmux select-pane -t "$pane_id"
    tmux display-message "Jumped to $state agent"
}

#-----------------------------------------------
# STATUS OUTPUT
#-----------------------------------------------

show_summary() {
    [ -z "$TMUX" ] && return 0

    read -r total working waiting idle < <(count_agents)

    if [ "$total" -eq 0 ]; then
        tmux display-message "No Claude agents active"
        return 0
    fi

    local msg="Claude: $total agent(s)"
    [ "$working" -gt 0 ] && msg="$msg | $working working"
    [ "$waiting" -gt 0 ] && msg="$msg | $waiting WAITING"
    [ "$idle" -gt 0 ] && msg="$msg | $idle idle"

    tmux display-message "$msg"
}

status_bar() {
    [ -z "$TMUX" ] && return 0

    read -r total working waiting idle < <(count_agents)

    [ "$total" -eq 0 ] && return 0

    local output="${COLOR_ICON}C${COLOR_RESET}${total}"

    [ "$working" -gt 0 ] && output="$output ${COLOR_WORKING}${working}w"
    [ "$waiting" -gt 0 ] && output="$output ${COLOR_WAITING}${waiting}!"

    echo "$output "
}

#-----------------------------------------------
# PANE CAPTURE (for debugging/sharing)
#-----------------------------------------------

capture_pane() {
    [ -z "$TMUX" ] && return 0

    local lines="${1:-500}"
    local content
    content=$(tmux capture-pane -p -S "-$lines" 2>/dev/null)

    # Copy to clipboard
    if command -v pbcopy >/dev/null 2>&1; then
        echo "$content" | pbcopy
        tmux display-message "Captured $lines lines to clipboard"
    elif command -v xclip >/dev/null 2>&1; then
        echo "$content" | xclip -sel clip
        tmux display-message "Captured $lines lines to clipboard"
    else
        tmux display-message "No clipboard tool found"
        return 1
    fi
}

#-----------------------------------------------
# MAIN DISPATCHER
#-----------------------------------------------

case "${1:-help}" in
    state)
        case "${2:-}" in
            set)
                state_set "${3:-idle}" "${4:-}"
                ;;
            get)
                state_get "${3:-}"
                ;;
            clear)
                state_clear "${3:-}"
                ;;
            *)
                echo "Usage: $0 state {set|get|clear} [args...]" >&2
                exit 1
                ;;
        esac
        ;;
    menu)
        show_menu
        ;;
    next)
        jump_next
        ;;
    summary)
        show_summary
        ;;
    status)
        status_bar
        ;;
    capture)
        capture_pane "${2:-500}"
        ;;
    list)
        list_agents "${2:-}"
        ;;
    help|*)
        cat <<'EOF'
claude-tmux.sh - Tmux-native Claude Code integration

Commands:
  state set <state> [tool]  - Set pane state (idle/working/waiting)
  state get [pane]          - Get pane state
  state clear [pane]        - Clear pane state
  menu                      - Show agent selector (display-menu)
  next                      - Jump to next waiting/working agent
  summary                   - Show summary as tmux message
  status                    - Output for status bar
  capture [lines]           - Capture pane content to clipboard
  list [state]              - List agents (optionally filtered)

State is stored in tmux pane options (@claude_state, @claude_tool, @claude_id)
and automatically cleaned up when panes close.
EOF
        ;;
esac
