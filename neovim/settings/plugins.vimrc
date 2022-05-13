" -----------------------------------------------------------------------------
" Plugin Settings - Colorscheme

set termguicolors
let base16colorspace=256
if filereadable(expand("~/.config/nvim/colors/base16.vim"))
  source ~/.config/nvim/colors/base16.vim
elseif filereadable(expand("~/.vimrc_background"))
  source ~/.vimrc_background
else
  set background=dark
  colorscheme base16-gruvbox-dark-medium
endif

" -----------------------------------------------------------------------------
" Plugin Settings - vim-one

try
  " https://github.com/rakr/vim-one#tmux-support
  " set these only if vim-one is the current color scheme
  let current_scheme = get(g:, 'colors_name', 'N/A')
  if current_scheme == 'one'
    set t_8b=^[[48;2;%lu;%lu;%lum
    set t_8f=^[[38;2;%lu;%lu;%lum
  endif
catch /^Vim:E121/
    " ignore
endtry

" -----------------------------------------------------------------------------
" Plugin Settings - Airline

let g:airline_powerline_fonts = 0
let g:airline_left_sep = ''
let g:airline_right_sep = ''
" let g:airline_theme = 'base16_gruvbox_dark_medium' " managed by base16-vim-airline-themes
let g:airline#extensions#tmuxline#enabled = 0

" -----------------------------------------------------------------------------
" Plugin Settings - Bbye

nnoremap <Leader>q :Bdelete<CR>

" -----------------------------------------------------------------------------
" Plugin Settings - Startify

nnoremap <silent> <Leader>st :Startify<CR>

function! s:filter_header(lines) abort
    let longest_line   = max(map(copy(a:lines), 'len(v:val)'))
    let centered_lines = map(copy(a:lines),
        \ 'repeat(" ", (&columns / 2) - (longest_line / 2)) . v:val')
    return centered_lines
endfunction
let g:startify_custom_header = s:filter_header([
  \ ' _____             _       ',
  \ '|   | |___ ___ _ _|_|_____ ',
  \ '| | | | -_| . | | | |     |',
  \ '|_|___|___|___|\_/|_|_|_|_|',
  \ '',
  \ '',
  \ ])
let g:startify_bookmarks = [
  \ {'v': '~/.config/nvim/settings/main.vimrc'},
  \ {'g': '~/.config/nvim/settings/general.vimrc'},
  \ {'p': '~/.config/nvim/settings/plugins.vimrc'},
  \ {'m': '~/.config/nvim/settings/keymap.vimrc'},
  \ {'h': '~/.hammerspoon/init.lua'},
  \ {'t': '~/.config/qtile/config.py'},
  \ {'d': '~/.cdg_paths'},
  \ ]
let g:startify_list_order = ['files', 'bookmarks', 'sessions', 'commands']

" -----------------------------------------------------------------------------
" Plugin Settings - Showmarks

" Tell showmarks to not include the various brace marks (),{}, etc
let g:showmarks_include = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXY"

" -----------------------------------------------------------------------------
" Plugin Settings - AutoTag

" Seems to have problems with some vim files
let g:autotagExcludeSuffixes="tml.xml.text.txt.vim"

" -----------------------------------------------------------------------------
" Plugin Settings - EasyMotion

" These keys are easier to type than the default set
" We exclude semicolon because it's hard to read and
" i and l are too easy to mistake for each other slowing
" down recognition. The home keys and the immediate keys
" accessible by middle fingers are available
let g:EasyMotion_keys='asdfjkoweriop'
let g:EasyMotion_startofline = 0 " keep cursor colum JK motion

map  <Leader><Leader>s <Plug>(easymotion-bd-f)
nmap <Leader><Leader>s <Plug>(easymotion-overwin-f)

nmap <Space> <Plug>(easymotion-overwin-f2)

" -----------------------------------------------------------------------------
" Plugin Settings - Fugitive

" The tree buffer makes it easy to drill down through the directories of your
" git repository, but it’s not obvious how you could go up a level to the
" parent directory. Here’s a mapping of .. to the above command, but
" only for buffers containing a git blob or tree
autocmd User fugitive
  \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
  \   nnoremap <buffer> .. :edit %:h<CR> |
  \ endif

" Every time you open a git object using fugitive it creates a new buffer.
" This means that your buffer listing can quickly become swamped with
" fugitive buffers. This prevents this from becomming an issue:

autocmd BufReadPost fugitive://* set bufhidden=delete

" For fugitive.git, dp means :diffput. Define dg to mean :diffget
nnoremap <silent> ,dg :diffget<CR>
nnoremap <silent> ,dp :diffput<CR>

" -----------------------------------------------------------------------------
" Plugin Settings - tComment

" extensions for tComment plugin. Normally
" tComment maps 'gcc' to comment current line
" this adds 'gcp' comment current paragraph (block)
" using tComment's built in <c-_>p mapping
nmap <silent> gcp <c-_>p

" -----------------------------------------------------------------------------
" Plugin Settings - Unimpaired

" https://github.com/carlhuda/janus/blob/master/vimrc

" Unimpaired configuration
" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e

" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

" -----------------------------------------------------------------------------
" Plugin Settings - Indent Guides

let g:indent_guides_auto_colors = 1
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1

" -----------------------------------------------------------------------------
" Plugin Settings - Surround

" ,# Surround a word with #{ruby interpolation}
map ,# ysiw#
vmap ,# c#{<C-R>"}<ESC>

" ," Surround a word with "quotes"
map ," ysiw"
vmap ," c"<C-R>""<ESC>

" ,' Surround a word with 'single quotes'
map ,' ysiw'
vmap ,' c'<C-R>"'<ESC>

" ,) or ,( Surround a word with (parens)
" The difference is in whether a space is put in
map ,( ysiw(
map ,) ysiw)
vmap ,( c( <C-R>" )<ESC>
vmap ,) c(<C-R>")<ESC>

" ,[ Surround a word with [brackets]
map ,] ysiw]
map ,[ ysiw[
vmap ,[ c[ <C-R>" ]<ESC>
vmap ,] c[<C-R>"]<ESC>

" ,{ Surround a word with {braces}
map ,} ysiw}
map ,{ ysiw{
vmap ,} c{ <C-R>" }<ESC>
vmap ,{ c{<C-R>"}<ESC>

map ,` ysiw`

" -----------------------------------------------------------------------------
" Plugin Settings - SplitJoin

nmap sj :SplitjoinSplit<cr>
nmap sk :SplitjoinJoin<cr>

" -----------------------------------------------------------------------------
" Plugin Settings - YankRing

let g:yankring_history_file = '.yankring-history'
nnoremap ,yr :YRShow<CR>
nnoremap C-y :YRShow<CR>

" -----------------------------------------------------------------------------
" Plugin Settings - Deoplete

if has("python3")
  let g:deoplete#enable_at_startup = 1
else
  let g:deoplete#enable_at_startup = 0
endif

if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif
" let g:deoplete#disable_auto_complete = 1
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
autocmd CompleteDone * pclose

let g:deoplete#sources = {}
let g:deoplete#sources._ = []

" Map standard Ctrl-N completion to Ctrl-Space
inoremap <C-Space> <C-n>

" inoremap <expr><Space> pumvisible() ? "\<C-n>\<C-y>" : "\<Space>"

" -----------------------------------------------------------------------------
" Plugin Settings - FZF

nnoremap <silent> <Leader>f :Files<cr>
nnoremap <silent> <Leader>F :GFiles<cr>
nnoremap <silent> <Leader>G :GFiles?<cr>
nnoremap <silent> <Leader>b :Buffers<cr>
nnoremap <silent> <Leader>h :History<cr>
nnoremap <silent> <Leader>t :BTags<cr>
nnoremap <silent> <Leader>T :Tags<cr>
nnoremap <silent> <Leader>l :BLines<cr>
nnoremap <silent> <Leader>L :Lines<cr>
nnoremap <silent> <Leader>' :Marks<cr>
nnoremap <silent> <Leader>a :Ag<Space>
nnoremap <silent> <Leader>H :Helptags!<cr>
nnoremap <silent> <Leader>C :Commands<cr>
nnoremap <silent> <Leader>: :History:<cr>
nnoremap <silent> <Leader>/ :History/<cr>
nnoremap <silent> <Leader>M :Maps<cr>
nnoremap <silent> <Leader>S :Filetypes<cr>

" -----------------------------------------------------------------------------
" Plugin Settings - ArgWrap

nnoremap <silent> <Leader>A :ArgWrap<CR>

" -----------------------------------------------------------------------------
" Plugin Settings - vim-test

" http://stackoverflow.com/a/28524118
if $PATH !~ "\.rbenv"
    let $PATH="/Users/jnsbl/.rbenv/shims:/Users/jnsbl/.rbenv/bin:" . $PATH
endif

let test#ruby#minitest#file_pattern = 'test_.*\.rb'
let test#ruby#minitest#options = '-I lib --verbose'
let test#ruby#bundle_exec = 1

if exists("g:VimuxTmuxCommand")
  let test#strategy = "vimux"
elseif has("nvim")
  let test#strategy = "neovim"
endif

nnoremap <silent> <Leader>tn :TestNearest<CR>
nnoremap <silent> <Leader>tf :TestFile<CR>
nnoremap <silent> <Leader>ts :TestSuite<CR>
nnoremap <silent> <Leader>tl :TestLast<CR>
nnoremap <silent> <Leader>tv :TestVisit<CR>

" -----------------------------------------------------------------------------
" Plugin Settings - dash.vim

nmap <Leader>d <Plug>DashSearch

" -----------------------------------------------------------------------------
" Plugin Settings - vim-go

let g:go_list_type = "quickfix"
let g:go_fmt_command = "goimports"
let g:go_addtags_transform = "camelcase"
let g:go_metalinter_autosave = 1
let g:go_auto_type_info = 1
let g:go_auto_sameids = 1
let g:go_autodetect_gopath = 1

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

autocmd FileType go nmap <leader>gb  :<C-u>call <SID>build_go_files()<CR>
autocmd FileType go nmap <leader>gr  <Plug>(go-run)
autocmd FileType go nmap <leader>gt  <Plug>(go-test)
autocmd FileType go nmap <Leader>gc  <Plug>(go-coverage-toggle)
autocmd FileType go nmap <Leader>gl  <Plug>(go-metalinter)

" nmap <C-g> :GoDeclsDir<cr>
" imap <C-g> <esc>:<C-u>GoDeclsDir<cr>

autocmd Filetype go command! -bang A  call go#alternate#Switch(<bang>0, 'edit')
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')


" -----------------------------------------------------------------------------
" Plugin Settings - UltiSnips

" resolve conflict with vim-mucomplete
let g:UltiSnipsExpandTrigger = "<f5>"        " Do not use <tab>
let g:UltiSnipsJumpForwardTrigger = "<c-b>"  " Do not use <c-j>

" -----------------------------------------------------------------------------
" Plugin Settings - vim-mucomplete

" " resolve conflict with vim-endwise
" imap <Plug>MyCR <Plug>(MUcompleteCR)
" imap <cr> <Plug>MyCR

" -----------------------------------------------------------------------------
" Plugin Settings - vim-peekaboo

let g:peekaboo_window = 'vert bo 80new'

" -----------------------------------------------------------------------------
" Plugin Settings - coc.nvim

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" -----------------------------------------------------------------------------
" Plugin Settings - coc-git

" navigate chunks of current buffer
nmap [g <Plug>(coc-git-prevchunk)
nmap ]g <Plug>(coc-git-nextchunk)
" show chunk diff at current position
nmap gs <Plug>(coc-git-chunkinfo)
" show commit contains current position
nmap gc <Plug>(coc-git-commit)

" -----------------------------------------------------------------------------
" Plugin Settings - sideways.vim

" nnoremap <c-h> :SidewaysLeft<cr>
" nnoremap <c-l> :SidewaysRight<cr>

" -----------------------------------------------------------------------------
" Plugin Settings - Aerojump

nmap <Leader>as <Plug>(AerojumpSpace)
nmap <Leader>ab <Plug>(AerojumpBolt)
nmap <Leader>aa <Plug>(AerojumpFromCursorBolt)
nmap <Leader>ad <Plug>(AerojumpDefault) " Boring mode
nmap <Leader><space> <Plug>(AerojumpSpace)

" -----------------------------------------------------------------------------
" Plugin Settings - winresizer

let g:winresizer_start_key = '<C-T>'

" -----------------------------------------------------------------------------
" Plugin Settings - vim-css-color

autocmd FileType lua call css_color#init('hex', 'extended', 'luaString')
