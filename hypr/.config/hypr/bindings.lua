-- Omarchy default bindings are disabled (omarchy_default_bindings = false in
-- hyprland.lua). This file owns the entire keymap by loading the modules under
-- hypr/bindings/.
--
-- Load order matters: the verbatim Omarchy copies load first, then the personal
-- modules, so the personal modules can hl.unbind() a key before rebinding it.
--
-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- More-or-less verbatim copies of Omarchy 4.0.0 defaults (re-diff on upgrade).
require("hypr.bindings.media")
require("hypr.bindings.clipboard")
require("hypr.bindings.utilities")

-- Personal overrides and additions.
require("hypr.bindings.tiling")
require("hypr.bindings.applications")
require("hypr.bindings.capture")
