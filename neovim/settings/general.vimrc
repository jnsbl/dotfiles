" -----------------------------------------------------------------------------
" Options - Appearance

" set relativenumber
set number
set list listchars=tab:>-,trail:·
set fillchars+=vert:│ " https://github.com/chuling/ci_dark

if exists("neovim_dot_app")
  "tell the term has 256 colors
  set t_Co=256
elseif has("nvim")
  set termguicolors
else
  let g:CSApprox_loaded = 1
endif

" colorscheme is configured in plugins.vimrc

" -----------------------------------------------------------------------------
" Options - Behaviour

let python_highlight_all=1

syntax on
filetype on
filetype indent on
filetype plugin on

set hidden
set autoread
set nowrap
set autowrite

" Enter automatically into the files directory
autocmd BufEnter * silent! lcd %:p:h

autocmd FileType markdown setlocal wrap
autocmd BufRead,BufNewFile *.bork set filetype=sh
autocmd BufRead,BufNewFile *.rake set filetype=ruby
autocmd BufRead,BufNewFile *.thor set filetype=ruby
autocmd BufRead,BufNewFile *.conf set filetype=apache

if has('persistent_undo')
  if !isdirectory(expand('~').'/.vim/backups')
    silent !mkdir ~/.vim/backups > /dev/null 2>&1
  endif
  set undodir=~/.vim/backups
  set undofile
endif

set noswapfile
set nobackup
set nowb

set scrolloff=5         "Start scrolling when we're 5 lines away from margins
set sidescrolloff=15
set sidescroll=1

set splitbelow
set splitright

set wildmode=list:longest

" FIXME The following condition does not work in terminal NeoVim (VimR is OK)
" if has('nvim')
"   set inccommand=nosplit
" endif

" -----------------------------------------------------------------------------
" Options - Indents and Tabs

set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

" -----------------------------------------------------------------------------
" Options - Searching

set gdefault
set incsearch       " Find the next match as we type the search
set hlsearch        " Highlight searches by default
set ignorecase      " Ignore case when searching...
set smartcase       " ...unless we type a capital

" -----------------------------------------------------------------------------
" Options - Completion

" settings recommended by vim-mucomplete
set completeopt+=menuone
set completeopt+=noselect
set shortmess+=c    " Shut off completion messages
