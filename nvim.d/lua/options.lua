-- ==============================
-- 🌟 Basic Neovim Config 🌟
-- ==============================
-- UI Enhancements
vim.o.number = true  -- Show line numbers
vim.o.relativenumber = true  -- Show relative numbers
vim.o.cursorline = true  -- Highlight the current line
vim.o.termguicolors = true  -- Enable true colors
vim.o.signcolumn = "yes"  -- Always show sign column
vim.o.scrolloff = 3  -- Keep cursor 8 lines from screen edge

-- Indentation & Tabs
vim.o.expandtab = true  -- Use spaces instead of tabs
vim.o.tabstop = 4  -- Tab size of 4 spaces
vim.o.softtabstop = 4  -- Makes backspace and <Tab> behave consistently
vim.o.shiftwidth = 4  -- Indentation level
vim.o.smartindent = true  -- Auto-indent new lines
vim.o.autoindent = true  -- Copy indentation from the previous line

vim.o.statusline = "%m %y %r %=%-14.(%l,%c%V%) %P [%{mode()}]"

-- Paste
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"

-- Neovim の背景を透明にする
vim.api.nvim_set_hl(0, "Normal",      { bg = "none" })
vim.api.nvim_set_hl(0, "NormalNC",    { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "none" })

-- -- Performance
-- vim.o.updatetime = 300  -- Faster UI updates
-- vim.o.timeoutlen = 300  -- Reduce key mapping timeout
-- vim.o.hidden = true  -- Keep buffers open in the background
-- 
-- -- Clipboard Integration
-- vim.o.clipboard = "unnamedplus"  -- Use system clipboard
-- 
-- -- Search & Navigation
-- vim.o.ignorecase = true  -- Ignore case in searches
-- vim.o.smartcase = true  -- Case-sensitive if uppercase is used
-- vim.o.incsearch = true  -- Highlight matches while searching
-- vim.o.hlsearch = false  -- Do not highlight search results
-- 
-- -- Undo & Backup
-- vim.o.undofile = true  -- Enable persistent undo
vim.o.swapfile = false  -- Disable swap files

-- -- Split Windows Behavior
-- vim.o.splitbelow = true  -- Open new horizontal splits below
-- vim.o.splitright = true  -- Open new vertical splits to the right
-- 
