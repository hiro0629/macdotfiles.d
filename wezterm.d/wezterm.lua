local wezterm = require("wezterm")

-- ★ 同じディレクトリの keymap.lua を確実に読み込む
local keymaps = dofile(wezterm.config_dir .. "/keymap.lua")

local config = wezterm.config_builder and wezterm.config_builder() or {}
local act    = wezterm.action

------------------------------------------------------------
-- 基本設定 / 見た目
------------------------------------------------------------
config.color_scheme = "nightfox"
config.initial_cols = 92
config.initial_rows = 30

config.font      = wezterm.font("Hack Nerd Font", { weight = "Medium" })
config.font_size = 23

config.window_background_opacity     = 0.6
config.macos_window_background_blur  = 0
config.automatically_reload_config   = true
config.window_close_confirmation     = "NeverPrompt"
config.default_cursor_style          = "BlinkingBar"

-- タイトルバー＋リサイズのみ
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.window_frame = {
  inactive_titlebar_bg = "none",
  active_titlebar_bg   = "none",
}

-- ★ 背景グラデーション（軽めのドラキュラ風グラデ）
config.window_background_gradient = {
  -- Linear / Radial も指定可能。ここでは斜め方向の Linear に
  orientation = { Linear = { angle = -50.0 } },

  -- グラデーションに使う色
  colors = {
    "#0f0c29",
    "#282a36",
    "#343746",
    "#3a3f52",
    "#343746",
    "#282a36",
  },
  -- colors = { "Inferno" },

  -- "Linear", "Basis", "CatmullRom" が指定可能
  interpolation = "Linear",

  -- "Rgb", "LinearRgb", "Hsv", "Oklab"
  blend = "Rgb",

  -- バンディングを抑えるためのノイズ量
  noise = 64,

  -- セグメント／滑らかさ（軽いグラデなのでデフォ寄り設定）
  segment_size       = 11,
  segment_smoothness = 1.0,
}

config.show_new_tab_button_in_tab_bar = false
config.colors = {
  tab_bar = { inactive_tab_edge = "none" },
  split   = "#8699C0",
}

config.scrollback_lines = 3500
config.exit_behavior    = "CloseOnCleanExit"

-- ★ ネイティブのフルスクリーンを無効化（＝Spaceを増やさないシンプルFSへ）
config.native_macos_fullscreen_mode = false

------------------------------------------------------------
-- ステータス：Copy Mode 表示
------------------------------------------------------------
wezterm.on("update-right-status", function(window, _)
  local text = (window:active_key_table() == "copy_mode") and " 📋 COPY MODE " or ""
  window:set_right_status(text)
end)

------------------------------------------------------------
-- 透明度トグル（Leader+b で使用）
------------------------------------------------------------
local is_transparent = false
wezterm.on("toggle-opacity", function(window, _)
  is_transparent = not is_transparent
  if is_transparent then
    window:set_config_overrides({
      window_background_opacity    = 0.91,
      macos_window_background_blur = 20,
    })
  else
    window:set_config_overrides({
      window_background_opacity    = 0.6,
      macos_window_background_blur = 0,
    })
  end
end)

------------------------------------------------------------
-- キーバインド
------------------------------------------------------------
config.keys   = {}
config.leader = keymaps.leader
for _, km in ipairs(keymaps.keys) do
  table.insert(config.keys, km)
end

-- 右クリック：コピー（貼り付けはお好みで）
config.mouse_bindings = {
  {
    event  = { Down = { streak = 1, button = "Right" } },
    mods   = "NONE",
    action = act.CopyTo "Clipboard",
  },
  {
    event  = { Up = { streak = 1, button = "Right" } },
    mods   = "NONE",
    action = act.Nop,
  },
}

return config
