# OneDark theme for ZSH
# Based on OneDark palette - https://github.com/navarasu/onedark.nvim

# Prompt colors - using 256-color approximations of OneDark hex values
# blue: #61afef (75), purple: #c678dd (176), green: #98c379 (114)
# yellow: #e5c07b (180), cyan: #56b6c2 (73), red: #e86671 (204)
# orange: #d19a66 (173), grey: #5c6370 (243), light_grey: #848b98 (245)

export THEME_COLOR_DIR="75"               # blue (#61afef) - directories
export THEME_COLOR_GIT_BRANCH="114"       # green (#98c379) - git branch
export THEME_COLOR_GIT_DETACHED="243"     # grey (#5c6370) - detached state
export THEME_COLOR_VI_CMD="204"           # red (#e86671) - command mode
export THEME_COLOR_VI_INS="180"           # yellow (#e5c07b) - insert mode
export THEME_COLOR_SSH="173"              # orange (#d19a66) - SSH indicator
export THEME_COLOR_HOST="114"             # green (#98c379) - username
export THEME_COLOR_HOST_REMOTE="245"      # light_grey (#848b98) - remote host
export THEME_COLOR_JOBS="204"             # red (#e86671) - background jobs

# Completion menu colors (ANSI escape codes for zstyle)
export THEME_COMP_MESSAGES=$'\e[01;38;5;75m'      # blue bold
export THEME_COMP_WARNINGS=$'\e[01;38;5;204m'    # red bold
export THEME_COMP_DESCRIPTIONS=$'\e[00;38;5;243m' # grey
export THEME_COMP_CORRECTIONS=$'\e[00;38;5;243m'  # grey
export THEME_COMP_SELECT=$'\e[01;38;5;75m'        # blue bold
export THEME_COMP_RESET=$'\e[00;00m'

# Apply completion formatting
zstyle ':completion:*:messages' format "${THEME_COMP_MESSAGES} -- %d -- ${THEME_COMP_RESET}"
zstyle ':completion:*:warnings' format "${THEME_COMP_WARNINGS} -- No Matches Found -- ${THEME_COMP_RESET}"
zstyle ':completion:*:descriptions' format "${THEME_COMP_DESCRIPTIONS} -- %d -- ${THEME_COMP_RESET}"
zstyle ':completion:*:corrections' format "${THEME_COMP_CORRECTIONS} -- %d -- ${THEME_COMP_RESET}"
zstyle ':completion:*:default' select-prompt "${THEME_COMP_SELECT} -- Match %M    %P -- ${THEME_COMP_RESET}"
