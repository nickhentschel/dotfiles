#!/bin/bash

# Make sure the script stops on errors
set -e

echo "Setting up Neovim plugins for VSCode..."

# Create necessary directories
mkdir -p ~/.vim/autoload
mkdir -p ~/.vim/plugged

# Install vim-plug if not already installed
if [ ! -f ~/.vim/autoload/plug.vim ]; then
    echo "Installing vim-plug..."
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

# Make vim-plug also available for neovim
mkdir -p ~/.local/share/nvim/site/autoload
cp ~/.vim/autoload/plug.vim ~/.local/share/nvim/site/autoload/

# Install the plugins using vim-plug
echo "Installing plugins..."
nvim --headless +PlugInstall +qall

echo "Setup complete! Your Neovim plugins for VSCode are now installed."