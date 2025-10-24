-- =========================
-- init.lua
-- =========================

-- 先に <leader> を決める（プラグインより前に必要）
vim.g.mapleader = " "  -- Set <Space> as the leader key
-- vim.g.maplocalleader = ","

-- 基本設定とキーマップ
require("options")
require("keymaps")

-- lazy.nvim のセットアップ（プラグインはまだ空）
require("config.lazy")

-- 自動コマンド（最後に）
require("config.autocmds")
