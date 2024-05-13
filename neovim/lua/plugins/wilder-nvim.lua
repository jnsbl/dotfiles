-- Basic config (for both Vim and Neovim)
local wilder = require('wilder')
wilder.setup({modes = {':', '/', '?'}})

wilder.set_option('pipeline', {
  wilder.branch(
    wilder.cmdline_pipeline(),
    wilder.search_pipeline()
  ),
})

-- wilder.set_option('renderer', wilder.wildmenu_renderer({
--   highlighter = wilder.basic_highlighter(),
-- }))

-- Devicons for popupmenu
wilder.set_option('renderer', wilder.popupmenu_renderer({
  highlighter = wilder.basic_highlighter(),
  left = {' ', wilder.popupmenu_devicons()},
  right = {' ', wilder.popupmenu_scrollbar()},
}))
