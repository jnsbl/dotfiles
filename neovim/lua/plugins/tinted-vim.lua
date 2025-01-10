require("base16-colors")
vim.g.tinted_colorspace = 256
local current_theme_name = vim.g.colors_name
vim.cmd('colorscheme ' .. current_theme_name)
