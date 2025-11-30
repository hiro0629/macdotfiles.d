-- ~/.config/wezterm/wezterm.lua (macOS 用)

local wezterm = require("wezterm")

-- ★ 同じディレクトリの keymap.lua を確実に読み込む
local keymaps = dofile(wezterm.config_dir .. "/keymap.lua")

-- config_builder 対応（ある場合はそれを使う）
local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

local act = wezterm.action

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

-- ★ タイトルバーのフォント（タブ文字サイズは本体の 0.6 倍）
config.window_frame = {
  font = wezterm.font("Hack Nerd Font", { weight = "Medium" }),
  font_size = config.font_size * 0.6,
  active_titlebar_bg = "none",
  inactive_titlebar_bg = "none",
}

-- 背景グラデーション
config.window_background_gradient = {
  orientation = { Linear = { angle = -50.0 } },
  colors = {
    "#0f0c29",
    "#282a36",
    "#343746",
    "#3a3f52",
    "#343746",
    "#282a36",
  },
  interpolation = "Linear",
  blend = "Rgb",
  noise = 64,
  segment_size       = 11,
  segment_smoothness = 1.0,
}

config.show_new_tab_button_in_tab_bar = false
config.scrollback_lines = 3500
config.exit_behavior    = "CloseOnCleanExit"
config.native_macos_fullscreen_mode = false

------------------------------------------------------------
-- ★ タブバー：Linux 版から移植したカラー設定
------------------------------------------------------------
config.colors = {
  tab_bar = {
    background = "#11111b",

    -- ★ カレントタブ（アクティブタブ）
    active_tab = {
      -- bg_color = "#7aa2f7",
      -- bg_color = "#7096e6",
      bg_color = "#5774b3",
      -- fg_color = "#f7f7f7",
      fg_color = "#79e0f7",
      intensity = "Bold",
      underline = "None",
      italic = false,
      strikethrough = false,
    },

    -- 非アクティブタブ
    inactive_tab = {
      bg_color = "#313244",
      -- fg_color = "#cdd6f4",
      fg_color = "#c0c0c0",
      intensity = "Normal",
      underline = "None",
      italic = false,
      strikethrough = false,
    },

    -- 非アクティブタブ + ホバー
    inactive_tab_hover = {
      bg_color = "#45475a",
      fg_color = "#f5e0dc",
      intensity = "Normal",
      underline = "None",
      italic = false,
      strikethrough = false,
    },

    -- 新しいタブボタン
    new_tab = {
      bg_color = "#11111b",
      fg_color = "#cdd6f4",
      intensity = "Normal",
      underline = "None",
      italic = false,
      strikethrough = false,
    },
    new_tab_hover = {
      bg_color = "#181825",
      fg_color = "#f5e0dc",
      intensity = "Normal",
      underline = "None",
      italic = false,
      strikethrough = false,
    },

    inactive_tab_edge = "none",
  },

  -- split の線の色
  split = "#8699C0",
}

------------------------------------------------------------
-- ★ タブタイトル：カレントディレクトリの末尾2フォルダを表示
-- 例: ~/Projects/FXsystem/DB → "FXsystem/DB"
-- （📂 を付けたければ return "📂 " .. tail に変更）
------------------------------------------------------------
local function cwd_tail_two(pane)
  local cwd_uri = pane.current_working_dir
  if not cwd_uri then
    return ""
  end

  -- Url オブジェクト → 文字列に変換（"file:///Users/..."）
  local cwd = tostring(cwd_uri)
  cwd = cwd:gsub("^file://", "")  -- "file://" プレフィックスを削除

  -- パスを / で分割して末尾2要素を取り出す
  local parts = {}
  for part in cwd:gmatch("[^/]+") do
    table.insert(parts, part)
  end

  if #parts == 0 then
    return ""
  end

  local last  = parts[#parts]
  local prev  = parts[#parts - 1]

  local tail
  if prev then
    tail = prev .. "/" .. last
  else
    tail = last
  end

  -- アイコン付きにしたいなら↓を使う:
  -- return "📂 " .. tail
  return tail
end

wezterm.on("format-tab-title", function(tab, tabs, panes, cfg, hover, max_width)
  local title = cwd_tail_two(tab.active_pane)
  if title == "" then
    -- CWD が取れないときはデフォルトタイトル
    title = tab.active_pane.title
  end

  return {
    { Text = " " .. title .. " " },
  }
end)

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

------------------------------------------------------------
-- マウス設定（右クリックでコピー）
------------------------------------------------------------
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
