return {
  "akinsho/toggleterm.nvim",
  enabled = true, -- enabled->true,disable->false
  version = "*",              -- 最新安定版
  cmd = { "ToggleTerm" },     -- コマンド呼び出しで遅延ロード
  keys = {
    { "<leader>tt", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
  },
  opts = {
    size = 15,                -- デフォルトの高さ/幅
    open_mapping = [[<c-\>]], -- <C-\> でトグル（好みに変更可）
    shade_terminals = true,
    direction = "float",      -- "horizontal" | "vertical" | "tab" | "float"
    float_opts = {
      border = "curved",
    },
  },
}
