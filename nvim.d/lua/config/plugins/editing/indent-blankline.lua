return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl", -- 新しい呼び出し方法
  opts = {
    indent = { char = "│" },
    whitespace = {
      remove_blankline_trail = false,
    },
    scope = { enabled = true },
  },
}
