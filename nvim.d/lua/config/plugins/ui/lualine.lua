-- ~/.config/nvim/lua/config/plugins/lualine.lua
return {
  "nvim-lualine/lualine.nvim",
  -- enabled = false, -- enabled->false
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- アイコン表示が必要なら
  opts = {
    options = {
      theme = "auto",        -- colorscheme に合わせて自動
      section_separators = "",
      component_separators = "",
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "branch", "diff", "diagnostics" },
      lualine_c = { "filename" },
      lualine_x = { "encoding", "fileformat", "filetype" },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
  },
}
