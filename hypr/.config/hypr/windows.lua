-- Personal window rules (loaded from hyprland.lua, after Omarchy's defaults).
-- Migrated from the old windows.conf and apps/protonpass.conf.
-- Rule syntax: https://wiki.hypr.land/Configuring/Basics/Window-Rules/

-- Float transient Chromium popups.
o.window({ class = "chromium", title = "(about:blank - Chromium)" }, { float = true })
o.window({ class = "chromium", title = "(Untitled - Chromium)" }, { float = true })

-- Signal: opt out of Omarchy's global window translucency.
o.window("[Ss]ignal", { tag = "-default-opacity", opacity = "1 1" })

-- Proton Pass: exclude from screen sharing and screenshots.
o.window("^(Proton Pass)$", { no_screen_share = true })
