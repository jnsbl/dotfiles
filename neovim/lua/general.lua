local autocmd = vim.api.nvim_create_autocmd
local opt = vim.opt

-- ----------------------------------------------------------------------------
-- Options - Appearance

opt.termguicolors  = true
opt.relativenumber = true
opt.number         = true
opt.list           = true
opt.listchars      = {tab = ">-", trail = "·"}
opt.fillchars:append("vert:│")
opt.cursorline     = true

-- ----------------------------------------------------------------------------
-- Options - Behaviour

opt.hidden         = true
opt.autoread       = true
opt.autowrite      = true
opt.wrap           = false

-- Enter automatically into the files directory
autocmd("BufEnter", {pattern = "*", command = "silent! lcd %:p:h"})

autocmd("FileType", {pattern = "markdown", command = "setlocal wrap"})
-- autocmd("BufRead,BufNewFile", {pattern = "*.bork", command = "set filetype=sh"})
-- autocmd("BufRead,BufNewFile", {pattern = "*.rake", command = "set filetype=ruby"})
-- autocmd("BufRead,BufNewFile", {pattern = "*.thor", command = "set filetype=ruby"})
-- autocmd("BufRead,BufNewFile", {pattern = "*.conf", command = "set filetype=apache"})

vim.cmd[[
  if has('persistent_undo')
    if !isdirectory(expand('~').'/.vim/backups')
      silent !mkdir ~/.vim/backups > /dev/null 2>&1
    endif
    set undodir=~/.vim/backups
    set undofile
  endif
]]

opt.swapfile       = false
opt.backup         = false
opt.wb             = false

opt.scrolloff      = 5
opt.sidescrolloff  = 15
opt.sidescroll     = 1

opt.splitbelow     = true
opt.splitright     = true

opt.wildmode       = {list = "longest"}

opt.updatetime     = 250
opt.timeoutlen     = 300

-- ----------------------------------------------------------------------------
-- Options - Indents and Tabs

opt.autoindent     = true
opt.smartindent    = true
opt.smarttab       = true
opt.shiftwidth     = 2
opt.softtabstop    = 2
opt.tabstop        = 2
opt.expandtab      = true

-- ----------------------------------------------------------------------------
-- Options - Searching

opt.gdefault       = true
opt.incsearch      = true
opt.inccommand     = "nosplit"
opt.hlsearch       = true
opt.ignorecase     = true
opt.smartcase      = true

-- ----------------------------------------------------------------------------
-- Options - Completion

opt.completeopt:append("menu")
opt.completeopt:append("menuone")
opt.completeopt:append("noselect")
opt.shortmess:append("c")

-- ----------------------------------------------------------------------------
-- Options - Terminal

-- https://github.com/dag/vim-fish#teach-a-vim-to-fish
vim.cmd [[
  if &shell =~# 'fish$'
    set shell=bash
  endif
]]
