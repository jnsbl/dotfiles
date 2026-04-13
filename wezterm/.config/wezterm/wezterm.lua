local wezterm = require("wezterm")
require("tabline")
require("smart-splits")

local config = wezterm.config_builder()

config.enable_wayland = false

-- font-family is set in ~/.config/fontconfig/fonts.conf
config.font_size = 13

config.color_scheme = "Tokyo Night"

config.window_padding = {
	left = "0.5cell",
	right = "0.5cell",
	top = "0.25cell",
	bottom = "0.25cell",
}

config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true

return config
