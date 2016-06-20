######## FUNCTIONS ########
is_linux () {
    [[ $('uname') == 'Linux' ]];
}

is_osx () {
    [[ $('uname') == 'Darwin' ]]
}

path () {
  echo $PATH | tr ":" "\n" | \
    awk "{ sub(\"/usr\",   \"$fg_no_bold[green]/usr$reset_color\"); \
           sub(\"/bin\",   \"$fg_no_bold[blue]/bin$reset_color\"); \
           sub(\"/opt\",   \"$fg_no_bold[cyan]/opt$reset_color\"); \
           sub(\"/sbin\",  \"$fg_no_bold[magenta]/sbin$reset_color\"); \
           sub(\"/local\", \"$fg_no_bold[yellow]/local$reset_color\"); \
           print }"
}

######## EXPORTS AND OTHER SETTINGS #######
stty -ixon

if is_osx; then
    unset PATH
    if [ -x /usr/libexec/path_helper ]; then
        eval `/usr/libexec/path_helper -s`
    fi
    export PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH
fi

if is_osx && hash rbenv 2>/dev/null; then
  eval "$(rbenv init -)"
fi

if hash nvim 2>/dev/null; then
    export EDITOR=nvim
    alias vim='/usr/local/bin/nvim'
else
    export EDITOR=vim
fi

export PATH=$PATH:$HOME/local/bin
export WORKON_HOME=~/envs
export REPORTTIME=2
export TIMEFMT="%U user %S system %P cpu %*Es total"
export KEYTIMEOUT=1
export LESS="ij.5KMRX"
export TERM='xterm-256color'
export MANWIDTH=80
export PAGER=less man
export TERMINFO="$HOME/.terminfo"

export HISTSIZE=100000
export SAVEHIST=100000
export HISTFILE=~/.zsh_history
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help"

export LESS_TERMCAP_mb=$'\E[01;31m'      # Begins blinking.
export LESS_TERMCAP_md=$'\E[01;31m'      # Begins bold.
export LESS_TERMCAP_me=$'\E[0m'          # Ends mode.
export LESS_TERMCAP_se=$'\E[0m'          # Ends standout-mode.
export LESS_TERMCAP_so=$'\E[00;47;30m'   # Begins standout-mode.
export LESS_TERMCAP_ue=$'\E[0m'          # Ends underline.
export LESS_TERMCAP_us=$'\E[01;32m'      # Begins underline.

# aliases
alias ls="ls -ph --color=always"
alias ll="ls -lchp"
alias grep="grep --color=always"
alias egrep="egrep --color=always"
alias c="clear"
alias d="dirs -v"
alias venvwrapper="source ~/.local/bin/virtualenvwrapper.sh"
alias jenkinscli="java -jar /wayfair/pkg/jenkins/latest/bin/jenkins-cli.jar -noKeyAuth -s http://localhost/jenkins"
alias jenkinscli6="/wayfair/pkg/java/latest/bin/java -jar /wayfair/pkg/jenkins/bin/jenkins-cli.jar -noKeyAuth -s http://localhost/jenkins"
alias weather="curl -4 http://wttr.in/Boston"
alias json-print="python -m json.tool"
alias http-server="python -m SimpleHTTPServer 8080 &> /dev/null &"
alias fab="/wayfair/pkg/python2.7/latest/bin/fab"
alias zk_status="echo srvr | nc localhost 2181"

if ! [[ "$(hostname -f)" =~ ^.*jump ]]; then
  alias wss="ssh -t bojumpc1n1.csnzoo.com \"/wayfair/bin/wss $1\""
fi

# Use dircolors if available
test -e ~/.dircolors && \
  eval `dircolors -b ~/.dircolors`

# warning if file exists ('cat /dev/null > ~/.zshrc')
setopt NO_clobber

# Beeping is super annoying
unsetopt beep
unsetopt hist_beep

######## HISTORY AND COMPLETION SETTINGS ########

autoload -Uz compinit && compinit -D -u

# Disable core dumps
limit coredumpsize 0

# set some history options
# setopt append_history
# setopt extended_history
# setopt hist_expire_dups_first
setopt hist_ignore_all_dups
setopt hist_ignore_dups
# setopt hist_ignore_space
# setopt hist_reduce_blanks
# setopt hist_save_no_dups
# setopt hist_verify
# setopt NOMATCH

