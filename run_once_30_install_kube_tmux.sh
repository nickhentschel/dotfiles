#!/bin/sh

# install tmux integration for tmux

curl -fLo ~/.config/tmux/kube.tmux --create-dirs \
    https://raw.githubusercontent.com/jonmosco/kube-tmux/master/kube.tmux
