## Short Cut Key
- karabiner > hammberspoon > wezterm > nvim
### karabiner
- capskey > long push as ctrl, short push as esc
- Right Command alone toggles Kana/Eisu
### hammberspoon
- LeaderKey = Ctrl + j
#### open app
- LK+t : Wezterm
- LK+w : TradingView
- LK+c : Chrome
- LK+o : Obsidian
- LK+g : ChatGPT
- LK+m : Gemini
- LK+a : PWA ChatGPT
- LK+v : Vimr
#### utility
- LK+f : Maximize current window
- LK+x : Zoom mode
- LK+x : Screenshot
- LK+d : Open Download dir by Finder


Task
zinit

🧩 ④ 診断・問題ビュー（Problems）

VSCode の ❗ 問題ビュー
	•	trouble.nvim
→ LSP の診断 / 警告 / エラー を VSCode の Problems パネルのように表示

🧩 ⑤ LSP（VSCode の IntelliSense）

VSCode の補完・定義ジャンプ・ホバーなど
	•	nvim-lspconfig
	•	mason.nvim（LSP 管理）
	•	mason-lspconfig.nvim
	•	cmp-nvim-lsp（補完に LSP 能力を渡す）

🧩 ⑥ コード補完（Autocomplete）

VSCode の IntelliSense 的ポップアップ
	•	nvim-cmp
	•	cmp-buffer
	•	cmp-path
	•	cmp-cmdline
	•	cmp-nvim-lsp
	•	luasnip / friendly-snippets など

🧩 ⑦ コードスニペット（Snippets）

VSCode の snippet と同等機能
	•	LuaSnip
	•	friendly-snippets

🧩 ⑧ デバッグ（Debugger）
VSCode の Debugger パネルと同等
	•	nvim-dap
	•	nvim-dap-ui
	•	nvim-dap-virtual-text

→ Python / Go / JS / Rust など VSCode のようにブレークポイント可能

🧩 ⑨ ステータスライン / ファイルバー（UI強化）
VSCode 下部のステータスバーやタブの擬似実装
	•	bufferline.nvim（タブバー）
	•	noice.nvim（メッセージポップアップを VSCode 風に）

