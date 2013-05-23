# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Select ZSH theme
ZSH_THEME="af-magic"

# Aliases
alias zshconfig="vim ~/.zshrc"
alias lhd='ls -lhd .??*'

# Waiting dots
COMPLETION_WAITING_DOTS="true"

# Speeds up git
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Enable plugins
plugins=(git git-extras sublime)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=$PATH:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin
