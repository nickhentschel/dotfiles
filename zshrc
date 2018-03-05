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
    sub(\"/opt\",   \"$fg_no_bold[magenta,bold]/opt$reset_color\"); \
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
#
######## ZPLUGIN ########

source "${HOME}/.zplugin/bin/zplugin.zsh"

# theme
zplugin light 'nickhentschel/simplicity-prompt'

# plugins
zplugin snippet OMZ::plugins/kubectl/kubectl.plugin.zsh
zplugin light 'greymd/docker-zsh-completion'
zplugin light 'psprint/history-search-multi-word'
zplugin light 'zsh-users/zsh-completions'
zplugin light 'zsh-users/zsh-autosuggestions'
zplugin light 'zdharma/fast-syntax-highlighting'
zplugin light 'zsh-users/zsh-history-substring-search'

######## PLUGIN SETTINGS ########

my-autosuggest-accept() {
  zle autosuggest-accept
  zle redisplay
  zle redisplay
}

# Setup syntax highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets line)
FAST_HIGHLIGHT_STYLES[variable]='fg=blue,bold'
FAST_HIGHLIGHT_STYLES[default]=none
FAST_HIGHLIGHT_STYLES[unknown-token]='fg=red,bold'
FAST_HIGHLIGHT_STYLES[reserved-word]='fg=27'
FAST_HIGHLIGHT_STYLES[alias]='none'
FAST_HIGHLIGHT_STYLES[suffix-alias]='none'
FAST_HIGHLIGHT_STYLES[builtin]='none'
FAST_HIGHLIGHT_STYLES[function]='none'
FAST_HIGHLIGHT_STYLES[command]='none'
FAST_HIGHLIGHT_STYLES[precommand]='none'
FAST_HIGHLIGHT_STYLES[commandseparator]='fg=green,bold'
FAST_HIGHLIGHT_STYLES[hashed-command]='none'
FAST_HIGHLIGHT_STYLES[path]='fg=blue,bold,underline'
# FAST_HIGHLIGHT_STYLES[path_pathseparator]=
FAST_HIGHLIGHT_STYLES[globbing]='fg=blue,bold'
# FAST_HIGHLIGHT_STYLES[history-expansion]=fg=blue,bold
FAST_HIGHLIGHT_STYLES[single-hyphen-option]='fg=blue,bold'
FAST_HIGHLIGHT_STYLES[double-hyphen-option]='fg=blue,bold'
# FAST_HIGHLIGHT_STYLES[back-quoted-argument]=none
FAST_HIGHLIGHT_STYLES[single-quoted-argument]='fg=yellow'
FAST_HIGHLIGHT_STYLES[double-quoted-argument]='fg=yellow'
FAST_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=yellow'
FAST_HIGHLIGHT_STYLES[back-or-dollar-double-quoted-argument]='fg=blue,bold'
FAST_HIGHLIGHT_STYLES[back-dollar-quoted-argument]='fg=blue,bold'
FAST_HIGHLIGHT_STYLES[assign]=none
FAST_HIGHLIGHT_STYLES[redirection]='fg=cyan'
FAST_HIGHLIGHT_STYLES[comment]='fg=black,bold'

# Autosuggestions settings
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=240"
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=("backward-char")
ZSH_AUTOSUGGEST_IGNORE_WIDGETS+=my-autosuggest-accept

# History search settings
zstyle ":history-search-multi-word" page-size "10"
zstyle ":history-search-multi-word" highlight-color "fg=cyan,bold"
zstyle ":plugin:history-search-multi-word" active "standout"

bindkey -v
autoload -Uz edit-command-line
zle -N edit-command-line
zle -N my-autosuggest-accept

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
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$HOME/.fzf/bin:$HOME/.local/bin:$PATH
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
export LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:'
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
alias fab="/wayfair/app/fabric/bin/fab"
alias grep="grep --color=always"
alias host_search="hammer --output=csv --csv-separator=\" \" host list --search ${1}"
alias http_server="python -m SimpleHTTPServer 8080 &> /dev/null &"
alias jenkinscli6="/wayfair/pkg/java/latest/bin/java -jar /wayfair/pkg/jenkins/bin/jenkins-cli.jar -noKeyAuth -s http://localhost/jenkins"
alias jenkinscli="java -jar /wayfair/pkg/jenkins/latest/bin/jenkins-cli.jar -noKeyAuth -s http://localhost/jenkins"
alias ll="ls -lachp"
alias ls="ls -ph --color=always"
alias mounts="cat /proc/mounts | column -t"
alias timestamp="date +%s"
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

# warning if file exists ('cat /dev/null > ~/.zshrc')
setopt NO_clobber

# Beeping is super annoying
unsetopt beep
unsetopt hist_beep

######## HISTORY AND COMPLETION SETTINGS ########

autoload -Uz compinit && compinit -D -u
zmodload -i zsh/complist

zplugin cdreplay -q # -q is for quiet

limit coredumpsize 0
unsetopt menu_complete
unsetopt flowcontrol
setopt auto_menu
setopt auto_list
setopt always_to_end
setopt append_history share_history histignorealldups
setopt auto_pushd               # Push the old directory onto the stack on cd.
setopt auto_resume        # Attempt to resume existing job before creating a new process.
setopt autocd                   # Auto changes to a directory without typing cd
setopt brace_ccl                # Allow brace character class list expansion.
setopt combining_chars          # Combine zero-length punctuation characters (accents)
setopt complete_in_word
setopt completealiases          # complete alisases
setopt extended_glob            # Use extended globbing syntax.
setopt hash_list_all            # hash everything before completion
setopt histignorespace
setopt listpacked
setopt long_list_jobs     # List jobs in the long format by default.
setopt markdirs
setopt notify             # Report status of background jobs immediately.
setopt pushd_ignore_dups        # Do not store duplicates in the stack
setopt rc_quotes                # Allow 'Henry''s Garage' instead of 'Henry'\''s Garage'.
unsetopt bg_nice          # Don't run all background jobs at a lower priority.

# Use caching so that commands like apt and dpkg complete are useable
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path $ZSH_CACHE_DIR

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

zstyle ':completion:*' menu select
zstyle ':completion:*' verbose yes
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' rehash true
zstyle ':completion:*:descriptions' format "- %d -"
zstyle ':completion:*:corrections' format "- %d - (errors %e})"
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
zstyle ':completion:*' list-colors $(dircolors)            # Use colors in the menu selection
zstyle ':completion:*' glob 'yes'                # Expand globs when tab-completing
zstyle ':completion:*:functions' ignored-patterns '_*'        # Ignore completion functions for unavailable commands
zstyle ':completion:*:complete:-command-::commands' ignored-patterns '*\~' # Don't complete backup files as executables
zstyle ':completion:*' ignore-parents parent pwd        # Don't let ../<tab> match $PWD
zstyle ':completion::*:(rm|vi|kill|diff):*' ignore-line true        # Don't match the same filenames multiple times

# disable named-directories autocompletion
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories

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
bindkey -M menuselect '^[[Z' reverse-menu-complete
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey '\x00' my-autosuggest-accept
bindkey "^R" history-search-multi-word

# vi style incremental search
bindkey -M vicmd 'u' undo
bindkey -M vicmd '~' vi-swap-case
bindkey '^u' vi-change-whole-line