# Share your history across all your terminal windows
setopt share_history

# set some more options
# setopt menu_complete
setopt auto_pushd               # Push the old directory onto the stack on cd.
setopt pushd_ignore_dups        # Do not store duplicates in the stack
setopt hash_list_all            # hash everything before completion
setopt completealiases          # complete alisases
setopt always_to_end            # when completing from the middle of a word, move the cursor to the end of the word
setopt complete_in_word         # allow completion from within a word/phrase
setopt extended_glob            # Use extended globbing syntax.
setopt autocd                   # Auto changes to a directory without typing cd
setopt automenu

# General stuff
setopt brace_ccl                # Allow brace character class list expansion.
setopt combining_chars          # Combine zero-length punctuation characters (accents)
                                # with the base character.
setopt rc_quotes                # Allow 'Henry''s Garage' instead of 'Henry'\''s Garage'.
unsetopt bg_nice                # Don't run all background jobs at a lower priority.

# Completion options
setopt complete_in_word    # Complete from both ends of a word.
setopt always_to_end       # Move cursor to the end of a completed word.
setopt path_dirs           # Perform path search even on command names with slashes.
setopt auto_menu           # Show completion menu on a succesive tab press.
setopt auto_list           # Automatically list choices on ambiguous completion.
setopt auto_param_slash    # If completed parameter is a directory, add a trailing slash.
unsetopt menu_complete     # Do not autoselect the first completion entry.

# Speed up autocomplete, force prefix mapping
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' accept-exact false
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "${ZDOTDIR:-$HOME}.zsh/cache"
zstyle ':completion:*' rehash true

# Sections completion
zstyle ':completion:*:match:*' original only
zstyle ':completion::prefix-1:*' completer _complete
zstyle ':completion:predict:*' completer _complete
zstyle ':completion:incremental:*' completer _complete _correct
zstyle ':completion:*' completer _complete _prefix _correct _prefix _match _approximate

# Path Expansion
zstyle ':completion:*' expand 'yes'
zstyle ':completion:*' squeeze-shlashes 'yes'

zstyle ':completion:*' menu select
zstyle ':completion:*' users $users
zstyle ':completion:*' verbose yes
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' special-dirs true
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)*==34=34}:${(s.:.)LS_COLORS}")';
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:descriptions' format $'\e[00;34m%d'
zstyle ':completion:*:messages' format $'\e[00;31m%d'
zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always
zstyle ':completion:*:*:killall:*' menu yes select
zstyle ':completion:*:killall:*' force-list always
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'

zstyle ':completion:*' warnings '%F{red}No matches for: %d%f'


######## ZGEN ########

ZGEN_DIR=~/.zsh/plugins
source ~/.zsh/zgen/zgen.zsh

# Check if there's no init script.
if ! zgen saved; then
    echo "Creating a zgen save"

    # theme
    zgen load nickhentschel/simplicity-prompt simplicity

    # plugins
    zgen load zsh-users/zsh-completions
    zgen load vhbit/fabric-zsh-autocomplete
    zgen load srijanshetty/zsh-pip-completion
    zgen load zsh-users/zsh-syntax-highlighting
    zgen load zsh-users/zsh-history-substring-search

    # save all to init script
    zgen save
fi

######## PLUGIN SETTINGS ########

# Setup syntax highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets cursor line)
ZSH_HIGHLIGHT_STYLES[precommand]=none
ZSH_HIGHLIGHT_STYLES[default]=none

bindkey -v
autoload -Uz edit-command-line
zle -N edit-command-line

######## KEY BINDINGS ########


# Make sure that the terminal is in application mode when zle is active, since
# only then values from $terminfo are valid
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
  function zle-line-init() {
    echoti smkx
  }
  function zle-line-finish() {
    echoti rmkx
  }
  zle -N zle-line-init
  zle -N zle-line-finish
fi

zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '\e[3~' delete-char
bindkey '^R' history-incremental-search-backward

# vi style incremental search
bindkey -M vicmd 'u' undo
bindkey -M vicmd '~' vi-swap-case
bindkey '^u' vi-change-whole-line
