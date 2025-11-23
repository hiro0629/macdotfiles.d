# ============================================================
# Zsh 基本強化プラグイン
# ============================================================

# 履歴ベースの自動補完（右側にグレーの提案が出る）
# 例: git chec → git checkout develop を提案
zinit light zsh-users/zsh-autosuggestions

# 高速コマンド色分け（ミスを赤色で警告）通常版より高速
# 例: git commmit → “commmit” が赤くなる
zinit light zdharma-continuum/fast-syntax-highlighting

# ↑↓キーで「部分一致検索」できる履歴検索
# autosuggestions と組み合わせると最強
zinit light zsh-users/zsh-history-substring-search

# docker / kubectl / brew / gh など、数百の補完を追加
# 補完が強化され、コマンド入力が圧倒的に快適
zinit light zsh-users/zsh-completions


# ============================================================
# vi モード強化
# ============================================================

# Zsh の vi モードを高速＆多機能化
# jj/jk 切替、カーソル形状変更、ヒント表示など Neovim との相性最強
# zinit light jeffreytse/zsh-vi-mode


# ============================================================
# fzf 連携強化プラグイン
# ============================================================

# fzf を統合したナビゲーションツールセット
# 履歴ビューア / プロセス選択 / ファイル選択など高機能
# zinit light z-shell/zsh-navigation-tools

# Tab 補完を fzf のポップアップ UI で表示
# ディレクトリ一覧・プレビュー・アイコン表示などが美しく見える
# zinit ice depth"1"
# zinit load Aloxaf/fzf-tab


# ============================================================
# Git まわり
# ============================================================

# git open → 現在のリポジトリの GitHub ページをブラウザで開く
# リポジトリURLの手入力不要、超便利
# zinit light paulirish/git-open


# ============================================================
# CLI ツール（GitHub Release からの最新高速ビルド）
# Homebrew より軽量で最新を維持しやすい
# ============================================================

# bat (cat の高機能版) を GitHub Release から取得
# シンタックスハイライト付き cat。fzf プレビューにも最適
# zinit ice as"program" from"gh-r"
# zinit load sharkdp/bat

# fd (高速 find) を GitHub Release から取得
# find より圧倒的に高速で、fzf と組み合わせると最高
# zinit ice as"program" from"gh-r"
# zinit load sharkdp/fd
