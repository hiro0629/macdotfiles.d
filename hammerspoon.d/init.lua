------------------------------------------------------------
-- Hammerspoon Key Launcher (Leader = Ctrl+J)
--
-- [Launcher keys]
--   a : PWA ChatGPT  (Vivaldi/Chrome系 PWA 起動/フォーカス)
--   g : ChatGPT      (デスクトップ版 起動/フォーカス)
--   t : WezTerm      (起動/フォーカス)   ★入替済
--   w : TradingView  (起動/フォーカス)   ★入替済
--   c : Google Chrome(起動/フォーカス)
--   o : Obsidian     (起動/フォーカス)
--   v : VimR         (~/Tmp をCWDにして新規起動)
--   f : Maximize <-> Restore（Spaceを増やさない独自最大化）
--   x : Zoom（緑ボタン相当、FSならまず解除）
--   s : Screenshot, rename and save into ~/Pictures/Screenshots
--
-- [Auto behaviors]
--   • WezTerm 前面時は英数(ABC)を強制（即時＋短遅延2回＋軽量ウォッチ）
--   • Hammerspoon 起動直後に Preferences/Console を自動クローズ
------------------------------------------------------------

hs.application.enableSpotlightForNameSearches(true)

------------------------------------------------------------
-- 設定
------------------------------------------------------------
local HOME = os.getenv("HOME")
local ABC  = "com.apple.keylayout.ABC"

-- WezTerm 英数固定ウォッチ
local ENABLE_WEZTERM_IME_WATCHDOG = true
local WEZTERM_IME_WATCH_INTERVAL  = 2.0

------------------------------------------------------------
-- WezTerm 前面で英数固定
------------------------------------------------------------
local function forceLatin()
  if hs.eventtap.isSecureInputEnabled() then
    hs.alert.show("Secure Input有効中: 英数切替がブロックされています")
    return
  end
  if hs.keycodes.currentSourceID() == ABC then return end
  hs.keycodes.currentSourceID(ABC); if hs.keycodes.currentSourceID() == ABC then return end
  hs.keycodes.setLayout("ABC");     if hs.keycodes.currentSourceID() == ABC then return end
  hs.eventtap.keyStroke({}, "japanese_eisuu", 0)
end

local function setLatinRobust()
  forceLatin()
  hs.timer.doAfter(0.07, forceLatin)
  hs.timer.doAfter(0.25, forceLatin)
end

local appWatcher = hs.application.watcher.new(function(appName, eventType)
  if eventType == hs.application.watcher.activated and appName == "WezTerm" then
    setLatinRobust()
  end
end)
appWatcher:start()

local wf_wez = hs.window.filter.new(false)
wf_wez:allowApp("WezTerm")
wf_wez:subscribe(hs.window.filter.windowFocused, function() setLatinRobust() end)

if ENABLE_WEZTERM_IME_WATCHDOG then
  hs.timer.doEvery(WEZTERM_IME_WATCH_INTERVAL, function()
    local app = hs.application.frontmostApplication()
    if app and app:name() == "WezTerm" then forceLatin() end
  end)
end

------------------------------------------------------------
-- Hammerspoon 起動直後に余計なウィンドウを閉じる
------------------------------------------------------------
hs.timer.doAfter(0.5, function()
  local app = hs.appfinder.appFromName("Hammerspoon")
  if not app then return end
  for _, w in ipairs(app:allWindows()) do
    local t = w:title() or ""
    if t:match("Preferences") or t:match("Console") then w:close() end
  end
end)

------------------------------------------------------------
-- ユーティリティ
------------------------------------------------------------
local function getCurrentWindow()
  local function ok(w) return w and w:isStandard() and not w:isMinimized() and w:isVisible() end
  local win = hs.window.focusedWindow(); if ok(win) then return win end
  local app = hs.application.frontmostApplication()
  if app then
    win = app:mainWindow(); if ok(win) then return win end
    for _, w in ipairs(app:allWindows()) do if ok(w) then return w end end
  end
  local pt = hs.mouse.getAbsolutePosition()
  if hs.window.windowAtPoint then
    win = hs.window.windowAtPoint(pt); if ok(win) then return win end
  end
  for _, w in ipairs(hs.window.orderedWindows()) do if ok(w) then return w end end
  if hs.window.frontmostWindow then
    win = hs.window.frontmostWindow(); if ok(win) then return win end
  end
  return nil
