-- Inspired by http://pavelmakhov.com/awesome-wm-widgets/#tabLists

local awful     = require("awful")
local wibox     = require("wibox")
local gears     = require("gears")
local gfs       = require("gears.filesystem")
local beautiful = require("beautiful")

local themes_path  = gfs.get_themes_dir()
local theme        = dofile(themes_path.."default/theme.lua")
local lain         = require("lain")
local lain_icons   = require("lain.helpers").icons_dir .. "/layout/default/"

local menu_items = {
  { name = 'floating',              icon_name = theme.layout_floating,       url = awful.layout.suit.floating },
  { name = 'tile',                  icon_name = theme.layout_tile,           url = awful.layout.suit.tile },
  { name = 'tile left',             icon_name = theme.layout_tileleft,       url = awful.layout.suit.tile.left },
  { name = 'tile bottom',           icon_name = theme.layout_tilebottom,     url = awful.layout.suit.tile.bottom },
  { name = 'tile top',              icon_name = theme.layout_tiletop,        url = awful.layout.suit.tile.top },
  { name = 'fair',                  icon_name = theme.layout_fairv,          url = awful.layout.suit.fair },
  { name = 'fair horizontal',       icon_name = theme.layout_fairh,          url = awful.layout.suit.fair.horizontal },
  { name = 'spiral',                icon_name = theme.layout_spiral,         url = awful.layout.suit.spiral },
  { name = 'spiral dwindle',        icon_name = theme.layout_dwindle,        url = awful.layout.suit.spiral.dwindle },
  { name = 'max',                   icon_name = theme.layout_max,            url = awful.layout.suit.max },
  { name = 'max fullscreen',        icon_name = theme.layout_fullscreen,     url = awful.layout.suit.max.fullscreen },
  { name = 'magnifier',             icon_name = theme.layout_magnifier,      url = awful.layout.suit.magnifier },
  { name = 'corner nw',             icon_name = theme.layout_cornernw,       url = awful.layout.suit.corner.nw },
  { name = 'corner ne',             icon_name = theme.layout_cornerne,       url = awful.layout.suit.corner.ne },
  { name = 'corner sw',             icon_name = theme.layout_cornersw,       url = awful.layout.suit.corner.sw },
  { name = 'corner se',             icon_name = theme.layout_cornerse,       url = awful.layout.suit.corner.se },
  { name = 'cascade',               icon_name = lain_icons .. "cascadew.png",     url = lain.layout.cascade },
  { name = 'cascade tile',          icon_name = lain_icons .. "cascadetilew.png", url = lain.layout.cascade.tile },
  { name = 'centerwork',            icon_name = lain_icons .. "centerworkw.png",  url = lain.layout.centerwork },
  { name = 'centerwork horizontal', icon_name = lain_icons .. "centerworkhw.png", url = lain.layout.centerwork.horizontal },
  { name = 'termfair',              icon_name = lain_icons .. "termfairw.png",    url = lain.layout.termfair },
  { name = 'termfair center',       icon_name = lain_icons .. "centerfairw.png",  url = lain.layout.termfair.center },
}


local popup = awful.popup {
  ontop = true,
  visible = false,
  shape = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, 4)
  end,
  border_width = 1,
  border_color = beautiful.bg_focus,
  maximum_width = 400,
  offset = { y = 5 },
  widget = {}
}
local rows = { layout = wibox.layout.fixed.vertical }

for _, item in ipairs(menu_items) do

  local row = wibox.widget {
    {
      {
        {
          image = item.icon_name,
          forced_width = 16,
          forced_height = 16,
          widget = wibox.widget.imagebox
        },
        {
          text = item.name,
          widget = wibox.widget.textbox
        },
        spacing = 12,
        layout = wibox.layout.fixed.horizontal
      },
      margins = 8,
      widget = wibox.container.margin
    },
    bg = beautiful.bg_normal,
    widget = wibox.container.background
  }

  -- Change item background on mouse hover
  row:connect_signal("mouse::leave", function(c) c:set_bg(beautiful.bg_normal) end)
  row:connect_signal("mouse::enter", function(c) c:set_bg(beautiful.bg_focus) end)

  -- Change cursor on mouse hover
  local old_cursor, old_wibox
  row:connect_signal("mouse::enter", function()
    local wb = mouse.current_wibox
    old_cursor, old_wibox = wb.cursor, wb
    wb.cursor = "hand1"
  end)
  row:connect_signal("mouse::leave", function()
    if old_wibox then
      old_wibox.cursor = old_cursor
      old_wibox = nil
    end
  end)

  -- Mouse click handler
  row:buttons(
    awful.util.table.join(
    awful.button({}, 1, function()
      popup.visible = not popup.visible
      -- awful.spawn.with_shell('xdg-open ' .. item.url)
      awful.layout.set(item.url)
    end)
    )
  )

  -- Insert created row in the list of rows
  table.insert(rows, row)
end

-- Add rows to the popup
popup:setup(rows)

-- return bookmark_widget
return popup
