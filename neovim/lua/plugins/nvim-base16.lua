-- TODO Integrate color scheme changing via Flavours
-- vim.cmd('colorscheme base16-material-palenight')
-- local base16 = require("base16-colors")
-- require("base16-colorscheme").setup(base16.colors)
local current_theme_name = vim.g.colors_name
vim.cmd('colorscheme ' .. current_theme_name)
