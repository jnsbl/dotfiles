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

wilder.set_option('renderer', wilder.renderer_mux({
  [':'] = wilder.popupmenu_renderer(
    wilder.popupmenu_border_theme({
      highlights = {
        border = 'Normal',
      },
      border = 'rounded',
      highlighter = highlighters,
      left = {' ', wilder.popupmenu_devicons()},
      right = {' ', wilder.popupmenu_scrollbar()},
    })
  ),
  ['/'] = wilder.popupmenu_renderer(
    wilder.popupmenu_border_theme({
      highlights = {
        border = 'Normal',
      },
      border = 'rounded',
      highlighter = highlighters,
    })
  ),
  ['?'] = wilder.popupmenu_renderer(
    wilder.popupmenu_border_theme({
      highlights = {
        border = 'Normal',
      },
      border = 'rounded',
      highlighter = highlighters,
    })
  ),
}))
