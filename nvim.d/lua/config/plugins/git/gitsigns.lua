-- ~/.config/nvim/lua/plugins/gitsigns.lua
return {
  {
    "lewis6991/gitsigns.nvim",
    enabled = true, -- enabled->false,disable->true
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add          = { text = "│" },
        change       = { text = "│" },
        delete       = { text = "_" },
        topdelete    = { text = "‾" },
        changedelete = { text = "~" },
      },
      -- Git 関連のキーマップ（LazyVim に馴染むよう最小限）
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end

        map("n", "]h", gs.next_hunk,  "Gitsigns: Next Hunk")
        map("n", "[h", gs.prev_hunk,  "Gitsigns: Prev Hunk")
        map("n", "<leader>hs", gs.stage_hunk,  "Gitsigns: Stage Hunk")
        map("n", "<leader>hr", gs.reset_hunk,  "Gitsigns: Reset Hunk")
        map("n", "<leader>hb", gs.blame_line,  "Gitsigns: Blame Line")
        map("n", "<leader>hd", gs.diffthis,    "Gitsigns: Diff This")
        map("n", "<leader>hD", function() gs.diffthis("~") end, "Gitsigns: Diff This (cached)")
      end,
    },
  },
}
