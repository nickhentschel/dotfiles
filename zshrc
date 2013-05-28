# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Select ZSH theme
ZSH_THEME="agnoster"

# Set default user
DEFAULT_USER=`whoami`

# Aliases
alias zshconfig="vim ~/.zshrc"
alias lhd='ls -lhd .??*'

# Waiting dots
COMPLETION_WAITING_DOTS="true"

# Speeds up git
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Enable plugins
plugins=(git git-extras sublime zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh
source $HOME/z/z.sh

# Path should be exported in ~/.zprofile
# Makes zshrc more generic, allows working with OS X and Linux
export PATH=$PATH

