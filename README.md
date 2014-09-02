# Dotfiles - Nick Hentschel #

These dotfiles have been scraped and taken from many different sources. I tried to give proper attribution where possible. Feel free to use any of my files here for any reason, but this was mostly compiled to be a resource for me.

I do the majority of my work on OS X, using iTerm2. That's not to say that this configuration won't work on any of the various Linux distributions (if Ruby is installed), but I haven't tested this on any of them. This configuration is fairly generic, so most of it should be fine.

### Features ###

- Changes shell to zsh
- Installs Prezto for zsh
- Enables command line coloring and other prezto modules
- Backs up user's existing dotfiles

### Usage ###

##### Dependencies: #####
- These dotfiles require at least Ruby and git to be installed on the system
- To make use of prezto zsh must be installed. A rake task will attempt to switch the user to zsh if it is not the current shell. zsh should be installed by default on OS X systems.

##### Installation Instructions #####
1. Pull the repo with the following command: `git clone --recursive https://github.com/nickhentschel/dotfiles.git ~/dotfiles`
2. Run `rake install` to start a full installation or run `rake -T` to view all available options.
