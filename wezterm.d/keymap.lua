local wezterm = require("wezterm")

local M = {}

-- ★ Leader を Ctrl+k に設定
M.leader = {
  key = "k",
  mods = "CTRL",
  timeout_milliseconds = 3000,
}

M.keys = {
  -- Ctrl+v → Visual Block (^V) 送信
  { key = "v", mods = "CTRL",  action = wezterm.action.SendString("\x16") },

  -- Copy mode
  { key = "c", mods = "LEADER", action = wezterm.action.ActivateCopyMode },

  -- タブ移動
  { key = "[", mods = "LEADER", action = wezterm.action.ActivateTabRelative(-1) },
  { key = "]", mods = "LEADER", action = wezterm.action.ActivateTabRelative(1) },

  -- 新しいタブ
  { key = "t", mods = "LEADER", action = wezterm.action.SpawnTab("DefaultDomain") },

  -- ペーン移動
  { key = "h", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Left")  },
  { key = "l", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Right") },
  { key = "j", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Down")  },
  { key = "k", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Up")    },

  -- 次/前ペーン
  { key = "n", mods = "LEADER", action = wezterm.action.ActivatePaneByIndex(1) },
  { key = "p", mods = "LEADER", action = wezterm.action.ActivatePaneByIndex(0) },

  -- 分割
  { key = "-", mods = "LEADER", action = wezterm.action.SplitVertical({   domain = "CurrentPaneDomain" }) },
  { key = "1", mods = "LEADER", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },

  -- お好み：Leader+b → 透明度トグル、Leader+f → フルスクリーン
  { key = "b", mods = "LEADER", action = wezterm.action.EmitEvent("toggle-opacity") },
  { key = "f", mods = "LEADER", action = wezterm.action.ToggleFullScreen },
}

return M
