-- lua/config/plugins/git/diffview.lua
return {
  "sindrets/diffview.nvim",
  enabled = true,
  cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>gd", "<cmd>DiffviewOpen<cr>",  desc = "Diffview: Open" },
    { "<leader>gq", "<cmd>DiffviewClose<cr>", desc = "Diffview: Close" },
  },
  opts = {},
}
