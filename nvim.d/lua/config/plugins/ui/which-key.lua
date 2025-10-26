-- lua/config/plugins/ui/which-key.lua
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  config = function()
    local wk = require("which-key")
    wk.setup({})

    wk.add({
      { "<leader>a", group = "ai" },
      { "<leader>d", group = "database" },
      { "<leader>e", group = "editing" },
      { "<leader>f", group = "files" },
      { "<leader>g", group = "git" },
      { "<leader>l", group = "lsp" },
      { "<leader>m", group = "markdown" },
      { "<leader>t", group = "terminal" },
      { "<leader>u", group = "ui" },
    })
  end,
}
