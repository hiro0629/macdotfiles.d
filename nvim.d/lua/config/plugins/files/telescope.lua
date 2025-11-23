-- files/telescope.lua
return {
  "nvim-telescope/telescope.nvim",
  enabled = true, -- enabled->true,disable->false
  cmd = "Telescope",

  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make", -- mac / WSL ならこれでOK（要: make）
    },
  },

  -- ✅ よく使うマッピング
  keys = {
    -- ファイル検索（プレビュー付き）
    {
      "<leader>ff",
      function()
        require("telescope.builtin").find_files({
          previewer = true, -- プレビューを有効化
        })
      end,
      desc = "Telescope: Find Files (with preview)",
    },

    -- プロジェクト内全文検索（rg）
    {
      "<leader>fg",
      function()
        require("telescope.builtin").live_grep()
      end,
      desc = "Telescope: Live Grep",
    },

    -- バッファ一覧
    {
      "<leader>fb",
      function()
        require("telescope.builtin").buffers({
          sort_mru = true,              -- 最近使った順に並べる
          ignore_current_buffer = true, -- 今のバッファはリストから除外
        })
      end,
      desc = "Telescope: Buffers",
    },

    -- 最近開いたファイル履歴
    {
      "<leader>fo",
      function()
        require("telescope.builtin").oldfiles({
          previewer = true,
          only_cwd = false, -- プロジェクト横断で履歴を表示
        })
      end,
      desc = "Telescope: Recent files",
    },

    -- Git status
    {
      "<leader>gs",
      function()
        require("telescope.builtin").git_status({
          previewer = true,
        })
      end,
      desc = "Telescope: Git status",
    },
  },

  -- ✅ Telescope 全体設定
  opts = {
    defaults = {
      -- ファイル候補の表示形式:
      -- 左にファイル名、その右にディレクトリパスを表示する
      -- 例:  init.lua  nvim/lua/config/
      path_display = { "filename_first" },

      -- レイアウト設定：常にプレビューが出るように調整
      layout_strategy = "horizontal",
      layout_config = {
        preview_width = 0.5,  -- 画面の 50% をプレビューに
        preview_cutoff = 1,   -- 幅が狭くてもプレビューを消さない
      },

      mappings = {},
    },

    -- 🔽 pickers.buffers にデフォルト設定
    pickers = {
      buffers = {
        sort_mru = true,
        ignore_current_buffer = true,
        previewer = true,
      },
    },

    -- 🔽 fzf 拡張の設定（おすすめ値）
    extensions = {
      fzf = {
        fuzzy = true,                    -- あいまい検索
        override_generic_sorter = true,  -- 全般 sorter を fzf に置き換え
        override_file_sorter = true,     -- ファイル sorter も fzf に
        case_mode = "smart_case",        -- 大文字あり→厳密 / なし→ignore case
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
