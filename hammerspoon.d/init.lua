------------------------------------------------------------
-- WezTerm フォーカス時は常に英数入力にする
------------------------------------------------------------
local appWatcher = hs.application.watcher.new(function(appName, eventType)
  if eventType == hs.application.watcher.activated and appName == "WezTerm" then
    -- 入力ソースを ABC（英数）に固定
    hs.keycodes.currentSourceID("com.apple.keylayout.ABC")
    -- hs.alert.show("WezTerm → 英数入力に切替")
  end
end)
appWatcher:start()

-- 起動直後に Hammerspoon の余計なウィンドウを閉じる
hs.timer.doAfter(0.5, function()
  local app = hs.appfinder.appFromName("Hammerspoon")
  if not app then return end
  for _, w in ipairs(app:allWindows()) do
    local title = w:title() or ""
    if title:match("Preferences") or title:match("Console") then
      w:close()
    end
  end
end)

-- すぐ閉じる＋少し待ってもう一度（遅れて開く対策）
hs.timer.doAfter(0.5, closeHSWindows)
hs.timer.doAfter(2.0, closeHSWindows)
