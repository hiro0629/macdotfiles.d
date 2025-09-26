#!/bin/zsh

DOTFILES_DIR="$HOME/macdotfiles.d"
OS_TYPE=$(uname -s)

ln -sf "$DOTFILES_DIR/zsh/zshrc" "$HOME/.zshrc"

# git
ln -sf "$DOTFILES_DIR/git/gitconfig" "$HOME/.gitconfig"
if [[ ! -d "$HOME/.config/git" ]]; then
	mkdir ~/.config/git
fi
ln -sf "$DOTFILES_DIR/git/ignore" "$HOME/.config/git/ignore"

