#!/bin/zsh

DOTFILES_DIR="$HOME/macdotfiles.d"
OS_TYPE=$(uname -s)

ln -sf "$DOTFILES_DIR/zsh/zshrc" "$HOME/.zshrc"

