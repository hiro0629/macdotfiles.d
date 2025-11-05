-- Leader Key
local keymap = vim.keymap.set  -- Shortcut for setting keymaps

-- Fast Escape in Insert Mode
keymap("i", "jj", "<Esc>", { noremap = true, silent = true })
vim.o.timeoutlen = 1000  -- Reduce delay before recognizing 'jj' (default is 1000ms)

-- Leader + s : save
keymap("n", "<leader>s", ":w<CR>", { noremap = true, silent = true })
-- Leader + q : quit
keymap("n", "<leader>q", ":q<CR>", { noremap = true, silent = true })
-- Leader + c : clear search result
keymap("n", "<leader>c", ":nohlsearch<CR>", { noremap = true, silent = true })

-- Leader + category + x for plugins
-- category: f->file, g->git
keymap("n", "<leader>tt", ":ToggleTerm<CR>", { noremap = true, silent = true, desc = "Toggle Terminal" })
keymap("n", "<leader>ft", "<cmd>Neotree toggle<cr>", { noremap = true, silent = true, desc = "NeoTree Explorer" })
keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live Grep" })
keymap("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", { desc = "Open Diffview" })
keymap("n", "<leader>gq", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" })

-- --------------------------------------------------------
-- 🧠 Clipboard mappings
-- --------------------------------------------------------

-- <leader>y : 行または選択範囲をクリップボードにコピー
keymap("n", "<leader>y", '"+yy', { noremap = true, silent = true, desc = "Copy line to clipboard" })
keymap("v", "<leader>y", '"+y',  { noremap = true, silent = true, desc = "Copy selection to clipboard" })

-- <leader>d : 行または選択範囲を切り取り（カット）
keymap("n", "<leader>d", '"+dd', { noremap = true, silent = true, desc = "Cut line to clipboard" })
keymap("v", "<leader>d", '"+d',  { noremap = true, silent = true, desc = "Cut selection to clipboard" })

-- <leader>p : クリップボードから貼り付け
keymap("n", "<leader>p", '"+p',  { noremap = true, silent = true, desc = "Paste from clipboard" })
keymap("v", "<leader>p", '"+p',  { noremap = true, silent = true, desc = "Paste from clipboard" })
