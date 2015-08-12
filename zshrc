command_exists () {
  type "$1" &> /dev/null;
}

is_linux () {
    [[ $('uname') == 'Linux' ]];
}

is_osx () {
    [[ $('uname') == 'Darwin' ]]
}

if is_osx; then
    PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
    MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
fi

######## ZGEN ########

ZGEN_DIR=~/.zsh/plugins
source ~/.zsh/zgen/zgen.zsh

# Check if there's no init script.
if ! zgen saved; then
    echo "Creating a zgen save"

    zgen oh-my-zsh

    if is_osx; then
        zgen oh-my-zsh plugins/brew
        zgen oh-my-zsh plugins/osx
        zgen load s7anley/zsh-geeknote
    fi

    if is_linux; then
        zgen oh-my-zsh plugins/yum
        zgen oh-my-zsh plugins/fabric
    fi

    # plugins
    zgen load zsh-users/zsh-completions src
    zgen oh-my-zsh plugins/colored-man
    zgen load jimmijj/zsh-syntax-highlighting
    # zgen load zsh-users/zsh-history-substring-search
    zgen oh-my-zsh plugins/history-substring-search
    # zgen load tarruda/zsh-autosuggestions

    # theme
    zgen load nickhentschel/simplicity-prompt simplicity

    # save all to init script
    zgen save
fi

######## PLUGIN SETTINGS ########
zmodload zsh/terminfo

# Vi mode
bindkey -v

bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

# vi style incremental search
bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward
bindkey '^P' history-search-backward
bindkey '^N' history-search-forward

# Setup syntax highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)

######## HISTORY AND COMPLETION SETTINGS ########

autoload -Uz compinit
compinit

# Disable core dumps
limit coredumpsize 0 

# set some history options
setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt hist_save_no_dups
setopt hist_verify
setopt NOMATCH

# Share your history across all your terminal windows
setopt share_history

# set some more options
setopt pushd_ignore_dups
setopt menu_complete
setopt hash_list_all            # hash everything before completion
setopt completealiases          # complete alisases
setopt always_to_end            # when completing from the middle of a word, move the cursor to the end of the word
setopt complete_in_word         # allow completion from within a word/phrase

# Keep a ton of history.
HISTSIZE=100000
SAVEHIST=100000
HISTFILE=~/.zsh_history
HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help"

# Speed up autocomplete, force prefix mapping
# zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' accept-exact false
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# Sections completion
zstyle ':completion:*:match:*' original only
zstyle ':completion::prefix-1:*' completer _complete
zstyle ':completion:predict:*' completer _complete
zstyle ':completion:incremental:*' completer _complete _correct
zstyle ':completion:*' completer _complete _prefix _correct _prefix _match _approximate

# Path Expansion
zstyle ':completion:*' expand 'yes'
zstyle ':completion:*' squeeze-shlashes 'yes'
zstyle ':completion::complete:*' '\\'

zstyle ':completion:*:*:*:default' menu yes select
zstyle ':completion:*:*:default' force-list always
zstyle ':completion:*' users $users
zstyle ':completion:*' verbose yes
zstyle ':completion:*' group-name ''
zstyle ':completion:*' special-dirs true
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)*==34=34}:${(s.:.)LS_COLORS}")';
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:descriptions' format $'\e[00;34m%d'
zstyle ':completion:*:messages' format $'\e[00;31m%d'

# zstyle ':completion:*:processes:*' command 'ps xf -u $USER -o pid,%cpu,cmd'
# zstyle ':completion:*:processes' command 'ps -au$USER'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always
zstyle ':completion:*:*:killall:*' menu yes select
zstyle ':completion:*:killall:*' force-list always
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'


######## OTHER SETTINGS #######

export TERM='xterm-256color'

# Use dircolors if available
test -e ~/.dircolors && \
  eval `dircolors -b ~/.dircolors`

# Long running processes should return time after they complete. Specified
# in seconds.
REPORTTIME=2
TIMEFMT="%U user %S system %P cpu %*Es total"

# Beeping is super annoying
unsetopt beep
unsetopt hist_beep

export LESS="ij.5KMRX"

# Use a default width of 80 for manpages for more convenient reading
export MANWIDTH=80

if hash nvim 2>/dev/null; then
    export EDITOR=nvim
else
    export EDITOR=vim
fi

# less for paging
export PAGER=less man

# aliases
alias ls="ls --color=always"
alias grep="grep --color=always"
alias egrep="egrep --color=always"

# warning if file exists ('cat /dev/null > ~/.zshrc')
setopt NO_clobber

# source /Users/nhentschel/.iterm2_shell_integration.zsh
