-- Leader Key

local keymap = vim.keymap.set  -- Shortcut for setting keymaps

-- Fast Escape in Insert Mode
keymap("i", "jj", "<Esc>", { noremap = true, silent = true })
vim.o.timeoutlen = 1000  -- Reduce delay before recognizing 'jj' (default is 1000ms)


-- Leader + s : save
keymap("n", "<leader>s", ":w<CR>", { noremap = true, silent = true })
-- Leader + q : quit
keymap("n", "<leader>q", ":q<CR>", { noremap = true, silent = true })
-- Leader + c : clear research result
keymap("n", "<leader>c", ":nohlsearch<CR>", { noremap = true, silent = true })

-- Leader + category + x for plugins
-- category: f->file, g->git
keymap("n", "<leader>tt", ":ToggleTerm<CR>", { noremap = true, silent = true,desc = "Toggle Terminal" })
keymap("n", "<leader>ft", "<cmd>Neotree toggle<cr>", { noremap = true, silent = true, desc = "NeoTree Explorer" })
keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live Grep" })
-- Diffview を開く (カレントブランチ vs HEAD)
vim.keymap.set("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", { desc = "Open Diffview" })
-- Diffview を閉じる
vim.keymap.set("n", "<leader>gq", "<cmd>DiffviewClose<cr>", { desc = "Close Diffview" })

