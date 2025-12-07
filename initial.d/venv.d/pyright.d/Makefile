# ==========================
# Virtualenv 관리 Makefile
# ==========================

VENV_DIR = .venv
PYTHON = python3
REQ = requirements.txt

# 仮想環境を新規構築
init:
	$(PYTHON) -m venv $(VENV_DIR)
	$(VENV_DIR)/bin/pip install --upgrade pip
	$(VENV_DIR)/bin/pip install -r $(REQ)
	@echo "✔ venv initialized!"

# パッケージを再インストール（クリーンセットアップ）
reinstall:
	rm -rf $(VENV_DIR)
	$(MAKE) init

# 依存パッケージの更新
upgrade:
	$(VENV_DIR)/bin/pip install --upgrade -r $(REQ)
	@echo "✔ packages upgraded!"

# pyright 起動（calc 用 REPL）
pyright:
	$(VENV_DIR)/bin/pyright

# venv を有効化（zsh向け）
activate:
	@echo "source $(PWD)/$(VENV_DIR)/bin/activate"

.PHONY: init reinstall upgrade pyright activate
