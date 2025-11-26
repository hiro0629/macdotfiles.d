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

-- ★ タブの文字サイズを本体の0.6倍に
config.window_frame = {
  font = wezterm.font("Hack Nerd Font", { weight = "Medium" }),
  font_size = config.font_size * 0.6,  -- ← ここで倍率調整（大きすぎれば 1.2 とかに）
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
-- ★ タブの色（カレントタブ: #7aa2f7）
------------------------------------------------------------
config.colors = {
  tab_bar = {
    background = "none",

    -- ★ アクティブ（カレント）タブ
    active_tab = {
      bg_color = "#7aa2f7",
      fg_color = "#1a1b26",   -- 読みやすい濃色
      intensity = "Bold",
      italic = false,
      underline = "None",
    },

    -- 非アクティブタブ
    inactive_tab = {
      bg_color = "none",
      fg_color = "#c0c0c0",
      intensity = "Normal",
      italic = false,
      underline = "None",
    },

    -- 非アクティブタブのホバー
    inactive_tab_hover = {
      bg_color = "#2b2d37",
      fg_color = "#e0e0e0",
      italic = false,
    },

    new_tab = {
      bg_color = "none",
      fg_color = "#6b6b6b",
    },
  },
}

------------------------------------------------------------
-- ステータス：Copy Mode 表示
------------------------------------------------------------
wezterm.on("update-right-status", function(window, _)
  local text = (window:active_key_table() == "copy_mode") and " 📋 COPY MODE " or ""
  window:set_right_status(text)
end)

------------------------------------------------------------
-- ★ タブタイトルをカレントディレクトリ名に
------------------------------------------------------------
wezterm.on("format-tab-title", function(tab, tabs, panes, _cfg, hover, max_width)
  local title   = tab.active_pane.title
  local cwd_uri = tab.active_pane.current_working_dir

  if cwd_uri then
    local cwd_str

    -- バージョンによって current_working_dir の型が違うので場合分け
    if type(cwd_uri) == "userdata" then
      -- 新しめの WezTerm: Url オブジェクト
      cwd_str = cwd_uri.file_path or ""
    elseif type(cwd_uri) == "string" then
      -- 古めの WezTerm: "file:///Users/..." の文字列
      cwd_str = cwd_uri
    else
      cwd_str = tostring(cwd_uri)
    end

    -- "file://..." を削る（文字列だった場合用）
    cwd_str = cwd_str:gsub("^file://", "")
    -- 末尾の / を削る
    cwd_str = cwd_str:gsub("/+$", "")
    -- 最後のパス名だけ抜き出す
    local cwd_name = cwd_str:match("([^/]+)$") or cwd_str

    if cwd_name ~= "" then
      title = cwd_name
    end
  end

  return {
    { Text = "  " .. title .. "  " },
  }
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

-- 右クリック：コピー
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
