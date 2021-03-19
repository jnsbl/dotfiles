local hyper = {"cmd", "ctrl", "alt", "shift"}
local super = {"cmd", "ctrl", "alt"}

--------------------------------------------------------------------------------
-- Caffeine {{{
--------------------------------------------------------------------------------

-- caffeine = hs.menubar.new()
-- function setCaffeineDisplay(state)
--     if state then
--         caffeine:setTitle("AWAKE")
--     else
--         caffeine:setTitle("SLEEPY")
--     end
-- end
--
-- function caffeineClicked()
--     setCaffeineDisplay(hs.caffeinate.toggle("displayIdle"))
-- end
--
-- if caffeine then
--     caffeine:setClickCallback(caffeineClicked)
--     setCaffeineDisplay(hs.caffeinate.get("displayIdle"))
-- end
--
-- hs.hotkey.bind(super, "-", function()
--   caffeineClicked()
--   if hs.caffeinate.get("displayIdle") then
--     hs.notify.show("Caffeine", "AWAKE", "Your Mac will not sleep")
--   else
--     hs.notify.show("Caffeine", "SLEEPY", "Your Mac will sleep on its normal schedule")
--   end
-- end)

-- }}}

--------------------------------------------------------------------------------
-- Hammerspoon stuff {{{
--------------------------------------------------------------------------------

-- Reload configuration
hs.hotkey.bind(super, "R", function()
  if caffeine then
    caffeine:delete()
  end
  hs.reload()
end)
hs.notify.show("Hammerspoon", "", "Config loaded")
-- }}}

--------------------------------------------------------------------------------
-- Hyper key {{{
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Taken from https://gist.github.com/ttscoff/cce98a711b5476166792d5e6f1ac5907
--------------------------------------------------------------------------------

-- A global variable for the Hyper Mode
k = hs.hotkey.modal.new({}, "F17")

k:bind({}, '<', nil, function() hs.eventtap.keyStroke({"shift","alt"}, '§') end)

launch = function(appName)
  hs.application.launchOrFocus(appName)
  k.triggered = true
end

-- Single keybinding for app launch
singleApps = {
  {'a', 'Adium'},
  {'b', 'IntelliJ IDEA'},
  {'d', 'DevDocs'},
  {'e', 'SourceTree'},
  {'f', 'Finder'},
  {'g', 'TogglDesktop'},
  {'i', 'Insomnia'},
  {'k', 'Slack'},
  {'l', 'Sublime Text'},
  {'n', 'FSNotes'},
  {'o', 'Things'}, -- 'o' as in 'to-do'
  {'p', 'Spotify'},
  {'s', 'Brave Browser'}, -- 's' as in browser (and because 's' is easily reachable)
  {'t', 'iTerm'},
  {'u', 'Music'},
  {'v', 'VimR'},
  {'w', 'Visual Studio Code'},
  {'x', 'Endel'}, -- 'x' as in 'relax' or similar to a crosshair (~ focus)
  {'y', 'Skype'},
  {'z', 'Spark'},
}

for i, app in ipairs(singleApps) do
  k:bind({}, app[1], function() launch(app[2]); k:exit(); end)
end

-- Window movement
k:bind({}, "Up", function() k:exit(); hs.caffeinate.startScreensaver(); end)
k:bind({}, "Down", function() hs.caffeinate.lockScreen(); k:exit(); end)

-- Enter Hyper Mode when F18 (Hyper/Capslock) is pressed
pressedF18 = function()
  k.triggered = false
  k:enter()
end

-- Leave Hyper Mode when F18 (Hyper/Capslock) is pressed,
--   send ESCAPE if no other keys are pressed.
releasedF18 = function()
  k:exit()
  if not k.triggered then
    hs.eventtap.keyStroke({}, 'ESCAPE')
  end
end

-- Bind the Hyper key
f18 = hs.hotkey.bind({}, 'F18', pressedF18, releasedF18)

-- }}}

