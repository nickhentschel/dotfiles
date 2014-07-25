# Dotfiles - Nick Hentschel #

These dotfiles have been scraped and taken from many different sources. I tried to give proper attribution where possible. Feel free to use any of my files here for any reason, but this was mostly compiled to be a resource for me.

I do the majority of my work on OS X, using iTerm2. That's not to say that this configuration won't work on any of the various Linux distributions (if Ruby is installed), but I haven't tested this on any of them. This configuration is fairly generic, so most of it should be fine, with the exception of the gui options in the .vimrc. 

### Features ###

- Changes shell to zsh
- Installs Prezto for zsh
- Adds command line coloring 
- Backs up user's existing dotfiles

### Usage ###

Pull the repo, and run `rake install` for a full installation, or run `rake -T` to view all of the available options.

I have found that fonts look better on OS X with uniform font smoothing. That can be achieved easily with this command:

  defaults -currentHost write -globalDomain AppleFontSmoothing -int 1 
