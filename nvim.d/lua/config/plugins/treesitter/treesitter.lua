-- treesitter/treesitter.lua
return {
  "nvim-treesitter/nvim-treesitter",
--  enabled = false,
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    ensure_installed = { "lua","vim","bash","markdown","javascript","typescript","python" },
    highlight = { enable = true },
    indent = { enable = true },
  },
}
