-- Personal application launchers. Loaded after the verbatim Omarchy binding
-- modules, so keys they already claim are unbound first.

hl.unbind("SUPER + CTRL + N")       -- was: Toggle nightlight (still on the Toggle menu, SUPER+CTRL+O)
hl.unbind("SUPER + CTRL + P")       -- was: Power panel (still on the Toggle menu / SUPER+Q system menu)
hl.unbind("SUPER + SPACE")          -- was: Omarchy menu
hl.unbind("SUPER + ALT + SPACE")    -- was: Apps menu

o.bind("SUPER + ALT + SPACE", "Omarchy menu", "omarchy-menu toggle")
o.bind("SUPER + SPACE", "Apps menu", "omarchy-menu toggle apps")

o.bind("SUPER + RETURN", "Terminal", "omarchy-launch-terminal")
o.bind("SUPER + ALT + RETURN", "Tmux", "omarchy-launch-terminal tmux new")
o.bind("SUPER + SHIFT + RETURN", "File manager", { launch = "nautilus --new-window" })
o.bind("SUPER + CTRL + RETURN", "Research browser", { launch = "helium-browser" })

o.bind("SUPER + F1", "Show key bindings", "omarchy-menu-keybindings")

o.bind("SUPER + SHIFT + B", "Browser", "omarchy-launch-browser")
o.bind("SUPER + SHIFT + N", "Neovim", { tui = "nvim" })
o.bind("SUPER + SHIFT + X", "Activity", { tui = "btop" })
o.bind("SUPER + SHIFT + G", "Signal", { launch = "signal-desktop" })
o.bind("SUPER + SHIFT + O", "Obsidian", { launch = "obsidian" })
o.bind("SUPER + CTRL + P", "Passwords", { launch = "proton-pass" })
o.bind("SUPER + CTRL + N", "Quick notes", { launch = "subl3" })

o.bind("SUPER + SHIFT + ALT + A", "ChatGPT", { webapp = "https://chatgpt.com" })
o.bind("SUPER + SHIFT + A", "Claude", { webapp = "https://claude.ai" })
o.bind("SUPER + SHIFT + W", "Wikipedia", { webapp = "https://www.wikipedia.org" })

o.bind("SUPER + Q", "Power menu", "omarchy-menu toggle system")
