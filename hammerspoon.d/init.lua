------------------------------------------------------------
-- Leader = Ctrl+J でアプリランチャ（起動 or 既存ウィンドウへフォーカス）
-- WezTermにフォーカスした時は ABC（英数）へ切替
------------------------------------------------------------
-- WezTerm フォーカス時は常に英数入力
local appWatcher = hs.application.watcher.new(function(appName, eventType)
  if eventType == hs.application.watcher.activated and appName == "WezTerm" then
    hs.keycodes.currentSourceID("com.apple.keylayout.ABC")
  end
end)
appWatcher:start()

-- 起動直後に Hammerspoon の余計なウィンドウを閉じる（簡易）
hs.timer.doAfter(0.5, function()
  local app = hs.appfinder.appFromName("Hammerspoon")
  if not app then return end
  for _, w in ipairs(app:allWindows()) do
    local t = w:title() or ""
    if t:match("Preferences") or t:match("Console") then w:close() end
  end
end)

------------------------------------------------------------
-- アプリ起動/フォーカス用ヘルパ（Bundle ID 優先 → 名前 → パス）
------------------------------------------------------------
local function launch_or_focus(opts)
  -- opts = { bundle_ids = {..}, name = "AppName", path = "/path/App.app", open_arg = nil or "dir/path" }
  if opts.bundle_ids then
    for _, id in ipairs(opts.bundle_ids) do
      if hs.application.launchOrFocusByBundleID(id) then return true end
    end
  end
  if opts.name and hs.application.launchOrFocus(opts.name) then
    return true
  end
  if opts.path then
    local cmd
    if opts.open_arg then
      -- 引数を渡して開く（例: VimR で特定フォルダ）
      cmd = string.format([[open -a "%s" "%s"]], opts.path, opts.open_arg)
    else
      cmd = string.format([[open -a "%s"]], opts.path)
    end
    hs.execute(cmd, true)
    return true
  end
  return false
end

------------------------------------------------------------
-- ターゲットアプリ定義（必要に応じて増やせます）
------------------------------------------------------------
local HOME = os.getenv("HOME")

local targets = {
  -- w: WezTerm（あなたの環境の BUNDLE ID を先頭に）
  w = { bundle_ids = { "com.github.wez.wezterm", "org.wezfurlong.wezterm" }, name = "WezTerm" },

  -- t: TradingView（デスクトップ版）
  t = { bundle_ids = { "com.tradingview.desktop" }, name = "TradingView" },

  -- c: Google Chrome
  c = { bundle_ids = { "com.google.Chrome"     }, name = "Google Chrome" },

  -- a: ChatGPT（App Store 版想定、無ければ name で）
  a = { bundle_ids = { "com.openai.chat", "com.openai.chat.release", "com.openai.chat.beta" }, name = "ChatGPT" },

  -- o: Obsidian
  o = { bundle_ids = { "md.obsidian"           }, name = "Obsidian" },

  -- g: PWA ChatGPT（Vivaldi PWA：あなたの実 ID）
  g = { bundle_ids = { "com.vivaldi.Vivaldi.app.cadlkienfkclaiaibeoongdcgmdikeeg" },
        name = "PWAChatGPT",
        path = HOME .. "/Applications/Chrome Apps.localized/PWAChatGPT.app" },

  -- v: VimR（~/Tmp を開く。既存起動があれば再利用。※毎回新規ではない）
  v = { bundle_ids = { "com.qvacua.VimR" }, name = "VimR", path = "VimR", open_arg = HOME .. "/Tmp" },
}

------------------------------------------------------------
-- Leader = Ctrl+J
------------------------------------------------------------
local leader = hs.hotkey.modal.new({ "ctrl" }, "j")
local function exitLeader() leader:exit() end
leader.entered = function() hs.timer.doAfter(0.6, function() leader:exit() end) end

-- Leader + key → 起動 or 既存へフォーカス（※新規起動は原則しない）
local function bind_leader(letter)
  leader:bind({}, letter, function()
    local t = targets[letter]
    if not t then return exitLeader() end
    -- VimR のフォルダは存在保障
    if letter == "v" then hs.fs.mkdir(HOME .. "/Tmp") end
    launch_or_focus(t)
    exitLeader()
  end)
  -- Ctrl押しっぱなしでも反応
  leader:bind({ "ctrl" }, letter, function()
    local t = targets[letter]
    if not t then return exitLeader() end
    if letter == "v" then hs.fs.mkdir(HOME .. "/Tmp") end
    launch_or_focus(t)
    exitLeader()
  end)
end

for _, k in ipairs({ "w", "t", "c", "a", "o", "g", "v" }) do
  bind_leader(k)
end