end

local function framesEqual(a, b, tol)
  tol = tol or 2
  return math.abs(a.x-b.x)<=tol and math.abs(a.y-b.y)<=tol and
         math.abs(a.w-b.w)<=tol and math.abs(a.h-b.h)<=tol
end

local function launch_or_focus(opts)
  if opts.bundle_ids then
    for _, id in ipairs(opts.bundle_ids) do
      if hs.application.launchOrFocusByBundleID(id) then return true end
    end
  end
  if opts.name and hs.application.launchOrFocus(opts.name) then return true end
  if opts.path then
    local cmd = opts.open_arg and string.format([[open -a "%s" "%s"]], opts.path, opts.open_arg)
                              or string.format([[open -a "%s"]], opts.path)
    hs.execute(cmd, true); return true
  end
  return false
end

------------------------------------------------------------
-- 個別：ChatGPT / PWA ChatGPT
------------------------------------------------------------
local function focusChatGPT()
  local IDS = { "com.openai.chat", "com.openai.chat.release", "com.openai.chat.beta" }
  for _, id in ipairs(IDS) do if hs.application.launchOrFocusByBundleID(id) then return true end end
  if hs.application.launchOrFocus("ChatGPT") then return true end
  local found = hs.execute([[mdfind 'kMDItemCFBundleIdentifier=="com.openai.chat" || kMDItemDisplayName=="ChatGPT"' | head -n1]], true)
  found = found and found:gsub("%s+$","")
  if found and found:match("^/") then hs.execute(string.format([[open -a "%s"]], found), true); return true end
  for _, p in ipairs({ "/Applications/ChatGPT.app", HOME.."/Applications/ChatGPT.app" }) do
    if hs.fs.attributes(p) then hs.execute(string.format([[open -a "%s"]], p), true); return true end
  end
  hs.alert.show("ChatGPT not found"); return false
end

local function focusPWAChatGPT()
  local IDS = { "com.vivaldi.Vivaldi.app.cadlkienfkclaiaibeoongdcgmdikeeg" }
  for _, id in ipairs(IDS) do if hs.application.launchOrFocusByBundleID(id) then return true end end
  local fixed = HOME .. "/Applications/Chrome Apps.localized/PWAChatGPT.app"
  if hs.fs.attributes(fixed) then hs.execute(string.format([[open -a "%s"]], fixed), true); return true end
  local found = hs.execute([[mdfind 'kMDItemFSName=="PWAChatGPT.app"' | head -n1]], true)
  found = found and found:gsub("%s+$","")
  if found and found:match("^/") then hs.execute(string.format([[open -a "%s"]], found), true); return true end
  hs.alert.show("PWA ChatGPT not found"); return false
end

------------------------------------------------------------
-- ターゲットアプリ
------------------------------------------------------------
local targets = {
  t = { bundle_ids = { "com.github.wez.wezterm", "org.wezfurlong.wezterm" }, name = "WezTerm" },
  w = { bundle_ids = { "com.tradingview.desktop" }, name = "TradingView" },
  c = { bundle_ids = { "com.google.Chrome" }, name = "Google Chrome" },
  o = { bundle_ids = { "md.obsidian" }, name = "Obsidian" },
}

------------------------------------------------------------
-- VimR を ~/Tmp にして新規起動
------------------------------------------------------------
local function focusVimRInTmp()
  local tmp = HOME .. "/Tmp"
  hs.fs.mkdir(tmp)
  local cli = "/opt/homebrew/bin/vimr"
  if hs.fs.attributes(cli) then
    local ok = hs.execute(string.format([[%q -n --cwd %q]], cli, tmp), true)
    if ok then return end
    ok = hs.execute(string.format([[%q -n -c %q]], cli, "cd " .. tmp), true)
    if ok then return end
  end
  hs.execute(string.format([[open -n -a "VimR" %q]], tmp), true)
  hs.timer.doAfter(0.6, function()
    local app = hs.application.frontmostApplication()
    if app and app:name() == "VimR" then
      hs.eventtap.keyStrokes(":cd " .. tmp)
      hs.eventtap.keyStroke({}, "return")
    end
  end)
