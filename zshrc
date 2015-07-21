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
    fi

    if is_linux; then
        zgen oh-my-zsh plugins/yum
        zgen oh-my-zsh plugins/fabric
    fi

    zgen oh-my-zsh plugins/git

    # plugins
    zgen load zsh-users/zsh-completions src
    zgen load jimmijj/zsh-syntax-highlighting
    zgen load zsh-users/zsh-history-substring-search
    zgen load tarruda/zsh-autosuggestions

    # theme
    zgen oh-my-zsh themes/agnoster

    # save all to init script
    zgen save
fi

######## END ZGEN ########

######## PLUGIN SETTINGS ########
zmodload zsh/terminfo
# Make sure the terminal is in application mode, when zle is active. Only then
# are the values from $terminfo valid. And also activate autosuggestions.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    # Bind UP and DOWN arrow keys to history-substring-search.
    bindkey "$terminfo[kcuu1]" history-substring-search-up
    bindkey "$terminfo[kcud1]" history-substring-search-down

    function zle-line-init () {
        printf '%s' "${terminfo[smkx]}"

        # Enable autosuggestions automatically
        zle autosuggest-start
    }

    function zle-line-finish () {
        printf '%s' "${terminfo[rmkx]}"
    }

    zle -N zle-line-init
    zle -N zle-line-finish
fi

# Use right arrow to accept suggestions
AUTOSUGGESTION_ACCEPT_RIGHT_ARROW=1

# set default user for agnoster prompt
DEFAULT_USER='nhentschel'

######## END PLUGIN SETTINGS ########


######## HISTORY AND COMPLETION SETTINGS ########

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

# Share your history across all your terminal windows
setopt share_history

# set some more options
setopt pushd_ignore_dups
setopt hash_list_all            # hash everything before completion
setopt completealiases          # complete alisases
setopt always_to_end            # when completing from the middle of a word, move the cursor to the end of the word    
setopt complete_in_word         # allow completion from within a word/phrase

# Keep a ton of history.
HISTSIZE=100000
SAVEHIST=100000
HISTFILE=~/.zsh_history
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help"

# Speed up autocomplete, force prefix mapping
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)*==34=34}:${(s.:.)LS_COLORS}")';

# Sections completion
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format $'\e[00;34m%d'
zstyle ':completion:*:messages' format $'\e[00;31m%d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:manuals' separate-sections true

zstyle ':completion:*:processes' command 'ps -au$USER'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always
zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=29=34"
zstyle ':completion:*:*:killall:*' menu yes select
zstyle ':completion:*:killall:*' force-list always
zstyle ':completion:*' users $users

zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'


######## END HISTORY AND COMPLETION SETTINGS ########

######## OTHER SETTINGS #######

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

# support colors in less
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# Use a default width of 80 for manpages for more convenient reading
export MANWIDTH=${MANWIDTH:-80}

# vim, obviously
export EDITOR=${EDITOR:-vim}

# less for paging
export PAGER=${PAGER:-less}

# aliases
alias ls="ls --color=always"
alias grep="grep --color=always"
alias egrep="egrep --color=always"

# warning if file exists ('cat /dev/null > ~/.zshrc')
setopt NO_clobber
