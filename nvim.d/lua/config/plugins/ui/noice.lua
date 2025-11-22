-- lua/plugins/noice.lua
return {
  "folke/noice.nvim",
  enabled = true,
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

    -- 🔽 ここで notify をちゃんと初期化する
    local notify = require("notify")
    notify.setup({
      -- この色が「100% 透明のベース色」として使われる
      -- 好きな色に変えてOK（例: "#1e1e2e" とか）
      background_colour = "#000000",
    })

    -- Neovim のデフォルト通知を notify に差し替え
    vim.notify = notify
  end,
}