end

------------------------------------------------------------
-- 独自最大化/復元 & 緑ボタン相当
------------------------------------------------------------
local savedFrames = {}
local function toggleMaximizeCurrentWindow()
  local win = getCurrentWindow()
  if not win then hs.alert.show("No focusable window"); return end
  win:focus()
  local id  = win:id()
  local scr = win:screen():frame()
  local cur = win:frame()
  if framesEqual(cur, scr, 2) then
    local prev = savedFrames[id]
    if prev then win:setFrame(prev, 0); savedFrames[id] = nil
    else
      local w, h = math.floor(scr.w*0.7), math.floor(scr.h*0.7)
      local x = scr.x + math.floor((scr.w - w)/2)
      local y = scr.y + math.floor((scr.h - h)/2)
      win:setFrame({x=x,y=y,w=w,h=h}, 0)
    end
  else
    savedFrames[id] = cur
    win:setFrame(scr, 0)
  end
end

local function toggleZoomLikeGreen()
  local win = getCurrentWindow()
  if not win then hs.alert.show("No focusable window"); return end
  if win:isFullScreen() then win:setFullScreen(false); return end
  local ok = pcall(function() win:toggleZoom() end)
  if ok then return end
  local btn = win:zoomButton()
  if btn then btn:performAction("AXPress") else hs.alert.show("Zoom button not available") end
end

------------------------------------------------------------
-- Leader = Ctrl+J
------------------------------------------------------------
local leader = hs.hotkey.modal.new({ "ctrl" }, "j")
local function exitLeader() leader:exit() end
leader.entered = function() hs.timer.doAfter(0.8, function() leader:exit() end) end

local function bind_leader(letter, fn)
  leader:bind({}, letter, function() (fn or function() end)(); exitLeader() end)
  leader:bind({ "ctrl" }, letter, function() (fn or function() end)(); exitLeader() end)
end

------------------------------------------------------------
-- スクリーンショット（部分選択 → ~/Pictures/Screenshots/screen_shot_YYYYMMDD_HHMMSS.png）
------------------------------------------------------------
local function takePartialScreenshotToPictures()
  local dir = HOME .. "/Pictures/Screenshots"
  if not hs.fs.attributes(dir) then hs.fs.mkdir(dir) end
  local ts  = os.date("%Y%m%d_%H%M%S")
  local file = string.format("%s/screen_shot_%s.png", dir, ts)

  -- -i: 範囲選択, -o: シャッター音なし
  local task = hs.task.new("/usr/sbin/screencapture",
    function(exitCode, _, err)
      if exitCode == 0 then
        hs.alert.show("Saved: " .. file)
      else
        hs.alert.show("screencapture error: " .. (err or tostring(exitCode)))
      end
    end,
    { "-i", "-o", file }
  )
  task:start()
end

------------------------------------------------------------
-- キーバインド
------------------------------------------------------------
bind_leader("t", function() launch_or_focus(targets.t) end) -- WezTerm
bind_leader("w", function() launch_or_focus(targets.w) end) -- TradingView
bind_leader("c", function() launch_or_focus(targets.c) end) -- Chrome
bind_leader("o", function() launch_or_focus(targets.o) end) -- Obsidian
bind_leader("v", function() focusVimRInTmp() end) -- VimR

bind_leader("a", function() focusPWAChatGPT() end) -- PWA ChatGPT
bind_leader("g", function() focusChatGPT() end) -- ChatGPT

bind_leader("f", function() toggleMaximizeCurrentWindow() end)
bind_leader("x", function() toggleZoomLikeGreen() end)

bind_leader("s", function() takePartialScreenshotToPictures() end) -- Screenshot
