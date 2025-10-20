local wezterm = require("wezterm")
local keymaps = require("keybind")

-- 1つだけ作る
local config = wezterm.config_builder and wezterm.config_builder() or {}

-- カラースキーム
-- config.color_scheme = 'AdventureTime'
-- config.color_scheme = 'Dracula+'
-- config.color_scheme = 'Dark Ocean'
config.color_scheme = "nightfox"

-- 初期サイズ
config.initial_cols = 92
config.initial_rows = 30

-- フォント
config.font = wezterm.font("Hack Nerd Font", {weight="Medium", stretch="Normal", style="Normal"})
config.font_size = 23

-- ウィンドウ系
config.window_background_opacity = 0.7 -- 最終の値を1か所に
config.automatically_reload_config = true
config.window_close_confirmation = "NeverPrompt"
config.default_cursor_style = "BlinkingBar"
config.macos_window_background_blur = 0
config.window_decorations = "NONE"
config.window_frame = {
  inactive_titlebar_bg = "none",
  active_titlebar_bg = "none",
}
config.window_background_gradient = {
  colors = { "#192330" },
}
config.show_new_tab_button_in_tab_bar = false

-- colors をまとめる（tab_bar と split を同じテーブルに）
config.colors = {
  tab_bar = {
    inactive_tab_edge = "none",
  },
  split = "#8699C0",
}

-- タブタイトル
wezterm.on("format-tab-title", function(tab, tabs, panes, cfg, hover, max_width)
  local background = "#2f1922"
  local foreground = "#5c6d74"
  if tab.is_active then
    background = "#e6dccf"
    foreground = "#FFFFFF"
  end
  local title = "   " .. wezterm.truncate_right(tab.active_pane.title, max_width - 1) .. "   "
  return {
    { Background = { Color = background } },
    { Foreground = { Color = foreground } },
    { Text = title },
  }
end)

-- Scrollback
config.scrollback_lines = 3500

-- Actions
local act = wezterm.action

-- キーは1回だけ作成し、あとから追記
config.keys = {
  -- 片方だけ残す（必要なら別のキーへ）
  { key = "v", mods = "CTRL", action = act.PasteFrom("Clipboard") },
}

-- 透明度トグル
local is_transparent = true
wezterm.on("toggle-opacity", function(window, pane)
  is_transparent = not is_transparent
  local new_opacity = is_transparent and 0.88 or 0.7
  window:set_config_overrides({ window_background_opacity = new_opacity })
end)

-- Leader + c を追記
table.insert(config.keys, {
  key = "c",
  mods = "LEADER",
  action = wezterm.action.EmitEvent("toggle-opacity"),
})

-- 右クリック貼り付け
config.mouse_bindings = {
  {
    event = { Down = { streak = 1, button = "Right" } },
    mods = "NONE",
    action = act({ PasteFrom = "Clipboard" }),
  },
}

-- 外部キー定義をマージ
config.leader = keymaps.leader
for _, keymap in ipairs(keymaps.keys) do
  table.insert(config.keys, keymap)
end

config.exit_behavior = "CloseOnCleanExit"

return config
