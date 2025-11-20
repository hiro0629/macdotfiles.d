return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = true,
    branch = "v3.x", -- ← v4 ではなく v3.x を使い続けるならここは v3.x
                     -- v4 を使う場合は branch 行を削除

    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },

    keys = {
      { "<leader>fe", "<cmd>Neotree toggle<CR>", desc = "Neo-tree Toggle" },
      { "<leader>fE", "<cmd>Neotree focus<CR>",  desc = "Neo-tree Focus"  },
    },

    config = function()
      require("neo-tree").setup({
        close_if_last_window = true,
        popup_border_style = "rounded",
        enable_git_status = true,
        enable_diagnostics = true,

        filesystem = {
          follow_current_file = { enabled = true }, -- ★ v4形式
          hijack_netrw_behavior = "disabled",
          filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = true,
          },
        },

        buffers = {
          follow_current_file = { enabled = true }, -- ★ v4形式
        },

        git_status = {
          window = { position = "float" },
        },
      })
    end,
  }
}
