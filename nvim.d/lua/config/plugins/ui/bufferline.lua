-- lua/plugins/bufferline.lua
return {
  "akinsho/bufferline.nvim",
  enabled = true, -- enabled->true,disable->false
  event = "VeryLazy",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    options = {
      diagnostics = "nvim_lsp",
      separator_style = "slant", -- "thin", "slant", "slope", etc.
      show_buffer_close_icons = false,
      show_close_icon = false,
      always_show_bufferline = true,
    },
  },
  config = function(_, opts)
    require("bufferline").setup(opts)

    -- キーマップ（VSCode のようにタブ操作）
    vim.keymap.set("n", "<Tab>", "<Cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
    vim.keymap.set("n", "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", { desc = "Prev buffer" })
  end,
}
