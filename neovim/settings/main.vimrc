set nocompatible

" https://github.com/dag/vim-fish#teach-a-vim-to-fish
if &shell =~# 'fish$'
  set shell=bash
endif

" Automatically install vim-plug and run PlugInstall if vim-plug not found
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" -----------------------------------------------------------------------------
" Python support

" https://github.com/tweekmonster/nvim-python-doctor/wiki/Advanced:-Using-pyenv
let g:python_host_prog = '/Users/jnsbl/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = '/Users/jnsbl/.pyenv/versions/neovim3/bin/python'

" TODO Find a Vim-supported alternative for Neovim-specific plugins (e.g. Deoplete)

call plug#begin('~/.vim/plugged')
" General
Plug 'mhinz/vim-startify'
Plug 'tomtom/tcomment_vim'
Plug 'skwp/YankRing.vim'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-vinegar'
Plug 'vim-scripts/AutoTag', has('python3') ? {} : { 'on': [] }
Plug 'Townk/vim-autoclose'
Plug 'FooSoft/vim-argwrap'
Plug 'christoomey/vim-tmux-navigator'
Plug 'vim-scripts/ReplaceWithRegister'
Plug 'moll/vim-bbye'
Plug 'sickill/vim-pasta'
Plug 'AndrewRadev/whitespaste.vim'
Plug 'junegunn/vim-peekaboo'
Plug 'AndrewRadev/sideways.vim'
Plug 'psliwka/vim-smoothie'
Plug 'simeji/winresizer'

" Search
Plug 'nelstrom/vim-visual-star-search'
Plug 'Lokaltog/vim-easymotion'
Plug 'timakro/vim-searchant'
Plug 'junegunn/fzf', { 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
" Plug 'rizzatti/dash.vim'

" Appearance
Plug 'chriskempson/base16-vim'
Plug 'xsunsmile/showmarks'
" Required for Gblame in terminal vim
Plug 'godlygeek/csapprox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'edkolev/tmuxline.vim'
" Plug 'rakr/vim-one'
Plug 'powerman/vim-plugin-AnsiEsc'
Plug 'dracula/vim', { 'as': 'dracula' }
" Plug 'chuling/ci_dark'
Plug 'luochen1990/rainbow'

" Languages and Syntax highlighting
" Plug 'vim-ruby/vim-ruby'
Plug 'ecomba/vim-ruby-refactoring'
Plug 'tpope/vim-rbenv'
Plug 'tpope/vim-git'
Plug 'tpope/vim-fugitive'
Plug 'ekalinin/Dockerfile.vim'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'tpope/vim-endwise'
" Plug 'janko-m/vim-test'
" Plug 'junegunn/gv.vim'
Plug 'pearofducks/ansible-vim'
" Plug 'benmills/vimux'
" Plug 'tpope/vim-liquid'
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'vim-scripts/indentpython.vim'
Plug 'dag/vim-fish'
" Plug 'kchmck/vim-coffee-script'
Plug 'elzr/vim-json'
Plug 'pangloss/vim-javascript'

" Text objects
Plug 'kana/vim-textobj-user'
Plug 'bootleq/vim-textobj-rubysymbol'           |  Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'                  |  Plug 'kana/vim-textobj-user'
Plug 'nelstrom/vim-textobj-rubyblock'           |  Plug 'kana/vim-textobj-user'
Plug 'wellle/targets.vim'
Plug 'AndrewRadev/dsf.vim'

" Code completion
" Plug 'lifepillar/vim-mucomplete'
Plug 'Shougo/neco-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
if has('python3') || has('python')
  Plug 'SirVer/ultisnips'
  " Plug 'zchee/deoplete-jedi'
end
Plug 'honza/vim-snippets'
call plug#end()
