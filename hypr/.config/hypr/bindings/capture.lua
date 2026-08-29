-- Screenshot bindings. Overrides the PRINT-family binds from the verbatim
-- bindings/utilities.lua (loaded earlier).
--
-- ALT + PRINT (Screenrecording) and SUPER + CTRL + PRINT (OCR) are left as the
-- Omarchy 4 defaults in bindings/utilities.lua.

hl.unbind("PRINT")
hl.unbind("SUPER + PRINT") -- was: Color picker (dropped)

o.bind("PRINT", "Screenshot (quick)", "omarchy-capture-screenshot fullscreen save")
o.bind("SUPER + PRINT", "Screenshot (region)", "omarchy-capture-screenshot region slurp")
o.bind("SUPER + SHIFT + PRINT", "Screenshot (smart)", "omarchy-capture-screenshot smart slurp")
