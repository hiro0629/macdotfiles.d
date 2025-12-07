📌 使い方

最初だけ：
make init

再構築：
make reinstall

依存アップデート：
make upgrade

calc 環境で IPython を起動：
make pyright

シェルから有効化コマンドだけ表示したい時：
make activate

📌 ディレクトリ構成

~/Projects/pyright/
├── requirements.txt
└── Makefile

or

~/.venvs/pyright/   ← venv専用フォルダならここでもOK
├── requirements.txt
└── Makefile


✔ 特徴
	•	venv が存在しなくても make init で完全再現
	•	Python バージョンが違っても自動で pip install
	•	同じ calc 環境を他の PC でも一瞬で構築

