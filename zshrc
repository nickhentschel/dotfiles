######## FUNCTIONS ########
is_linux() {
  [[ "$(uname)" == 'Linux' ]];
}

is_osx() {
  [[ "$(uname)" == 'Darwin' ]]
}

path() {
  echo $PATH | tr ":" "\n" | \
    awk "{ sub(\"/usr\",   \"$fg_no_bold[green]/usr$reset_color\"); \
    sub(\"/bin\",   \"$fg_no_bold[blue]/bin$reset_color\"); \
    sub(\"/opt\",   \"$fg_no_bold[cyan]/opt$reset_color\"); \
    sub(\"/sbin\",  \"$fg_no_bold[magenta]/sbin$reset_color\"); \
    sub(\"/local\", \"$fg_no_bold[yellow]/local$reset_color\"); \
    print }"
}

gendiff() {
  if [ -d .git ] || git rev-parse --git-dir > /dev/null 2>&1; then
    branch=$(git rev-parse --abbrev-ref HEAD)
    diff_name=${branch#nhentschel_}
    git diff -M --full-index origin/master >| ~/Development/diffs/${diff_name}.diff
    # scp ~/Development/diffs/${diff_name}.diff nhentschel@ALT00058.csnzoo.com:/Users/nhentschel/Development/diffs
  else
    echo 'Not in git directory'
  fi;
}

######## EXPORTS AND OTHER SETTINGS #######
stty -ixon

if is_osx; then
  unset PATH
  if [ -x /usr/libexec/path_helper ]; then
    eval `/usr/libexec/path_helper -s`
  fi
  export PATH=$HOME/.rbenv/bin:/usr/local/opt/coreutils/libexec/gnubin:/usr/local/sbin:$HOME/go/bin:$PATH
fi

export WORDCHARS=''
export CASE_SENSITIVE="true"
export ZSH_CACHE_DIR=$HOME/.zsh
export PATH=$HOME/.local/bin:$PATH
export EDITOR=vim
export WORKON_HOME=~/envs
export REPORTTIME=5
export TIMEFMT="%U user %S system %P cpu %*Es total"
export KEYTIMEOUT=1
export LESS="ij.5KMRX"
export MANWIDTH=80
export PAGER=less man
export TERMINFO="${HOME}/.terminfo"
export HISTSIZE=100000
export SAVEHIST=100000
export HISTFILE=~/.zsh_history
export HISTIGNORE="ls:cd:cd -:pwd:exit:* --help"
export LESS_TERMCAP_mb=$'\E[01;31m'      # Begins blinking.
export LESS_TERMCAP_md=$'\E[01;31m'      # Begins bold.
export LESS_TERMCAP_me=$'\E[0m'          # Ends mode.
export LESS_TERMCAP_se=$'\E[0m'          # Ends standout-mode.
export LESS_TERMCAP_so=$'\E[00;47;30m'   # Begins standout-mode.
export LESS_TERMCAP_ue=$'\E[0m'          # Ends underline.
export LESS_TERMCAP_us=$'\E[01;32m'      # Begins underline.

# aliases
alias c="clear"
alias d="dirs -v"
alias egrep="egrep --color=always"
alias grep="grep --color=always"
alias fab="/wayfair/app/fabric/bin/fab"
alias host_search="hammer --output=csv --csv-separator=\" \" host list --search ${1}"
alias http_server="python -m SimpleHTTPServer 8080 &> /dev/null &"
alias jenkinscli6="/wayfair/pkg/java/latest/bin/java -jar /wayfair/pkg/jenkins/bin/jenkins-cli.jar -noKeyAuth -s http://localhost/jenkins"
alias jenkinscli="java -jar /wayfair/pkg/jenkins/latest/bin/jenkins-cli.jar -noKeyAuth -s http://localhost/jenkins"
alias ll="ls -lachp"
alias ls="ls -ph --color=always"
alias mounts="cat /proc/mounts | column -t"
alias venvwrapper="source ~/.local/bin/virtualenvwrapper.sh"
alias weather="curl -4 http://wttr.in/Boston"

if type rg > /dev/null 2>&1; then
  alias grep="rg"
fi

if type nvim > /dev/null 2>&1; then
  alias vim="nvim"
fi

# Use dircolors if available
test -e ~/.dircolors && \
  eval "$(dircolors -b ~/.dircolors)"

# Add kubectl completions
if type kubectl > /dev/null 2>&1; then
  source <(kubectl completion zsh)
fi

# warning if file exists ('cat /dev/null > ~/.zshrc')
setopt NO_clobber

# Beeping is super annoying
unsetopt beep
unsetopt hist_beep

######## HISTORY AND COMPLETION SETTINGS ########

autoload -Uz compinit && compinit -D -u
autoload -Uz colors && colors

setopt append_history share_history histignorealldups
setopt histignorespace

# set some more options
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
setopt rc_quotes                # Allow 'Henry''s Garage' instead of 'Henry'\''s Garage'.
unsetopt bg_nice                # Don't run all background jobs at a lower priority.
limit coredumpsize 0

unsetopt menu_complete   # do not autoselect the first completion entry
unsetopt flowcontrol
setopt auto_menu         # show completion menu on successive tab press
setopt complete_in_word
setopt always_to_end

# should this be in keybindings?
bindkey -M menuselect '^o' accept-and-infer-next-history
zstyle ':completion:*' menu select
zstyle ':completion:*' verbose yes
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format "$fg[red]No matches for:$reset_color %d"
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

# case insensitive (all), partial-word and substring completion
if [[ "$CASE_SENSITIVE" = true ]]; then
  zstyle ':completion:*' matcher-list 'r:|=*' 'l:|=* r:|=*'
else
  if [[ "$HYPHEN_INSENSITIVE" = true ]]; then
    zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'
  else
    zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
  fi
fi

zstyle ':completion:*' list-colors ''
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"

# disable named-directories autocompletion
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories

# Use caching so that commands like apt and dpkg complete are useable
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path $ZSH_CACHE_DIR

# Don't complete uninteresting users
zstyle ':completion:*:*:*:users' ignored-patterns \
        adm amanda apache at avahi avahi-autoipd beaglidx bin cacti canna \
        clamav daemon dbus distcache dnsmasq dovecot fax ftp games gdm \
        gkrellmd gopher hacluster haldaemon halt hsqldb ident junkbust kdm \
        ldap lp mail mailman mailnull man messagebus  mldonkey mysql nagios \
        named netdump news nfsnobody nobody nscd ntp nut nx obsrun openvpn \
        operator pcap polkitd postfix postgres privoxy pulse pvm quagga radvd \
        rpc rpcuser rpm rtkit scard shutdown squid sshd statd svn sync tftp \
        usbmux uucp vcsa wwwrun xfs '_*'

# ... unless we really want to.
zstyle '*' single-ignored show

######## ZGEN ########

ZGEN_DIR=~/.zsh/plugins
source ~/.zsh/zgen/zgen.zsh

# Check if there's no init script.
if ! zgen saved; then
  printf 'Creating a zgen save'

  # theme
  zgen load nickhentschel/simplicity-prompt simplicity

  # plugins
  zgen load zsh-users/zsh-completions
  zgen load zsh-users/zsh-autosuggestions
  zgen load zsh-users/zsh-syntax-highlighting
  zgen load zsh-users/zsh-history-substring-search

  # save all to init script
  zgen save
fi

######## PLUGIN SETTINGS ########

my-autosuggest-accept() {
  zle autosuggest-accept
  zle redisplay
  zle redisplay
}

# Setup syntax highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets line)
ZSH_HIGHLIGHT_STYLES[path]=none

# Autosuggestions settings
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=239"
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE="40"
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=("backward-char")
ZSH_AUTOSUGGEST_IGNORE_WIDGETS+=my-autosuggest-accept

bindkey -v
autoload -Uz edit-command-line
zle -N edit-command-line
zle -N my-autosuggest-accept

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
bindkey '^F' history-incremental-search-forward
bindkey '\x00' my-autosuggest-accept

# vi style incremental search
bindkey -M vicmd 'u' undo
bindkey -M vicmd '~' vi-swap-case
bindkey '^u' vi-change-whole-line
