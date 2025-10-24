-- =========================
-- lua/config/lazy.lua
-- =========================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

-- ないときだけ取得（初回だけ走る）
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- ここで lazy.nvim を起動
require("lazy").setup({
  spec = {
    { import = "config.plugins" },
  },

  -- UI を最小限に（必要なら後で変える）
  install = { colorscheme = { "default" } },
  checker = { enabled = false },     -- 自動更新チェックはオフ（後でオンに可）
  change_detection = { enabled = true, notify = false },

  performance = {
    rtp = {
      -- 不要なランタイムプラグインを無効化（起動高速化）
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})


