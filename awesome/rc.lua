-- vim:fileencoding=utf-8:foldmethod=marker
-- {{{ Imports
-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

local gears         = require("gears")
local awful         = require("awful")
                      require("awful.autofocus")
local wibox         = require("wibox")
local beautiful     = require("beautiful")
local dpi           = require("beautiful.xresources").apply_dpi
local naughty       = require("naughty")
local menubar       = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
                      require("awful.hotkeys_popup.keys")
local freedesktop   = require("freedesktop")
local lain          = require("lain")

local markup        = lain.util.markup

local battery_widget     = require("awesome-wm-widgets.batteryarc-widget.batteryarc")
local brightness_widget  = require("awesome-wm-widgets.brightness-widget.brightness")
local calendar_widget    = require("awesome-wm-widgets.calendar-widget.calendar")
local cpu_widget         = require("awesome-wm-widgets.cpu-widget.cpu-widget")
local logout_menu_widget = require("awesome-wm-widgets.logout-menu-widget.logout-menu")
local ram_widget         = require("awesome-wm-widgets.ram-widget.ram-widget")
local todo_widget        = require("awesome-wm-widgets.todo-widget.todo")
local volume_widget      = require('awesome-wm-widgets.volume-widget.volume')
local weather_widget     = require("awesome-wm-widgets.weather-widget.weather")

local layout_list_widget = require("layout-list")
local secrets            = require("secrets")
-- }}}

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
  naughty.notify({
    preset = naughty.config.presets.critical,
    title = "Oops, there were errors during startup!",
    text = awesome.startup_errors
  })
end

-- Handle runtime errors after startup
do
  local in_error = false
  awesome.connect_signal("debug::error", function (err)
    -- Make sure we don't go into an endless error loop
    if in_error then return end
    in_error = true

    naughty.notify({
      preset = naughty.config.presets.critical,
      title = "Oops, an error happened!",
      text = tostring(err)
    })
    in_error = false
  end)
end
-- }}}

-- {{{ Autostart windowless processes
-- This function will run once every time Awesome is started
local function run_once(cmd_arr)
    for _, cmd in ipairs(cmd_arr) do
        awful.spawn.with_shell(string.format("pgrep -u $USER -fx '%s' > /dev/null || (%s)", cmd, cmd))
    end
end

run_once({ -- comma-separated entries
  "nm-applet",
  "picom",
  -- "nitrogen --restore",
  -- string.format("%s/.fehbg &", os.getenv("HOME")),
  "greenclip daemon",
  "lxsession"
})
-- }}}

