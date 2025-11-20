-- lua/plugins/noice.lua
return {
  "folke/noice.nvim",
  enabled = true, -- enabled->true,disable->false
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  opts = {
    lsp = {
      progress = { enabled = true },
      hover = { enabled = true },
      signature = { enabled = true },
    },
    presets = {
      bottom_search = true,        -- VSCode 風検索UI
      command_palette = true,      -- VSCode 風コマンドパレット
      long_message_to_split = true,
      inc_rename = false,
    },
  },
  config = function(_, opts)
    require("noice").setup(opts)
    -- notify をデフォルトに切替
    vim.notify = require("notify")
  end,
}
