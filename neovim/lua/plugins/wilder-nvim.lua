-- Fuzzy config (for Neovim or Vim with yarp)
local wilder = require('wilder')
wilder.setup({modes = {':', '/', '?'}})

wilder.set_option('pipeline', {
  wilder.branch(
    wilder.cmdline_pipeline({
      fuzzy = 1,
      set_pcre2_pattern = 1,
    }),
    wilder.python_search_pipeline({
      pattern = 'fuzzy',
    })
  ),
})

local highlighters = {
  wilder.pcre2_highlighter(),
  wilder.basic_highlighter(),
}

-- wilder.set_option('renderer', wilder.renderer_mux({
--   [':'] = wilder.popupmenu_renderer({
--     highlighter = highlighters,
--   }),
--   ['/'] = wilder.wildmenu_renderer({
--     highlighter = highlighters,
--   }),
-- }))

-- -- Customising the renderer / Wildmenu renderer / Minimal theme
-- wilder.set_option('renderer', wilder.wildmenu_renderer({
--   highlighter = wilder.basic_highlighter(),
--   separator = ' · ',
--   left = {' ', wilder.wildmenu_spinner(), ' '},
--   right = {' ', wilder.wildmenu_index()},
-- }))

-- -- Customising the renderer / Popupmenu renderer / #2
-- wilder.set_option('renderer', wilder.renderer_mux({
--   [':'] = wilder.popupmenu_renderer({
--     highlighter = wilder.basic_highlighter(),
--   }),
--   ['/'] = wilder.wildmenu_renderer({
--     highlighter = wilder.basic_highlighter(),
--   }),
-- }))

-- Customising the renderer / Popupmenu renderer / Popupmenu borders
wilder.set_option('renderer', wilder.popupmenu_renderer(
  wilder.popupmenu_border_theme({
    highlights = {
      border = 'Normal', -- highlight to use for the border
    },
    -- 'single', 'double', 'rounded' or 'solid'
    -- can also be a list of 8 characters, see :h wilder#popupmenu_border_theme() for more details
    border = 'rounded',
  })
))