-- {{{ Variable definitions
local theme_dir = os.getenv("HOME") .. "/.config/awesome/themes/xresources-base16"
beautiful.init(theme_dir .. "/theme.lua")

-- Theme overrides
beautiful.font = "Terminus 9"
beautiful.useless_gap = 5
beautiful.notification_icon_size = 64
beautiful.notification_max_width = 300

beautiful.wallpaper     = theme_dir .. "/wall.jpg"

local terminal          = "alacritty"
local editor            = os.getenv("EDITOR") or "nvim"
local editor_cmd        = terminal .. " -e " .. editor
local browser           = "min"
local file_manager      = "pcmanfm"

local modkey            = "Mod4"
local altkey            = "Mod1"

local cycle_prev        = true  -- cycle with only the previously focused client or all https://github.com/lcpz/awesome-copycats/issues/274
local titlebars_enabled = false

local textclock_format  = "%H:%M:%S"
local weather_apikey    = secrets.OPEN_WEATHER_API_KEY

local wibar_opacity     = "aa" -- "00" fully transparent, "ff" fully opaque

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
  -- awful.layout.suit.floating,
  awful.layout.suit.tile,
  -- awful.layout.suit.tile.left,
  -- awful.layout.suit.tile.bottom,
  -- awful.layout.suit.tile.top,
  -- awful.layout.suit.fair,
  -- awful.layout.suit.fair.horizontal,
  -- awful.layout.suit.spiral,
  -- awful.layout.suit.spiral.dwindle,
  awful.layout.suit.max,
  -- awful.layout.suit.max.fullscreen,
  -- awful.layout.suit.magnifier,
  -- awful.layout.suit.corner.nw,
  -- awful.layout.suit.corner.ne,
  -- awful.layout.suit.corner.sw,
  -- awful.layout.suit.corner.se,
  -- lain.layout.cascade,
  -- lain.layout.cascade.tile,
  -- lain.layout.centerwork,
  -- lain.layout.centerwork.horizontal,
  -- lain.layout.termfair,
  -- lain.layout.termfair.center
}
lain.layout.termfair.nmaster           = 3
lain.layout.termfair.ncol              = 1
lain.layout.termfair.center.nmaster    = 3
lain.layout.termfair.center.ncol       = 1
lain.layout.cascade.tile.offset_x      = 2
lain.layout.cascade.tile.offset_y      = 32
lain.layout.cascade.tile.extra_padding = 5
lain.layout.cascade.tile.nmaster       = 5
lain.layout.cascade.tile.ncol          = 2

-- awful.util.tagnames = { "1", "2", "3", "4", "5" }
awful.util.tagnames = { "web", "code", "chat", "music", "other" }

awful.util.terminal = terminal

naughty.config.defaults.screen = 1 -- primary screen only; set to awful.screen.focused if you want notifications to display on the active screen
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
local myawesomemenu = {
  { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
  { "manual", terminal .. " -e man awesome" },
  { "edit config", editor_cmd .. " " .. awesome.conffile },
  { "restart", awesome.restart },
  { "quit", function() awesome.quit() end },
}

local mymainmenu = freedesktop.menu.build {
  before = {
    { "Awesome", myawesomemenu, beautiful.awesome_icon },
  },
  after = {
    { "Open terminal", terminal },
  }
}
awful.util.mymainmenu = mymainmenu

local mylauncher = awful.widget.launcher({
  image = beautiful.awesome_icon,
  menu = mymainmenu
})
-- }}}

-- {{{ Wibar
-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
  awful.button({ }, 1, function(t) t:view_only() end),
  awful.button({ modkey }, 1, function(t)
    if client.focus then client.focus:move_to_tag(t) end
  end),
  awful.button({ }, 3, awful.tag.viewtoggle),
  awful.button({ modkey }, 3, function(t)
    if client.focus then client.focus:toggle_tag(t) end
  end),
  awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
  awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local tasklist_buttons = gears.table.join(
  awful.button({ }, 1, function(c)
    if c == client.focus then
      c.minimized = true
    else
      c:emit_signal("request::activate", "tasklist", {raise = true})
    end
  end),
  awful.button({ }, 3, function() awful.menu.client_list({ theme = { width = 250 } }) end),
  awful.button({ }, 4, function() awful.client.focus.byidx(1) end),
  awful.button({ }, 5, function() awful.client.focus.byidx(-1) end)
)

-- Create a textclock widget
local mytextclock = wibox.widget.textclock(textclock_format, 1)
mytextclock.font = beautiful.font
beautiful.cal = calendar_widget {
  placement = 'top_right',
  theme     = 'nord'
  }
mytextclock:connect_signal("button::press",
  function(_, _, _, button)
    if button == 1 then beautiful.cal.toggle() end
  end
)

-- Keyboard map indicator and switcher

local mykeyboardlayout = awful.widget.keyboardlayout()

local separator = wibox.widget.textbox(markup(beautiful.color8, " "))

local function set_wallpaper(s)
  if beautiful.wallpaper then
    local wallpaper = beautiful.wallpaper
    -- If wallpaper is a function, call it with the screen
    if type(wallpaper) == "function" then
      wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, false)
  end
end

awful.screen.connect_for_each_screen(function(s)
  if s.index == 1 then
    screen.primary = s
  end

  -- Wallpaper
  set_wallpaper(s)

  -- Each screen has its own tag table.
  awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])

  -- Create a promptbox for each screen
  s.mypromptbox = awful.widget.prompt()

  -- Create an imagebox widget which will contain an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.mylayoutbox = awful.widget.layoutbox(s)
  s.mylayoutbox:buttons(gears.table.join(
    awful.button({ }, 1, function () awful.layout.inc( 1) end),
    awful.button({ }, 3, function () awful.layout.inc(-1) end),
    awful.button({ }, 4, function () awful.layout.inc( 1) end),
    awful.button({ }, 5, function () awful.layout.inc(-1) end),
    awful.button({ }, 2, function ()
      if layout_list_widget.visible then
        layout_list_widget.visible = not layout_list_widget.visible
      else
        layout_list_widget:move_next_to(mouse.current_widget_geometry)
      end
    end)
  ))
  -- Create a taglist widget
  s.mytaglist = awful.widget.taglist {
    screen  = s,
    filter  = awful.widget.taglist.filter.all,
    buttons = taglist_buttons,
    style   = {
      bg_focus = beautiful.bg_normal .. "00"
    }
  }

  -- Create a tasklist widget
  s.mytasklist = awful.widget.tasklist {
    screen  = s,
    filter  = awful.widget.tasklist.filter.currenttags,
    buttons = tasklist_buttons
  }

  -- Create the wibar
  s.mywibox = awful.wibar({ position = "top", screen = s, bg = beautiful.bg_normal .. wibar_opacity })

  s.systray = wibox.widget.systray()
  s.systray.visible = false -- hide it by default, it can be shown by a key binding

  -- Add widgets to the wibox
  s.mywibox:setup {
    layout = wibox.layout.align.horizontal,
    { -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      -- mylauncher,
      s.mylayoutbox,
      separator,
      s.mytaglist,
      s.mypromptbox,
    },
    { -- Middle widget
      layout = wibox.layout.fixed.horizontal,
      separator
    },
    -- s.mytasklist, -- Middle widget
    { -- Right widgets
      layout = wibox.layout.fixed.horizontal,
      s.systray,
      -- separator,
      battery_widget({
        show_current_level = true,
        arc_thickness = 1,
      }),
      -- separator,
      ram_widget(),
      cpu_widget(),
      -- separator,
      brightness_widget({
        type = 'icon_and_text',
        program = 'brightnessctl',
        step = 3,
        percentage = true,
      }),
      separator,
      volume_widget(),
      -- separator,
      -- todo_widget(),
      weather_widget({
        api_key = weather_apikey,
        coordinates = {50.088, 14.4208},
        show_hourly_forecast = true,
        show_daily_forecast = true,
      }),
      -- separator,
      mykeyboardlayout,
      -- separator,
      mytextclock,
      separator,
      -- s.mylayoutbox,
      logout_menu_widget({
        onlock = function() awful.spawn.with_shell('betterlockscreen -l dim') end
      }),
    },
  }
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 3, function () awful.util.mymainmenu:toggle() end)
))
-- }}}

