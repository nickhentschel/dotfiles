# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Select ZSH theme
ZSH_THEME="agnoster"

# Set default user
DEFAULT_USER=`whoami`

# Aliases
alias zshconfig="vim ~/.zshrc"
alias lhd='ls -lhd .??*'
alias vim="stty stop '' -ixoff ; vim"
ttyctl -f

# Waiting dots
COMPLETION_WAITING_DOTS="true"

# Speeds up git
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Enable plugins

# Path should be exported in ~/.zprofile
# Makes zshrc more generic, allows working with OS X and Linux
export PATH=$PATH
