# Path to your oh-my-fish.
set fish_path $HOME/.oh-my-fish

# set -gx DYLD_LIBRARY_PATH '/opt/oracle/instantclient_11_2'
# set -gx ORACLE_HOME '/opt/oracle/instantclient_11_2'
# set -gx RBENV_ROOT /usr/local/var/rbenv
# . (rbenv init -|psub)

set --erase fish_greeting

set EDITOR nvim
set VISUAL nvim

set fish_key_bindings fish_user_key_bindings
set fish_bind_mode insert

# Theme
set fish_theme toaster

# All built-in plugins can be found at ~/.oh-my-fish/plugins/
# Custom plugins may be added to ~/.oh-my-fish/custom/plugins/
# Enable plugins by adding their name separated by a space to the line below.
set fish_plugins gem theme bundler brew rails rbenv tmux z osx

eval (dircolors -c ~/.dircolors)

# Path to your custom folder (default path is ~/.oh-my-fish/custom)
#set fish_custom $HOME/dotfiles/oh-my-fish

# Load oh-my-fish configuration.
. $fish_path/oh-my-fish.fish
