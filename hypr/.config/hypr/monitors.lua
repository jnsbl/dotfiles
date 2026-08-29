-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
-- List current monitors and supported resolutions with: hyprctl monitors all

local omarchy_gdk_scale = 1
local omarchy_monitor_scale = 1.6

local laptop_display = "eDP-2"
local hdmi_monitor = "HDMI-A-1"

hl.env("GDK_SCALE", tostring(omarchy_gdk_scale))
-- hl.monitor({ output = "", mode = "preferred", position = "auto", scale = omarchy_monitor_scale })

-- Configure a specific monitor.
hl.monitor({ output = laptop_display, mode = "2880x1800@60", position = "0x0", scale = 1.6 })
hl.monitor({ output = hdmi_monitor, mode = "1920x1080@60", position = "auto-up", scale = "auto" })
-- hl.monitor({ output = hdmi_monitor, mode = "1920x1080@60", position = "auto-right", scale = "auto" })
-- hl.monitor({ output = hdmi_monitor, mode = "1920x1080@60", position = "auto-up", scale = "auto", mirror = laptop_display })

-- Portrait/rotated secondary monitor (transform: 1 = 90°, 3 = 270°).
-- hl.monitor({ output = "DP-2", mode = "preferred", position = "auto", scale = 1, transform = 1 })
