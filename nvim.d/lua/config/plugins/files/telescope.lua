-- files/telescope.lua
return {
  "nvim-telescope/telescope.nvim",
  enabled = true, -- enabled->true,disable->false
  cmd = "Telescope",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
  },
  keys = {
    { "<leader>ff", function() require("telescope.builtin").find_files() end, desc = "Find Files" },
    { "<leader>fg", function() require("telescope.builtin").live_grep() end,  desc = "Live Grep"  },
  },
  opts = {
    defaults = {
      mappings = {},
    },
    -- 🔽 fzf 拡張の設定（おすすめ値）
    extensions = {
      fzf = {
        fuzzy = true,                    -- あいまい検索
        override_generic_sorter = true,  -- 全般 sorter を fzf に置き換え
        override_file_sorter = true,     -- ファイル sorter も fzf に
        case_mode = "smart_case",        -- 大文字含めたらcase sensitive / なければignore
      },
    },
  },
  -- 🔽 fzf 拡張を読み込む
  config = function(_, opts)
    local telescope = require("telescope")
    telescope.setup(opts)
    pcall(telescope.load_extension, "fzf")
  end,
}
