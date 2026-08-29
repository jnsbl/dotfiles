-- Personal window-management keymap (vim-style movement) plus a few binds
-- adopted from the Omarchy 4.0.0 default tiling.lua. Loaded after the verbatim
-- Omarchy modules, so keys they claim are unbound first.

hl.unbind("SUPER + K")      -- was: Keybindings menu (moved to SUPER + F1)
hl.unbind("SUPER + ESCAPE") -- was: System menu (still on SUPER + Q)

-- Move focus.
o.bind("SUPER + H", "Move focus left", hl.dsp.focus({ direction = "l" }))
o.bind("SUPER + J", "Move focus down", hl.dsp.focus({ direction = "d" }))
o.bind("SUPER + K", "Move focus up", hl.dsp.focus({ direction = "u" }))
o.bind("SUPER + L", "Move focus right", hl.dsp.focus({ direction = "r" }))

-- Swap windows.
o.bind("SUPER + SHIFT + H", "Swap window to the left", hl.dsp.window.swap({ direction = "l" }))
o.bind("SUPER + SHIFT + J", "Swap window down", hl.dsp.window.swap({ direction = "d" }))
o.bind("SUPER + SHIFT + K", "Swap window up", hl.dsp.window.swap({ direction = "u" }))
o.bind("SUPER + SHIFT + L", "Swap window to the right", hl.dsp.window.swap({ direction = "r" }))

-- Workspace navigation.
o.bind("SUPER + ESCAPE", "Switch to previous workspace", hl.dsp.focus({ workspace = "previous_per_monitor" }))
o.bind("SUPER + TAB", "Next workspace", hl.dsp.focus({ workspace = "r+1" }))
o.bind("SUPER + SHIFT + TAB", "Previous workspace", hl.dsp.focus({ workspace = "r-1" }))
o.bind("SUPER + left", "Switch to previous workspace", hl.dsp.focus({ workspace = "-1" }))
o.bind("SUPER + right", "Switch to next workspace", hl.dsp.focus({ workspace = "+1" }))
o.bind("SUPER + SHIFT + left", "Move window to previous workspace", hl.dsp.window.move({ workspace = "-1" }))
o.bind("SUPER + SHIFT + right", "Move window to next workspace", hl.dsp.window.move({ workspace = "+1" }))

-- Force-switch to a workspace on the current monitor. Unbind Omarchy's
-- SUPER+CTRL+1..9 bar-panel binds (code:10..18) first.
for ws = 1, 10 do
  local key = "SUPER + CTRL + code:" .. tostring(ws + 9)
  if ws <= 9 then
    hl.unbind(key)
  end
  o.bind(key, "Force switch to workspace " .. ws, hl.dsp.focus({ workspace = ws, on_current_monitor = true }))
end

-- Layout.
o.bind("SUPER + ALT + F", "Toggle floating window", hl.dsp.window.float({ action = "toggle" }))
o.bind("SUPER + ALT + J", "Toggle split", hl.dsp.layout("togglesplit"))
o.bind("SUPER + ALT + P", "Pseudo window", hl.dsp.window.pseudo())
o.bind("SUPER + ALT + L", "Toggle workspace layout", "omarchy-hyprland-workspace-layout-toggle")
o.bind("SUPER + M", "Maximize window", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
o.bind("SUPER + CTRL + M", "Maximize column (scrolling layout)", hl.dsp.layout("togglefit"))

-- Pyprland scratchpads (pypr is started from hypr/autostart.lua).
o.bind("SUPER + Y", "Scratchpad terminal (pypr)", "pypr toggle term")
o.bind("SUPER + CTRL + F", "Scratchpad files (pypr)", "pypr toggle files")
o.bind("SUPER + CTRL + Y", "Attach window to scratchpad (pypr)", "pypr attach")

-- Adopted from the Omarchy 4.0.0 default tiling.lua (re-diff on upgrade).
-- Window transparency / gaps / square-aspect toggles are already provided by
-- the verbatim bindings/utilities.lua (SUPER+BACKSPACE family).
o.bind("SUPER + W", "Close window", hl.dsp.window.close())

o.bind("SUPER + Home", "Restore window width", "omarchy-hyprland-window-width restore")
o.bind("SUPER + ALT + Home", "Save window width", "omarchy-hyprland-window-width save")

o.bind("SUPER + G", "Toggle window grouping", hl.dsp.group.toggle())
o.bind("SUPER + ALT + G", "Move active window out of group", hl.dsp.window.move({ out_of_group = true }))

o.bind("CTRL + ALT + TAB", "Focus on next monitor", hl.dsp.focus({ monitor = "+1" }))
o.bind("CTRL + ALT + SHIFT + TAB", "Focus on previous monitor", hl.dsp.focus({ monitor = "-1" }))

o.bind("SUPER + SLASH", "Monitor scaling up", "omarchy-hyprland-monitor-scaling up")
o.bind("SUPER + ALT + SLASH", "Monitor scaling down", "omarchy-hyprland-monitor-scaling down")

o.bind("SUPER + code:20", "Expand window left", hl.dsp.window.resize({ x = -100, y = 0, relative = true }))
o.bind("SUPER + code:21", "Shrink window left", hl.dsp.window.resize({ x = 100, y = 0, relative = true }))
o.bind("SUPER + SHIFT + code:20", "Shrink window up", hl.dsp.window.resize({ x = 0, y = -100, relative = true }))
o.bind("SUPER + SHIFT + code:21", "Expand window down", hl.dsp.window.resize({ x = 0, y = 100, relative = true }))
o.bind("SUPER + ALT + code:20", "Expand window left a little", hl.dsp.window.resize({ x = -25, y = 0, relative = true }))
o.bind("SUPER + ALT + code:21", "Shrink window left a little", hl.dsp.window.resize({ x = 25, y = 0, relative = true }))
o.bind("SUPER + SHIFT + ALT + code:20", "Shrink window up a little", hl.dsp.window.resize({ x = 0, y = -25, relative = true }))
o.bind("SUPER + SHIFT + ALT + code:21", "Expand window down a little", hl.dsp.window.resize({ x = 0, y = 25, relative = true }))
o.bind("SUPER + CTRL + code:20", "Expand window left a lot", hl.dsp.window.resize({ x = -300, y = 0, relative = true }))
o.bind("SUPER + CTRL + code:21", "Shrink window left a lot", hl.dsp.window.resize({ x = 300, y = 0, relative = true }))
o.bind("SUPER + CTRL + SHIFT + code:20", "Shrink window up a lot", hl.dsp.window.resize({ x = 0, y = -300, relative = true }))
o.bind("SUPER + CTRL + SHIFT + code:21", "Expand window down a lot", hl.dsp.window.resize({ x = 0, y = 300, relative = true }))
