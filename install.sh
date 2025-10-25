#!/usr/bin/env zsh
set -euo pipefail

# ==============================
# dotfiles install
# ==============================

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/macdotfiles.d}"
OS_TYPE="$(uname -s)"

# ---------- helpers ----------
need() { command -v "$1" >/dev/null 2>&1; }
ensure_dir() { [[ -d "$1" ]] || mkdir -p "$1"; }
symlink() {
  local src="$1" dst="$2"
  ensure_dir "$(dirname "$dst")"
  ln -snf "$src" "$dst"
}

echo "[i] DOTFILES_DIR = ${DOTFILES_DIR}"
echo "[i] OS_TYPE      = ${OS_TYPE}"

# ---------- zsh ----------
symlink "${DOTFILES_DIR}/zsh.d/zsh_profile" "${HOME}/.zsh_profile"
symlink "${DOTFILES_DIR}/zsh.d/zshrc"        "${HOME}/.zshrc"
symlink "${DOTFILES_DIR}/zsh.d/zsh_aliases"  "${HOME}/.zsh_aliases"

# ---------- git ----------
symlink "${DOTFILES_DIR}/git.d/gitconfig"    "${HOME}/.gitconfig"
ensure_dir "${HOME}/.config/git"
symlink "${DOTFILES_DIR}/git.d/ignore"       "${HOME}/.config/git/ignore"

# ---------- tmux ----------
symlink "${DOTFILES_DIR}/tmux.d/tmux.conf"   "${HOME}/.tmux.conf"

# ---------- WezTerm ----------
ensure_dir "${HOME}/.config/wezterm"
symlink "${DOTFILES_DIR}/wezterm.d/wezterm.lua" "${HOME}/.config/wezterm/wezterm.lua"
symlink "${DOTFILES_DIR}/wezterm.d/keybind.lua" "${HOME}/.config/wezterm/keybind.lua"

# ---------- Starship ----------
ensure_dir "${HOME}/.config"
symlink "${DOTFILES_DIR}/starship.d/starship.toml" "${HOME}/.config/starship.toml"

# ---------- Neovim ----------
ensure_dir "${HOME}/.config/nvim"
if need stow; then
  (cd "${DOTFILES_DIR}" && stow -S -t "${HOME}/.config/nvim" nvim.d || true)
else
  symlink "${DOTFILES_DIR}/nvim.d" "${HOME}/.config/nvim"
fi

# ---------- Vim ----------
symlink "${DOTFILES_DIR}/vim.d/vimrc" "${HOME}/.vimrc"

# ---------- Yazi ----------
ensure_dir "${HOME}/.config/yazi"
[[ -f "${DOTFILES_DIR}/yazi.d/theme.toml"  ]] && symlink "${DOTFILES_DIR}/yazi.d/theme.toml"  "${HOME}/.config/yazi/theme.toml"
[[ -f "${DOTFILES_DIR}/yazi.d/keymap.toml" ]] && symlink "${DOTFILES_DIR}/yazi.d/keymap.toml" "${HOME}/.config/yazi/keymap.toml"

# ---------- calc venv (lightweight IPython) ----------
CALC_VENV="${CALC_VENV:-$HOME/.venvs/calc}"

if [[ ! -x "${CALC_VENV}/bin/ipython" ]]; then
  echo "[+] Creating calc venv at: ${CALC_VENV}"
  ensure_dir "${CALC_VENV%/*}"
  PYTHON_BIN="$(command -v python3 || true)"
  if [[ -z "${PYTHON_BIN}" ]]; then
    echo "ERROR: python3 が見つかりません（brew install python 推奨）" >&2
    exit 1
  fi
  "${PYTHON_BIN}" -m venv "${CALC_VENV}"
  "${CALC_VENV}/bin/pip" -q install -U pip ipython
else
  echo "[=] calc venv already exists: ${CALC_VENV}"
fi

echo
echo "✅ Setup complete."
echo "   - Dotfiles : ${DOTFILES_DIR}"