-- {{{ Scratchpad
-- https://github.com/sansone931/dotfiles/blob/master/.config/awesome/quake.lua
local quake = lain.util.quake({
  app = terminal,
  argname = "--title %s",
  extra = "--class QuakeDD",
  border = dpi(1),
  height = dpi(675),
  width = dpi(1200),
  vert = "center",
  horiz = "center",
  followtag = false,
  overlap = true,
  screen = screen.primary,
})
-- }}}

-- {{{ Key bindings
local globalkeys = gears.table.join(
  awful.key({ modkey,           }, "s",
      hotkeys_popup.show_help,
      {description="show help", group="awesome"}),
  -- awful.key({ modkey, "Shift"   }, "c",
  --     function () mymainmenu:show() end,
  --     {description = "show main menu", group = "awesome"}),
  awful.key({ modkey, "Shift"   }, "n",
      function ()
        if not naughty.is_suspended() then
          naughty.notify({ title = "Naughty", text = "Disabling notifications" })
        end
        naughty.toggle()
        if not naughty.is_suspended() then
          naughty.notify({ title = "Naughty", text = "Notifications enabled" })
        end
      end,
      {description = "toggle notifications", group = "awesome"}),
  awful.key({ modkey, "Shift"   }, "s",
      function () awful.screen.focused().systray.visible = not awful.screen.focused().systray.visible end,
      {description = "toggle systray visibility", group = "awesome"}),

  awful.key({ modkey,           }, "Left",
      awful.tag.viewprev,
      {description = "view previous", group = "tag"}),
  awful.key({ modkey,           }, "Right",
      awful.tag.viewnext,
      {description = "view next", group = "tag"}),
  awful.key({ modkey,           }, "Escape",
      awful.tag.history.restore,
      {description = "go back", group = "tag"}),

  awful.key({ modkey,           }, "Down",
      function () awful.screen.focus_relative( 1) end,
      {description = "focus the next screen", group = "screen"}),
  awful.key({ modkey,           }, "Up",
      function () awful.screen.focus_relative(-1) end,
      {description = "focus the previous screen", group = "screen"}),
  awful.key({ modkey, "Control" }, "j",
      function () awful.screen.focus_relative( 1) end,
      {description = "focus the next screen", group = "screen"}),
  awful.key({ modkey, "Control" }, "k",
      function () awful.screen.focus_relative(-1) end,
      {description = "focus the previous screen", group = "screen"}),

  -- Default client focus
  awful.key({ altkey,           }, "j",
      function () awful.client.focus.byidx( 1) end,
      {description = "focus next by index", group = "client"}
  ),
  awful.key({ altkey,           }, "k",
      function () awful.client.focus.byidx(-1) end,
      {description = "focus previous by index", group = "client"}
  ),

  -- By-direction client focus
  awful.key({ modkey }, "j",
      function()
          awful.client.focus.global_bydirection("down")
          if client.focus then client.focus:raise() end
      end,
      {description = "focus down", group = "client"}),
  awful.key({ modkey }, "k",
      function()
          awful.client.focus.global_bydirection("up")
          if client.focus then client.focus:raise() end
      end,
      {description = "focus up", group = "client"}),
  awful.key({ modkey }, "h",
      function()
          awful.client.focus.global_bydirection("left")
          if client.focus then client.focus:raise() end
      end,
      {description = "focus left", group = "client"}),
  awful.key({ modkey }, "l",
      function()
          awful.client.focus.global_bydirection("right")
          if client.focus then client.focus:raise() end
      end,
      {description = "focus right", group = "client"}),

  -- Layout manipulation
  awful.key({ modkey, "Shift"   }, "j",
      function () awful.client.swap.byidx(  1)    end,
      {description = "swap with next client by index", group = "client"}),
  awful.key({ modkey, "Shift"   }, "k",
      function () awful.client.swap.byidx( -1)    end,
      {description = "swap with previous client by index", group = "client"}),
  awful.key({ modkey,           }, "u",
      awful.client.urgent.jumpto,
      {description = "jump to urgent client", group = "client"}),
  -- awful.key({ modkey,           }, "Tab",
  --     function ()
  --       awful.client.focus.history.previous()
  --       if client.focus then client.focus:raise() end
  --     end,
  --     {description = "go back", group = "client"}),
  awful.key({ modkey,           }, "Tab",
      function ()
          if cycle_prev then
              awful.client.focus.history.previous()
          else
              awful.client.focus.byidx(-1)
          end
          if client.focus then client.focus:raise() end
      end,
      {description = "cycle with previous/go back", group = "client"}),

  -- Show/hide wibox
  awful.key({ modkey }, "b",
      function ()
        for s in screen do
          s.mywibox.visible = not s.mywibox.visible
          if s.mybottomwibox then
              s.mybottomwibox.visible = not s.mybottomwibox.visible
          end
        end
      end,
      {description = "toggle wibox", group = "awesome"}),

  -- Standard programs
  awful.key({ modkey,           }, "Return",
      function () awful.spawn(terminal) end,
      {description = "open a terminal", group = "launcher"}),
  awful.key({ modkey, "Shift"   }, "Return",
      function () awful.spawn(browser) end,
      {description = "open a browser", group = "launcher"}),
  awful.key({ modkey, "Control"   }, "Return",
      function () awful.spawn(file_manager) end,
      {description = "open a file manager", group = "launcher"}),
  awful.key({ modkey,             }, "F2",
      function () awful.spawn("nvim-qt") end,
      {description = "open a file manager", group = "launcher"}),
  awful.key({ modkey, "Shift" }, "r",
      awesome.restart,
      {description = "reload awesome", group = "awesome"}),
  awful.key({ modkey, "Shift"   }, "q",
      awesome.quit,
      {description = "quit awesome", group = "awesome"}),
  awful.key({ modkey, altkey    }, "l",
      function () os.execute("betterlockscreen --lock dim") end,
      {description = "lock screen", group = "awesome"}),
  awful.key({ modkey,           }, "y",
      function () quake:toggle() end,
      {description = "toggle scratchpad terminal", group = "launcher"}),

  awful.key({ modkey, "Shift"   }, "l",
      function () awful.tag.incmwfact( 0.05) end,
      {description = "increase master width factor", group = "layout"}),
  awful.key({ modkey, "Shift"   }, "h",
      function () awful.tag.incmwfact(-0.05) end,
      {description = "decrease master width factor", group = "layout"}),
  awful.key({ modkey, "Shift", "Control" }, "h",
      function () awful.tag.incnmaster( 1, nil, true) end,
      {description = "increase the number of master clients", group = "layout"}),
  awful.key({ modkey, "Shift", "Control" }, "l",
      function () awful.tag.incnmaster(-1, nil, true) end,
      {description = "decrease the number of master clients", group = "layout"}),
  awful.key({ modkey, "Control" }, "h",
      function () awful.tag.incncol( 1, nil, true) end,
      {description = "increase the number of columns", group = "layout"}),
  awful.key({ modkey, "Control" }, "l",
      function () awful.tag.incncol(-1, nil, true) end,
      {description = "decrease the number of columns", group = "layout"}),
  awful.key({ altkey,           }, "space",
      function () awful.layout.inc( 1) end,
      {description = "select next", group = "layout"}),
  awful.key({ altkey, "Shift"   }, "space",
      function () awful.layout.inc(-1) end,
      {description = "select previous", group = "layout"}),

  awful.key({ modkey, "Control" }, "n",
      function ()
        local c = awful.client.restore()
        -- Focus restored client
        if c then
          c:emit_signal("request::activate", "key.unminimize", {raise = true})
        end
      end,
      {description = "restore minimized", group = "client"}),

  -- Prompt
  awful.key({ modkey },            "r",
      function () awful.screen.focused().mypromptbox:run() end,
      {description = "run prompt", group = "launcher"}),
  awful.key({ modkey }, "space",
      function ()
        -- os.execute(string.format("rofi -show %s -theme %s", 'run', 'dmenu'))
        os.execute(string.format("rofi -modi %s -show %s", 'drun', 'drun'))
      end,
      {description = "show rofi", group = "launcher"}),

  -- Menubar
  awful.key({ modkey }, "p",
      function() menubar.show() end,
      {description = "show the menubar", group = "launcher"}),

  -- Take a screenshot
  awful.key({ altkey }, "Print",
      function()
        local fpath = string.format("%s/Pictures/Screenshots", os.getenv("HOME"))
        local fname = string.format("Screenshot_%s.png", os.date("%Y%m%d_%H%M%S"))
        local cmd   = string.format("shotgun %s/%s", fpath, fname)
        awful.util.spawn(cmd)
      end,
      {description = "take a quick screenshot", group = "hotkeys"}),

  -- Clipboard
  awful.key({ modkey }, "v",
      function ()
        os.execute(string.format("rofi -modi '%s' -show clipboard -run-command '{cmd}'", 'clipboard:greenclip print'))
      end,
      {description = "show clipboard history", group = "hotkeys"}),

  -- Widgets popups
  awful.key({ altkey, "Control" }, "space",
      function () if beautiful.cal then beautiful.cal.toggle() end end,
      {description = "show calendar", group = "widgets"}),

  -- Screen brightness
  -- awful.key({ }, "XF86MonBrightnessUp",
  --     function () os.execute("brightnessctl --device=intel_backlight set +3%") end,
  --     {description = "increase brightness +3%", group = "hotkeys"}),
  -- awful.key({ }, "XF86MonBrightnessDown",
  --     function () os.execute("brightnessctl --device=intel_backlight set 3%-") end,
  --     {description = "decrease brightness -3%", group = "hotkeys"}),
  awful.key({ }, "XF86MonBrightnessUp",
      function () brightness_widget:inc() end,
      {description = "increase brightness", group = "hotkeys"}),
  awful.key({ }, "XF86MonBrightnessDown",
      function () brightness_widget:dec() end,
      {description = "decrease brightness", group = "hotkeys"}),

  -- ALSA volume control
  awful.key({ }, "XF86AudioRaiseVolume",
      function () volume_widget:inc(5) end,
      {description = "volume up", group = "hotkeys"}),
  awful.key({ }, "XF86AudioLowerVolume",
      function () volume_widget:dec(5) end,
      {description = "volume down", group = "hotkeys"}),
  awful.key({ }, "XF86AudioMute",
      function () volume_widget:toggle() end,
      {description = "toggle mute", group = "hotkeys"}),
  awful.key({ }, "XF86AudioPlay",
      function () os.execute("playerctl play-pause") end,
      {description = "play/pause audio", group = "hotkeys"}),
  awful.key({ }, "XF86AudioStop",
      function () os.execute("playerctl stop") end,
      {description = "stop audio", group = "hotkeys"}),
  awful.key({ }, "XF86AudioPrev",
      function () os.execute("playerctl previous") end,
      {description = "play previous audio", group = "hotkeys"}),
  awful.key({ }, "XF86AudioNext",
      function () os.execute("playerctl next") end,
      {description = "play next audio", group = "hotkeys"}),

  -- Destroy all notifications
  awful.key({ "Control", "Shift" }, "space",
      function() naughty.destroy_all_notifications() end,
      {description = "destroy all notifications", group = "hotkeys"})
)

local clientkeys = gears.table.join(
  awful.key({ modkey,           }, "f",
      function (c)
        c.fullscreen = not c.fullscreen
        c:raise()
      end,
      {description = "toggle fullscreen", group = "client"}),
  awful.key({ modkey,           }, "w",
      function (c) c:kill() end,
      {description = "close", group = "client"}),
  awful.key({ modkey, "Control" }, "space",
      awful.client.floating.toggle,
      {description = "toggle floating", group = "client"}),
  awful.key({ modkey, "Control" }, "Return",
      function (c) c:swap(awful.client.getmaster()) end,
      {description = "move to master", group = "client"}),
  awful.key({ modkey,           }, "o",
      function (c) c:move_to_screen() end,
      {description = "move to screen", group = "client"}),
  awful.key({ modkey,           }, "t",
      function (c) c.ontop = not c.ontop end,
      {description = "toggle keep on top", group = "client"}),
  awful.key({ modkey,           }, "n",
      function (c) c.minimized = true end,
      {description = "minimize", group = "client"}),
  awful.key({ modkey,           }, "m",
      function (c)
        c.maximized = not c.maximized
        c:raise()
      end,
      {description = "(un)maximize", group = "client"}),
  awful.key({ modkey, "Control" }, "m",
      function (c)
        c.maximized_vertical = not c.maximized_vertical
        c:raise()
      end,
      {description = "(un)maximize vertically", group = "client"}),
  awful.key({ modkey, "Shift"   }, "m",
      function (c)
        c.maximized_horizontal = not c.maximized_horizontal
        c:raise()
      end,
      {description = "(un)maximize horizontally", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
  globalkeys = gears.table.join(globalkeys,
    -- View tag only.
    awful.key({ modkey }, "#" .. i + 9,
        function ()
          local screen = awful.screen.focused()
          local tag = screen.tags[i]
          if tag then
             tag:view_only()
          end
        end,
        {description = "view tag #"..i, group = "tag"}),
    -- Toggle tag display.
    awful.key({ modkey, "Control" }, "#" .. i + 9,
        function ()
          local screen = awful.screen.focused()
          local tag = screen.tags[i]
          if tag then
             awful.tag.viewtoggle(tag)
          end
        end,
        {description = "toggle tag #" .. i, group = "tag"}),
    -- Move client to tag.
    awful.key({ modkey, "Shift" }, "#" .. i + 9,
        function ()
          if client.focus then
              local tag = client.focus.screen.tags[i]
              if tag then
                  client.focus:move_to_tag(tag)
              end
         end
        end,
        {description = "move focused client to tag #"..i, group = "tag"}),
    -- Toggle tag on focused client.
    awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
        function ()
          if client.focus then
              local tag = client.focus.screen.tags[i]
              if tag then
                  client.focus:toggle_tag(tag)
              end
          end
        end,
        {description = "toggle focused client on tag #" .. i, group = "tag"})
  )
end

local clientbuttons = gears.table.join(
  awful.button({ }, 1, function (c)
    c:emit_signal("request::activate", "mouse_click", {raise = true})
  end),
  awful.button({ modkey }, 1, function (c)
    c:emit_signal("request::activate", "mouse_click", {raise = true})
    awful.mouse.client.move(c)
  end),
  awful.button({ modkey }, 3, function (c)
    c:emit_signal("request::activate", "mouse_click", {raise = true})
    awful.mouse.client.resize(c)
  end)
)

root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
  -- All clients will match this rule.
  { rule = { },
    properties = {
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      callback = awful.client.setslave,
      focus = awful.client.focus.filter,
      raise = true,
      keys = clientkeys,
      buttons = clientbuttons,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap+awful.placement.no_offscreen
   }
  },

  -- Floating clients.
  { rule_any = {
      instance = {
        "DTA",  -- Firefox addon DownThemAll.
        "copyq",  -- Includes session name in class.
        "pinentry",
      },
      class = {
        "Arandr",
        "Blueman-manager",
        "Gpick",
        "Kruler",
        "MessageWin",  -- kalarm.
        "Sxiv",
        "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
        "Wpa_gui",
        "veromix",
        "xtightvncviewer"},

      -- Note that the name property shown in xprop might be set slightly after creation of the client
      -- and the name shown there might not match defined rules here.
      name = {
        "Event Tester",  -- xev.
      },
      role = {
        "AlarmWindow",  -- Thunderbird's calendar.
        "ConfigManager",  -- Thunderbird's about:config.
        "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
      }
    }, properties = { floating = true }},

  -- Add titlebars to normal clients and dialogs
  { rule_any = {type = { "normal", "dialog" }
    }, properties = { titlebars_enabled = true }
  },

  -- Custom rules for apps
  { rule = { class = "Brave" },
    properties = { tag = "1" } },
  { rule = { class = "Firefox" },
    properties = { tag = "1" } },
  { rule = { class = "nvim-qt" },
    properties = { tag = "2" } },
  { rule = { class = "VSCodium" },
    properties = { tag = "2" } },
  { rule = { class = "Skype" },
    properties = { tag = "3" } },
  { rule = { class = "Thunderbird" },
    properties = { tag = "3" } },
  { rule = { class = "Mailspring" },
    properties = { tag = "3" } },
  { rule = { class = "Spotify" },
    properties = { tag = "4" } },
  { rule = { class = "LibreOffice" },
    properties = { tag = "5" } },
  { rule = { class = "Obsidian" },
    properties = { tag = "5" } },
}
-- }}}

-- {{{ Signals
-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)
-- Re-set wallpaper when the list of available screens changes
screen.connect_signal("list", set_wallpaper)

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
  -- Set the windows at the slave,
  -- i.e. put it at the end of others instead of setting it master.
  -- if not awesome.startup then awful.client.setslave(c) end

  if awesome.startup
    and not c.size_hints.user_position
    and not c.size_hints.program_position then
      -- Prevent clients from being unreachable after screen count changes.
      awful.placement.no_offscreen(c)
  end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
  if not titlebars_enabled then return end
  -- buttons for the titlebar
  local buttons = gears.table.join(
    awful.button({ }, 1, function()
        c:emit_signal("request::activate", "titlebar", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ }, 3, function()
        c:emit_signal("request::activate", "titlebar", {raise = true})
        awful.mouse.client.resize(c)
    end)
  )

  awful.titlebar(c) : setup {
    { -- Left
        awful.titlebar.widget.iconwidget(c),
        buttons = buttons,
        layout  = wibox.layout.fixed.horizontal
    },
    { -- Middle
        { -- Title
            align  = "center",
            widget = awful.titlebar.widget.titlewidget(c)
        },
        buttons = buttons,
        layout  = wibox.layout.flex.horizontal
    },
    { -- Right
        awful.titlebar.widget.floatingbutton (c),
        awful.titlebar.widget.maximizedbutton(c),
        awful.titlebar.widget.stickybutton   (c),
        awful.titlebar.widget.ontopbutton    (c),
        awful.titlebar.widget.closebutton    (c),
        layout = wibox.layout.fixed.horizontal()
    },
    layout = wibox.layout.align.horizontal
  }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
  c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

-- {{{ Timers
-- Run garbage collector regularly to prevent memory leaks
-- https://wiki.archlinux.org/title/Awesome
gears.timer {
  timeout = 30,
  autostart = true,
  callback = function() collectgarbage() end
}
-- }}}
