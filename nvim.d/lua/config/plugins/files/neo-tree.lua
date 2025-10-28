return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = true, -- enabled->true,disable->false
    branch = "v3.x", -- 安定版を指定
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- アイコン
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        close_if_last_window = true, -- 最後のウィンドウなら閉じる
        popup_border_style = "rounded",
        enable_git_status = true,
        enable_diagnostics = true,
        filesystem = {
          follow_current_file = { enabled = true }, -- カレントファイル追従
          hijack_netrw_behavior = "disabled",       -- ★ディレクトリ起動時に勝手にneo-treeが開かないようにする
          filtered_items = {
            hide_dotfiles = false, -- .ファイルも表示
            hide_gitignored = true,
          },
        },
        buffers = {
          follow_current_file = true, -- バッファ一覧も追従
        },
        git_status = {
          window = { position = "float" },
        },
      })

      -- キーマップ例
      vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { desc = "Neo-tree Toggle" })
      vim.keymap.set("n", "<leader>o", ":Neotree focus<CR>", { desc = "Neo-tree Focus" })
    end,
  }
}
