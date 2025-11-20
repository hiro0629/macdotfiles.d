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
### wezterm
- LeaderKey = Ctrl + k
- See wezterm.d/keymap.lua
### nvim

🧷 基本操作 / General
キー	モード	動作
jj	Insert	Normal モードに戻る（Esc 相当）
<leader>s (Space s)	Normal	保存 :w
<leader>q (Space q)	Normal	終了 :q
<leader>c (Space c)	Normal	検索ハイライトを消す :nohlsearch

📋 クリップボード / Clipboard
キー	モード	動作
<leader>y	Normal	現在行をシステムクリップボードにコピー
<leader>y	Visual	選択範囲をシステムクリップボードにコピー
<leader>d	Normal	現在行をシステムクリップボードに「切り取り」
<leader>d	Visual	選択範囲をシステムクリップボードに「切り取り」
<leader>p	Normal	システムクリップボードから貼り付け
<leader>p	Visual	システムクリップボードから貼り付け

🪟 ウィンドウ / 分割操作
キー	モード	動作
<leader>- (Space -)	Normal	水平分割 :split
`	 (Space |`)	Normal
<leader>h	Normal	左のウィンドウへ移動
<leader>j	Normal	下のウィンドウへ移動
<leader>k	Normal	上のウィンドウへ移動
<leader>l	Normal	右のウィンドウへ移動

🔍 Telescope（検索まわり）
キー	モード	動作
<leader>ff	Normal	ファイル検索（プレビュー付き find_files）
<leader>fg	Normal	プロジェクト内全文検索（live_grep）
<leader>fb	Normal	開いているバッファ一覧（MRU順、現在バッファ除外）
<leader>fo	Normal	最近開いたファイル履歴（oldfiles）
<leader>gs	Normal	Git ステータス一覧（git_status）

📂 Neo-tree（ファイルツリー）
キー	モード	動作
<leader>fe	Normal	Neo-tree トグル表示（開く/閉じる）
<leader>fE	Normal	Neo-tree ウィンドウにフォーカス

💻 ターミナル / toggleterm
キー	モード	動作
<leader>tt	Normal	トグルターミナルを開く / 閉じる（float）
<C-\>	Normal/Terminal	ToggleTerm（デフォルトの open_mapping）

🧱 バッファライン / bufferline.nvim
キー	モード	動作
<Tab>	Normal	次のバッファへ（Next buffer / Tab 風）
<S-Tab>	Normal	前のバッファへ（Prev buffer）

🔀 Diffview（差分ビュー）
キー	モード	動作
<leader>gd	Normal	Diffview を開く DiffviewOpen
<leader>gq	Normal	Diffview を閉じる DiffviewClose
⸻
🌀 Gitsigns（バッファローカル）
※ 対象バッファで Git 管理されているときのみ有効
キー	モード	動作
]h	Normal	次の hunk へ移動
[h	Normal	前の hunk へ移動
<leader>hs	Normal	現在の hunk をステージ
<leader>hr	Normal	現在の hunk をリセット
<leader>hb	Normal	現在行の blame を表示
<leader>hd	Normal	現在バッファと index の diff を表示
<leader>hD	Normal	現在バッファと ~（前回コミット）との diff

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