--------------------------------------------------------------------------------
-- Reusable functions {{{
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Taken from https://github.com/rtoshiro/hammerspoon-init/blob/master/init.lua
--------------------------------------------------------------------------------

function hs.screen.get(screen_name)
  local allScreens = hs.screen.allScreens()
  for i, screen in ipairs(allScreens) do
    if screen:name() == screen_name then
      return screen
    end
  end
end

-- Returns the width of the smaller screen size
-- isFullscreen = false removes the toolbar
-- and dock sizes
function hs.screen.minWidth(isFullscreen)
  local min_width = math.maxinteger
  local allScreens = hs.screen.allScreens()
  for i, screen in ipairs(allScreens) do
    local screen_frame = screen:frame()
    if (isFullscreen) then
      screen_frame = screen:fullFrame()
    end
    min_width = math.min(min_width, screen_frame.w)
  end
  return min_width
end

-- isFullscreen = false removes the toolbar
-- and dock sizes
-- Returns the height of the smaller screen size
function hs.screen.minHeight(isFullscreen)
  local min_height = math.maxinteger
  local allScreens = hs.screen.allScreens()
  for i, screen in ipairs(allScreens) do
    local screen_frame = screen:frame()
    if (isFullscreen) then
      screen_frame = screen:fullFrame()
    end
    min_height = math.min(min_height, screen_frame.h)
  end
  return min_height
end

-- If you are using more than one monitor, returns X
-- considering the reference screen minus smaller screen
-- = (MAX_REFSCREEN_WIDTH - MIN_AVAILABLE_WIDTH) / 2
-- If using only one monitor, returns the X of ref screen
function hs.screen.minX(refScreen)
  local min_x = refScreen:frame().x
  local allScreens = hs.screen.allScreens()
  if (#allScreens > 1) then
    min_x = refScreen:frame().x + ((refScreen:frame().w - hs.screen.minWidth()) / 2)
  end
  return min_x
end

-- If you are using more than one monitor, returns Y
-- considering the focused screen minus smaller screen
-- = (MAX_REFSCREEN_HEIGHT - MIN_AVAILABLE_HEIGHT) / 2
-- If using only one monitor, returns the Y of focused screen
function hs.screen.minY(refScreen)
  local min_y = refScreen:frame().y
  local allScreens = hs.screen.allScreens()
  if (#allScreens > 1) then
    min_y = refScreen:frame().y + ((refScreen:frame().h - hs.screen.minHeight()) / 2)
  end
  return min_y
end

-- If you are using more than one monitor, returns the
-- half of minX and 0
-- = ((MAX_REFSCREEN_WIDTH - MIN_AVAILABLE_WIDTH) / 2) / 2
-- If using only one monitor, returns the X of ref screen
function hs.screen.almostMinX(refScreen)
  local min_x = refScreen:frame().x
  local allScreens = hs.screen.allScreens()
  if (#allScreens > 1) then
    min_x = refScreen:frame().x + (((refScreen:frame().w - hs.screen.minWidth()) / 2) - ((refScreen:frame().w - hs.screen.minWidth()) / 4))
  end
  return min_x
end

-- If you are using more than one monitor, returns the
-- half of minY and 0
-- = ((MAX_REFSCREEN_HEIGHT - MIN_AVAILABLE_HEIGHT) / 2) / 2
-- If using only one monitor, returns the Y of ref screen
function hs.screen.almostMinY(refScreen)
  local min_y = refScreen:frame().y
  local allScreens = hs.screen.allScreens()
  if (#allScreens > 1) then
    min_y = refScreen:frame().y + (((refScreen:frame().h - hs.screen.minHeight()) / 2) - ((refScreen:frame().h - hs.screen.minHeight()) / 4))
  end
  return min_y
end

-- Returns the frame of the smaller available screen
-- considering the context of refScreen
-- isFullscreen = false removes the toolbar
-- and dock sizes
function hs.screen.minFrame(refScreen, isFullscreen)
  return {
    x = hs.screen.minX(refScreen),
    y = hs.screen.minY(refScreen),
    w = hs.screen.minWidth(isFullscreen),
    h = hs.screen.minHeight(isFullscreen)
  }
end

-- +-----------------+
-- |        |        |
-- |        |  HERE  |
-- |        |        |
-- +-----------------+
function hs.window.right(win)
  -- local minFrame = hs.screen.minFrame(win:screen(), false)
  local screen = win:screen()
  local minFrame = screen:frame()
  minFrame.x = minFrame.x + (minFrame.w/2)
  minFrame.w = minFrame.w/2
  win:setFrame(minFrame)
end

-- +-----------------+
-- |        |        |
-- |  HERE  |        |
-- |        |        |
-- +-----------------+
function hs.window.left(win)
  -- local minFrame = hs.screen.minFrame(win:screen(), false)
  local screen = win:screen()
  local minFrame = screen:frame()
  minFrame.w = minFrame.w/2
  win:setFrame(minFrame)
end

-- +-----------------+
-- |      HERE       |
-- +-----------------+
-- |                 |
-- +-----------------+
function hs.window.up(win)
  local minFrame = hs.screen.minFrame(win:screen(), false)
  minFrame.h = minFrame.h/2
  win:setFrame(minFrame)
end

-- +-----------------+
-- |                 |
-- +-----------------+
-- |      HERE       |
-- +-----------------+
function hs.window.down(win)
  local minFrame = hs.screen.minFrame(win:screen(), false)
  minFrame.y = minFrame.y + minFrame.h/2
  minFrame.h = minFrame.h/2
  win:setFrame(minFrame)
end

-- +-----------------+
-- |  HERE  |        |
-- +--------+        |
-- |                 |
-- +-----------------+
function hs.window.upLeft(win)
  local minFrame = hs.screen.minFrame(win:screen(), false)
  minFrame.w = minFrame.w/2
  minFrame.h = minFrame.h/2
  win:setFrame(minFrame)
end

-- +-----------------+
-- |                 |
-- +--------+        |
-- |  HERE  |        |
-- +-----------------+
function hs.window.downLeft(win)
  local minFrame = hs.screen.minFrame(win:screen(), false)
  win:setFrame({
    x = minFrame.x,
    y = minFrame.y + minFrame.h/2,
    w = minFrame.w/2,
    h = minFrame.h/2
  })
end

-- +-----------------+
-- |                 |
-- |        +--------|
-- |        |  HERE  |
-- +-----------------+
function hs.window.downRight(win)
  local minFrame = hs.screen.minFrame(win:screen(), false)
  win:setFrame({
    x = minFrame.x + minFrame.w/2,
    y = minFrame.y + minFrame.h/2,
    w = minFrame.w/2,
    h = minFrame.h/2
  })
end

-- +-----------------+
-- |        |  HERE  |
-- |        +--------|
-- |                 |
-- +-----------------+
function hs.window.upRight(win)
  local minFrame = hs.screen.minFrame(win:screen(), false)
  win:setFrame({
    x = minFrame.x + minFrame.w/2,
    y = minFrame.y,
    w = minFrame.w/2,
    h = minFrame.h/2
  })
end

-- +------------------+
-- |                  |
-- |    +--------+    +--> minY
-- |    |  HERE  |    |
-- |    +--------+    |
-- |                  |
-- +------------------+
-- Where the window's size is equal to
-- the smaller available screen size
function hs.window.fullscreenCenter(win)
  local minFrame = hs.screen.minFrame(win:screen(), false)
  win:setFrame(minFrame)
end

-- +------------------+
-- |                  |
-- |  +------------+  +--> minY
-- |  |    HERE    |  |
-- |  +------------+  |
-- |                  |
-- +------------------+
function hs.window.fullscreenAlmostCenter(win)
  local offsetW = hs.screen.minX(win:screen()) - hs.screen.almostMinX(win:screen())
  win:setFrame({
    x = hs.screen.almostMinX(win:screen()),
    y = hs.screen.minY(win:screen()),
    w = hs.screen.minWidth(isFullscreen) + (2 * offsetW),
    h = hs.screen.minHeight(isFullscreen)
  })
end

-- It's like fullscreen but with minY and minHeight values
-- +------------------+
-- |                  |
-- +------------------+--> minY
-- |       HERE       |
-- +------------------+--> minHeight
-- |                  |
-- +------------------+
function hs.window.fullscreenWidth(win)
  local minFrame = hs.screen.minFrame(win:screen(), false)
  win:setFrame({
    x = win:screen():frame().x,
    y = minFrame.y,
    w = win:screen():frame().w,
    h = minFrame.h
  })
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

-- It's like fullscreen but with minX and minWidth values
-- +----+--------+----+
-- |    |        |    |
-- |    |        |    |
-- |    |  HERE  |    |
-- |    |        |    |
-- |    |        |    |
-- +----+--------+----+
--      |        |
--      |        +--> minWidth
--      +--> minX
function hs.window.fullscreenHeight(win)
  local minFrame = hs.screen.minFrame(win:screen(), false)
  win:setFrame({
    y = win:screen():frame().y,
    x = minFrame.x,
    h = win:screen():frame().h,
    w = minFrame.w
  })
end

-- +------------------+
-- |                  |
-- |    +--------+    +--> minY
-- |    |  HERE  |    |
-- |    +--------+    |
-- |                  |
-- +------------------+
function hs.window.center(win)
  local minFrame = hs.screen.minFrame(win:screen(), false)
  win:setFrame({
    x = win:screen():frame().w/2 - minFrame.w/3,
    y = win:screen():frame().h/2 - minFrame.h/3,
    w = minFrame.w/3*2,
    h = minFrame.h/3*2
  })
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

--   1/3
-- +-----+-----------+
-- |     |           |
-- |HERE |           |
-- |     |           |
-- +-----+-----------+
function hs.window.leftThird(win)
  -- local minFrame = hs.screen.minFrame(win:screen(), false)
  local screen = win:screen()
  local minFrame = screen:frame()
  minFrame.w = minFrame.w/3
  minFrame.h = minFrame.h
  win:setFrame(minFrame)
end

--         1/3
-- +-----+-----+-----+
-- |     |     |     |
-- |     |HERE |     |
-- |     |     |     |
-- +-----+-----+-----+
function hs.window.middleThird(win)
  -- local minFrame = hs.screen.minFrame(win:screen(), false)
  local screen = win:screen()
  local minFrame = screen:frame()
  win:setFrame({
    x = minFrame.x + minFrame.w/3,
    y = minFrame.y,
    w = minFrame.w/3,
    h = minFrame.h
  })
end

--               1/3
-- +-----------+-----+
-- |           |     |
-- |           | HERE|
-- |           |     |
-- +-----------+-----+
function hs.window.rightThird(win)
  -- local minFrame = hs.screen.minFrame(win:screen(), false)
  local screen = win:screen()
  local minFrame = screen:frame()
  win:setFrame({
    x = minFrame.x + minFrame.w/3 + minFrame.w/3,
    y = minFrame.y,
    w = minFrame.w/3,
    h = minFrame.h
  })
end

--      2/3
-- +-----------+-----+
-- |           |     |
-- |   HERE    |     |
-- |           |     |
-- +-----------+-----+
function hs.window.twoThirdsLeft(win)
  local screen = win:screen()
  local maxFrame = screen:frame()
  maxFrame.w = maxFrame.w/3*2
  maxFrame.h = maxFrame.h
  win:setFrame(maxFrame)
end

--            2/3
-- +-----+-----------+
-- |     |           |
-- |     |    HERE   |
-- |     |           |
-- +-----+-----------+
function hs.window.twoThirdsRight(win)
  local screen = win:screen()
  local maxFrame = screen:frame()
  win:setFrame({
    x = maxFrame.x + maxFrame.w/3,
    y = maxFrame.y,
    w = maxFrame.w/3*2,
    h = maxFrame.h
  })
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

--   1/4
-- +----+------------+
-- |    |            |
-- |HERE|            |
-- |    |            |
-- +----+------------+
function hs.window.leftQuarter(win)
  local minFrame = hs.screen.minFrame(win:screen(), false)
  minFrame.w = minFrame.w/4
  minFrame.h = minFrame.h
  win:setFrame(minFrame)
end

--               1/4
-- +------------+----+
-- |            |    |
-- |            |HERE|
-- |            |    |
-- +------------+----+
function hs.window.rightQuarter(win)
  local minFrame = hs.screen.minFrame(win:screen(), false)
  win:setFrame({
    x = minFrame.x + minFrame.w/4 + minFrame.w/4 + minFrame.w/4,
    y = minFrame.y,
    w = minFrame.w/4,
    h = minFrame.h
  })
end

--      3/4
-- +------------+----+
-- |            |    |
-- |    HERE    |    |
-- |            |    |
-- +------------+----+
function hs.window.threeQuartersLeft(win)
  local screen = win:screen()
  local maxFrame = screen:frame()
  maxFrame.w = maxFrame.w/4*3
  maxFrame.h = maxFrame.h
  win:setFrame(maxFrame)
end

--           3/4
-- +----+------------+
-- |    |            |
-- |    |   HERE     |
-- |    |            |
-- +----+------------+
function hs.window.threeQuartersRight(win)
  local screen = win:screen()
  local maxFrame = screen:frame()
  win:setFrame({
    x = maxFrame.x + maxFrame.w/4,
    y = maxFrame.y,
    w = maxFrame.w/4*3,
    h = maxFrame.h
  })
end

--           2/4
-- +---+---------+---+
-- |   |         |   |
-- |   |  HERE   |   |
-- |   |         |   |
-- +---+---------+---+
function hs.window.twoMiddleQuarters(win)
  local screen = win:screen()
  local maxFrame = screen:frame()
  win:setFrame({
    x = maxFrame.x + maxFrame.w/4,
    y = maxFrame.y,
    w = maxFrame.w/2,
    h = maxFrame.h
  })
end
-- }}}

--------------------------------------------------------------------------------
-- Window sizing {{{
--------------------------------------------------------------------------------

-- hs.hotkey.bind(super, "Left", function()
--   hs.window.focusedWindow():left()
-- end)
--
-- hs.hotkey.bind(super, "Right", function()
--   hs.window.focusedWindow():right()
-- end)
--
-- hs.hotkey.bind(super, "Up", function()
--   hs.window.focusedWindow():up()
-- end)
--
-- hs.hotkey.bind(super, "Down", function()
--   hs.window.focusedWindow():down()
-- end)
--
-- hs.hotkey.bind(super, "Return", function()
--   hs.window.focusedWindow():maximize()
-- end)
--
-- hs.hotkey.bind(super, "Z", function()
--   hs.window.focusedWindow():upLeft()
-- end)
--
-- hs.hotkey.bind(super, "U", function()
--   hs.window.focusedWindow():upRight()
-- end)
--
-- hs.hotkey.bind(super, "N", function()
--   hs.window.focusedWindow():downRight()
-- end)
--
-- hs.hotkey.bind(super, "B", function()
--   hs.window.focusedWindow():downLeft()
-- end)
--
-- hs.hotkey.bind(super, "H", function()
--   hs.window.focusedWindow():center()
-- end)
--
-- hs.hotkey.bind(super, "+", function()
--   hs.window.focusedWindow():leftThird() -- Super+1
-- end)
--
-- hs.hotkey.bind(super, "ě", function() -- Super+2
--   hs.window.focusedWindow():middleThird()
-- end)
--
-- hs.hotkey.bind(super, "š", function() -- Super+3
--   hs.window.focusedWindow():rightThird()
-- end)
--
-- hs.hotkey.bind(super, "č", function() -- Super+4
--   hs.window.focusedWindow():twoThirdsLeft()
-- end)
--
-- hs.hotkey.bind(super, "ř", function() -- Super+5
--   hs.window.focusedWindow():twoThirdsRight()
-- end)
--
-- hs.hotkey.bind(super, "ž", function() -- Super+6
--   hs.window.focusedWindow():leftQuarter()
-- end)
--
-- hs.hotkey.bind(super, "ý", function() -- Super+7
--   hs.window.focusedWindow():rightQuarter()
-- end)
--
-- hs.hotkey.bind(super, "á", function() -- Super+8
--   hs.window.focusedWindow():threeQuartersLeft()
-- end)
--
-- hs.hotkey.bind(super, "í", function() -- Super+9
--   hs.window.focusedWindow():threeQuartersRight()
-- end)

hs.hotkey.bind(super, "é", function() -- Super+0
  hs.window.focusedWindow():twoMiddleQuarters()
end)

hs.hotkey.bind(super, ",", function() -- Super+?
  local win = hs.window.focusedWindow()
  local frame = win:frame()
  local dimensions = "x=" .. frame.x .. ", y=" .. frame.y .. ", w=" .. frame.w .. ", h=" .. frame.h
  local appName = win:application():name()
  hs.notify.show("Window dimensions", appName, dimensions)
end)

hs.hotkey.bind(super, "C", function()
  hs.window.focusedWindow():fullscreenHeight()
end)
-- }}}

--------------------------------------------------------------------------------
-- Spoons (plug-ins) {{{
--------------------------------------------------------------------------------

spoon_list = {
  "FnMate",
  "MiroWindowsManager"
}

for _, v in pairs (spoon_list) do
  hs.loadSpoon(v)
end

hs.window.animationDuration = 0
spoon.MiroWindowsManager:bindHotkeys({
  up = {super, "up"},
  right = {super, "right"},
  down = {super, "down"},
  left = {super, "left"},
  fullscreen = {super, "return"}
})
-- }}}

--------------------------------------------------------------------------------
-- Spoons customization {{{
--------------------------------------------------------------------------------

-- HACK: Use 10px margin to match my yabai configuration
--       This makes MiroWindowsManager use the margin when resizing a window
--       to fullscreen but it breaks MiroWindowsManager's multi-step fullscreen
--       toggling (it compares current window size to the grid size but doesn't
--       take margin into consideration interally)
-- local gridMargin = 10
-- hs.grid.MARGINX = gridMargin
-- hs.grid.MARGINY = gridMargin

-- }}}

-- vim:foldmethod=marker:foldenable
