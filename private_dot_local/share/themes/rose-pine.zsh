# Rose Pine (Dark) theme for ZSH
# Prompt and completion colors

# Prompt colors - Rose Pine palette optimized for readability
export THEME_COLOR_DIR="109"              # pine (#31748f) - slightly brighter for visibility
export THEME_COLOR_GIT_BRANCH="152"       # foam (#9ccfd8)
export THEME_COLOR_GIT_DETACHED="248"     # subtle (#908caa) - brighter for visibility
export THEME_COLOR_VI_CMD="204"           # love (#eb6f92)
export THEME_COLOR_VI_INS="109"           # pine
export THEME_COLOR_SSH="248"              # subtle
export THEME_COLOR_HOST="152"             # foam
export THEME_COLOR_HOST_REMOTE="248"      # subtle
export THEME_COLOR_JOBS="204"             # love

# Completion menu colors (ANSI escape codes for zstyle)
export THEME_COMP_MESSAGES=$'\e[01;38;5;183m'     # iris (#c4a7e7) bold
export THEME_COMP_WARNINGS=$'\e[01;38;5;204m'    # love bold
export THEME_COMP_DESCRIPTIONS=$'\e[00;38;5;248m' # subtle - readable
export THEME_COMP_CORRECTIONS=$'\e[00;38;5;248m'  # subtle
export THEME_COMP_SELECT=$'\e[01;38;5;183m'       # iris bold
export THEME_COMP_RESET=$'\e[00;00m'

# Apply completion formatting
zstyle ':completion:*:messages' format "${THEME_COMP_MESSAGES} -- %d -- ${THEME_COMP_RESET}"
zstyle ':completion:*:warnings' format "${THEME_COMP_WARNINGS} -- No Matches Found -- ${THEME_COMP_RESET}"
zstyle ':completion:*:descriptions' format "${THEME_COMP_DESCRIPTIONS} -- %d -- ${THEME_COMP_RESET}"
zstyle ':completion:*:corrections' format "${THEME_COMP_CORRECTIONS} -- %d -- ${THEME_COMP_RESET}"
zstyle ':completion:*:default' select-prompt "${THEME_COMP_SELECT} -- Match %M    %P -- ${THEME_COMP_RESET}"
