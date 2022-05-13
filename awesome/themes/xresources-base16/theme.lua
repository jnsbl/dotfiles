---------------------------------------------
-- Awesome theme which follows xrdb config --
--   by Yauhen Kirylau                     --
--   customized by jnsbl                   --
---------------------------------------------

local theme_assets = require("beautiful.theme_assets")
local xresources   = require("beautiful.xresources")
local dpi          = xresources.apply_dpi
local xrdb         = xresources.get_current_theme()
local gfs          = require("gears.filesystem")
local themes_path  = gfs.get_themes_dir()

-- inherit default theme
local theme = dofile(themes_path.."default/theme.lua")
-- load vector assets' generators for this theme

theme.font          = "sans 8"

theme.bg_normal     = xrdb.background
theme.bg_focus      = xrdb.color12
theme.bg_urgent     = xrdb.color9
theme.bg_minimize   = xrdb.color8
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = xrdb.foreground
theme.fg_focus      = theme.bg_normal
theme.fg_urgent     = theme.bg_normal
theme.fg_minimize   = theme.bg_normal

theme.useless_gap   = dpi(3)
theme.border_width  = dpi(2)
theme.border_normal = xrdb.color0
theme.border_focus  = theme.bg_focus
theme.border_marked = xrdb.color10

theme.color0        = xrdb.color0
theme.color1        = xrdb.color1
theme.color2        = xrdb.color2
theme.color3        = xrdb.color3
theme.color4        = xrdb.color4
theme.color5        = xrdb.color5
theme.color6        = xrdb.color6
theme.color7        = xrdb.color7
theme.color8        = xrdb.color8
theme.color9        = xrdb.color9
theme.color10       = xrdb.color10
theme.color11       = xrdb.color11
theme.color12       = xrdb.color12
theme.color13       = xrdb.color13
theme.color14       = xrdb.color14
theme.color15       = xrdb.color15
theme.color16       = xrdb.color16
theme.color17       = xrdb.color17
theme.color18       = xrdb.color18
theme.color19       = xrdb.color19
theme.color20       = xrdb.color20
theme.color21       = xrdb.color21

theme.base00        = xrdb.color0
theme.base01        = xrdb.color18
theme.base02        = xrdb.color19
theme.base03        = xrdb.color8
theme.base04        = xrdb.color20
theme.base05        = xrdb.color7
theme.base06        = xrdb.color21
theme.base07        = xrdb.color15
theme.base08        = xrdb.color1
theme.base09        = xrdb.color16
theme.base0A        = xrdb.color3
theme.base0B        = xrdb.color2
theme.base0C        = xrdb.color6
theme.base0D        = xrdb.color4
theme.base0E        = xrdb.color5
theme.base0F        = xrdb.color17

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- taglist_[bg|fg]_[focus|urgent|occupied|empty|volatile]
-- tasklist_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

theme.tasklist_fg_focus  = theme.color10
theme.tasklist_bg_focus  = theme.bg_normal
theme.tasklist_disable_icon  = true

theme.taglist_fg_focus   = theme.color11
theme.taglist_bg_focus   = theme.bg_normal
theme.taglist_fg_urgent  = theme.color1
theme.taglist_bg_urgent  = theme.bg_normal

theme.tooltip_fg = theme.fg_normal
theme.tooltip_bg = theme.bg_normal

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path.."default/submenu.png"
theme.menu_height = dpi(16)
theme.menu_width  = dpi(100)

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Recolor Layout icons:
theme = theme_assets.recolor_layout(theme, theme.fg_normal)

-- Recolor titlebar icons:
--
local function darker(color_value, darker_n)
    local result = "#"
    for s in color_value:gmatch("[a-fA-F0-9][a-fA-F0-9]") do
        local bg_numeric_value = tonumber("0x"..s) - darker_n
        if bg_numeric_value < 0 then bg_numeric_value = 0 end
        if bg_numeric_value > 255 then bg_numeric_value = 255 end
        result = result .. string.format("%2.2x", bg_numeric_value)
    end
    return result
end
theme = theme_assets.recolor_titlebar(
    theme, theme.fg_normal, "normal"
)
theme = theme_assets.recolor_titlebar(
    theme, darker(theme.fg_normal, -60), "normal", "hover"
)
theme = theme_assets.recolor_titlebar(
    theme, xrdb.color1, "normal", "press"
)
theme = theme_assets.recolor_titlebar(
    theme, theme.fg_focus, "focus"
)
theme = theme_assets.recolor_titlebar(
    theme, darker(theme.fg_focus, -60), "focus", "hover"
)
theme = theme_assets.recolor_titlebar(
    theme, xrdb.color1, "focus", "press"
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Generate taglist squares:
local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

-- Try to determine if we are running light or dark colorscheme:
local bg_numberic_value = 0;
for s in theme.bg_normal:gmatch("[a-fA-F0-9][a-fA-F0-9]") do
    bg_numberic_value = bg_numberic_value + tonumber("0x"..s);
end
local is_dark_bg = (bg_numberic_value < 383)

-- Generate wallpaper:
local wallpaper_bg = xrdb.color8
local wallpaper_fg = xrdb.color7
local wallpaper_alt_fg = xrdb.color12
if not is_dark_bg then
    wallpaper_bg, wallpaper_fg = wallpaper_fg, wallpaper_bg
end
theme.wallpaper = function(s)
    return theme_assets.wallpaper(wallpaper_bg, wallpaper_fg, wallpaper_alt_fg, s)
end

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
