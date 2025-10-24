#!/bin/zsh

DOTFILES_DIR="$HOME/macdotfiles.d"
OS_TYPE=$(uname -s)

# zsh
ln -sf "$DOTFILES_DIR/zsh.d/zsh_profile" "$HOME/.zsh_profile"
ln -sf "$DOTFILES_DIR/zsh.d/zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES_DIR/zsh.d/zsh_aliases" "$HOME/.zsh_aliases"

# git
ln -sf "$DOTFILES_DIR/git.d/gitconfig" "$HOME/.gitconfig"
if [[ ! -d "$HOME/.config/git" ]]; then
	mkdir ~/.config/git
fi
ln -sf "$DOTFILES_DIR/git.d/ignore" "$HOME/.config/git/ignore"

# tmux
ln -sf "$DOTFILES_DIR/tmux.d/tmux.conf" "$HOME/.tmux.conf"

# wezterm
mkdir -p ~/.config/wezterm
ln -sf "$DOTFILES_DIR/wezterm.d/wezterm.lua" "$HOME/.config/wezterm/wezterm.lua"
ln -sf "$DOTFILES_DIR/wezterm.d/keybind.lua" "$HOME/.config/wezterm/keybind.lua"

# starship
ln -sf "$DOTFILES_DIR/starship.d/starship.toml" "$HOME/.config/starship.toml"

# nvim
mkdir -p ~/.config/nvim/lua/config/plugins
ln -sf "$DOTFILES_DIR/nvim.d/init.lua" "$HOME/.config/nvim/init.lua"
ln -sf "$DOTFILES_DIR/nvim.d/lua/keymaps.lua" "$HOME/.config/nvim/lua/keymaps.lua"
ln -sf "$DOTFILES_DIR/nvim.d/lua/options.lua" "$HOME/.config/nvim/lua/options.lua"

# vim
ln -sf "$DOTFILES_DIR/vim.d/vimrc" "$HOME/.vimrc"

# yazi
mkdir -p ~/.config/yazi
ln -sf "$DOTFILES_DIR/yazi.d/theme.toml" "$HOME/.config/yazi/theme.toml"

