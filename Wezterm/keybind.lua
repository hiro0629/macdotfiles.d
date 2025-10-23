local wezterm = require("wezterm")

-- Define leader key
local keymaps = {
  leader = { key = "j", mods = "CTRL" }, -- Set Leader Key
  keys = {
    -- Block visual mode
    {
      key = "v",
      mods = "CTRL",
      action = wezterm.action.SendString("\x16")
    },

    -- Copy mode
    {
      key = "y",
      mods = "LEADER",
      action = wezterm.action.ActivateCopyMode,
    },

    -- タブの管理
    {
      key = "[",
      mods = "LEADER",
      action = wezterm.action.ActivateTabRelative(-1), -- 前のタブへ移動
    },
    {
      key = "]",
      mods = "LEADER",
      action = wezterm.action.ActivateTabRelative(1), -- 次のタブへ移動
    },

    -- 新しいタブを開く
    {
      key = "t",
      mods = "LEADER",
      action = wezterm.action.SpawnTab("DefaultDomain"),
    },

    -- ペーンの移動
    {
      key = "h",
      mods = "LEADER",
      action = wezterm.action.ActivatePaneDirection("Left"),
    },
    {
      key = "l",
      mods = "LEADER",
      action = wezterm.action.ActivatePaneDirection("Right"),
    },
    {
      key = "j",
      mods = "LEADER",
      action = wezterm.action.ActivatePaneDirection("Down"),
    },
    {
      key = "k",
      mods = "LEADER",
      action = wezterm.action.ActivatePaneDirection("Up"),
    },

    -- 次のペーンへ移動 (ペーン番号順)
    {
      key = "n",
      mods = "LEADER",
      action = wezterm.action.ActivatePaneByIndex(1), -- 次のペーンへ
    },

    -- 前のペーンへ移動
    {
      key = "p",
      mods = "LEADER",
      action = wezterm.action.ActivatePaneByIndex(0), -- 最初のペーンへ
    },

    -- Pane Split
    {
      key = "-",
      mods = "LEADER",
      action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
    },
    {
      key = "1",
      mods = "LEADER",
      action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
    },
  },
}

return keymaps

