#!/bin/zsh

DOTFILES_DIR="$HOME/macdotfiles.d"
OS_TYPE=$(uname -s)

# zsh
ln -sf "$DOTFILES_DIR/zsh/zsh_profile" "$HOME/.zsh_profile"
ln -sf "$DOTFILES_DIR/zsh/zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/zsh/zsh_aliases" "$HOME/.zsh_aliases"

# git
ln -sf "$DOTFILES_DIR/git/gitconfig" "$HOME/.gitconfig"
if [[ ! -d "$HOME/.config/git" ]]; then
	mkdir ~/.config/git
fi
ln -sf "$DOTFILES_DIR/git/ignore" "$HOME/.config/git/ignore"

# tmux
ln -sf "$DOTFILES_DIR/tmux/tmux.conf" "$HOME/.tmux.conf"

# vim
ln -sf "$DOTFILES_DIR/vim/vimrc" "$HOME/.vimrc"

# yazi
mkdir -p ~/.config/yazi
ln -sf "$DOTFILES_DIR/yazi/theme.toml" "$HOME/.config/yazi/theme.toml"

# wezterm
mkdir -p ~/.config/wezterm
ln -sf "$DOTFILES_DIR/wezterm/wezterm.lua" "$HOME/.config/wezterm/wezterm.lua"
ln -sf "$DOTFILES_DIR/wezterm/keybind.lua" "$HOME/.config/wezterm/keybind.lua"

# starship
ln -sf "$DOTFILES_DIR/starship/starship.toml" "$HOME/.config/starship.toml"

# nvim
mkdir -p ~/.config/nvim/lua/config/plugins
ln -sf "$DOTFILES_DIR/nvim/init.lua" "$HOME/.config/nvim/init.lua"
ln -sf "$DOTFILES_DIR/nvim/lua/keymaps.lua" "$HOME/.config/nvim/lua/keymaps.lua"
ln -sf "$DOTFILES_DIR/nvim/lua/options.lua" "$HOME/.config/nvim/lua/options.lua"

