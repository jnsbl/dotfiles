-- Fuzzy config (for Neovim or Vim with yarp)
local wilder = require('wilder')
wilder.setup({
  modes = {':', '/', '?'},
  accept_key = '<C-l>',
  reject_key = '<C-h>',
})

wilder.set_option('pipeline', {
  wilder.branch(
    wilder.python_file_finder_pipeline({
      file_command = {'fd', '-tf'},
      dir_command = {'fd', '-td'},
      -- use {'cpsm_filter'} for performance, requires cpsm vim plugin
      -- found at https://github.com/nixprime/cpsm
      filters = {'fuzzy_filter', 'difflib_sorter'},
    }),
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
