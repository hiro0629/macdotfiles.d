-- Leader Key
local keymap = vim.keymap.set

-- Fast Escape in Insert Mode
keymap("i", "jj", "<Esc>", { noremap = true, silent = true })
vim.o.timeoutlen = 1000

-- Leader + s : save
keymap("n", "<leader>s", ":w<CR>", { noremap = true, silent = true })
-- Leader + q : quit
keymap("n", "<leader>q", ":q<CR>", { noremap = true, silent = true })
-- Leader + c : clear search result
keymap("n", "<leader>c", ":nohlsearch<CR>", { noremap = true, silent = true })

-- 🧠 Clipboard mappings
keymap("n", "<leader>y", '"+yy', { noremap = true, silent = true, desc = "Copy line to clipboard" })
keymap("v", "<leader>y", '"+y',  { noremap = true, silent = true, desc = "Copy selection to clipboard" })
keymap("n", "<leader>d", '"+dd', { noremap = true, silent = true, desc = "Cut line to clipboard" })
keymap("v", "<leader>d", '"+d',  { noremap = true, silent = true, desc = "Cut selection to clipboard" })
keymap("n", "<leader>p", '"+p',  { noremap = true, silent = true, desc = "Paste from clipboard" })
keymap("v", "<leader>p", '"+p',  { noremap = true, silent = true, desc = "Paste from clipboard" })

-- Split / Window
keymap("n", "<leader>-", ":split<CR>",   { desc = "水平分割" })
keymap("n", "<leader>|", ":vsplit<CR>",  { desc = "垂直分割" })
keymap("n", "<leader>h", "<C-w>h", { desc = "左のウィンドウへ" })
keymap("n", "<leader>j", "<C-w>j", { desc = "下のウィンドウへ" })
keymap("n", "<leader>k", "<C-w>k", { desc = "上のウィンドウへ" })
keymap("n", "<leader>l", "<C-w>l", { desc = "右のウィンドウへ" })
