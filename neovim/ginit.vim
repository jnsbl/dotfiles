" Enable Mouse
set mouse=a

" Set Editor Font
if exists(':GuiFont')
  " Use GuiFont! to ignore font errors
  " GuiFont FantasqueSansMono Nerd Font:h12
  " GuiFont! JetBrainsMono Nerd Font:h10.5
  " GuiFont Input Nerd Font:h11
  GuiFont ShureTechMono Nerd Font:h11
  " GuiFont ProFontIIx Nerd Font Mono:h10
  " GuiFont! mononoki Nerd Font Mono:h11
  " GuiFont! Hack Nerd Font Mono:h11
  " GuiFont Terminus:h11
  " GuiFont! Source Code Pro:h11
endif

" Disable GUI Tabline
if exists(':GuiTabline')
  GuiTabline 0
endif

" Disable GUI Popupmenu
if exists(':GuiPopupmenu')
  GuiPopupmenu 0
endif

" Enable GUI ScrollBar
if exists(':GuiScrollBar')
  GuiScrollBar 1
endif

" Right Click Context Menu (Copy-Cut-Paste)
nnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
inoremap <silent><RightMouse> <Esc>:call GuiShowContextMenu()<CR>
xnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>gv
snoremap <silent><RightMouse> <C-G>:call GuiShowContextMenu()<CR>gv
