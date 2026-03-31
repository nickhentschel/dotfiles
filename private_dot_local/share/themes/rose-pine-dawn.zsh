# Rose Pine Dawn (Light) theme for ZSH
# Prompt and completion colors

# Prompt colors - Rose Pine Dawn palette optimized for readability on light backgrounds
export THEME_COLOR_DIR="24"               # pine (#286983) - dark enough for light bg
export THEME_COLOR_GIT_BRANCH="30"        # foam (#56949f) - darker teal for contrast
export THEME_COLOR_GIT_DETACHED="96"      # muted (#9893a5) - visible on light
export THEME_COLOR_VI_CMD="132"           # love (#b4637a)
export THEME_COLOR_VI_INS="24"            # pine
export THEME_COLOR_SSH="96"               # muted
export THEME_COLOR_HOST="30"              # foam
export THEME_COLOR_HOST_REMOTE="96"       # muted
export THEME_COLOR_JOBS="132"             # love

# Completion menu colors (ANSI escape codes for zstyle) - darker for light backgrounds
export THEME_COMP_MESSAGES=$'\e[00;38;5;97m'     # iris (#907aa9)
export THEME_COMP_WARNINGS=$'\e[00;38;5;132m'   # love
export THEME_COMP_DESCRIPTIONS=$'\e[00;38;5;60m' # text (#575279)
export THEME_COMP_CORRECTIONS=$'\e[00;38;5;60m'  # text
export THEME_COMP_SELECT=$'\e[00;38;5;97m'       # iris
export THEME_COMP_RESET=$'\e[00;00m'

# Apply completion formatting
zstyle ':completion:*:messages' format "${THEME_COMP_MESSAGES} -- %d -- ${THEME_COMP_RESET}"
zstyle ':completion:*:warnings' format "${THEME_COMP_WARNINGS} -- No Matches Found -- ${THEME_COMP_RESET}"
zstyle ':completion:*:descriptions' format "${THEME_COMP_DESCRIPTIONS} -- %d -- ${THEME_COMP_RESET}"
zstyle ':completion:*:corrections' format "${THEME_COMP_CORRECTIONS} -- %d -- ${THEME_COMP_RESET}"
zstyle ':completion:*:default' select-prompt "${THEME_COMP_SELECT} -- Match %M    %P -- ${THEME_COMP_RESET}"
