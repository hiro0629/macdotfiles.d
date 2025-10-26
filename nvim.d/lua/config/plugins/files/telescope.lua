-- files/telescope.lua
return {
  "nvim-telescope/telescope.nvim",
  enabled = true, -- enabled->true,disable->false
  cmd = "Telescope",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>ff", function() require("telescope.builtin").find_files() end, desc = "Find Files" },
    { "<leader>fg", function() require("telescope.builtin").live_grep() end,  desc = "Live Grep"  },
  },
  opts = { defaults = { mappings = {} } },
}
