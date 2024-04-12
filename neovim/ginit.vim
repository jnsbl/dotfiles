" Enable Mouse
set mouse=a

" Set Editor Font
if exists(':GuiFont')
  " Use GuiFont! to ignore font errors
  " GuiFont! FantasqueSansMono Nerd Font:h12
  " GuiFont! Hack Nerd Font:h10.5
  " GuiFont! Hasklug Nerd Font:h10.5
  " GuiFont! Hurmit Nerd Font:h10
  " GuiFont! Input Nerd Font:h11
  " GuiFont! JetBrainsMono Nerd Font:h10.5
  " GuiFont! MesloLGMDZ Nerd Font:h10.5
  " GuiFont! mononoki Nerd Font:h10.5
  " GuiFont! Overpass Mono:h10
  " GuiFont! ProFontIIx Nerd Font:h10
  GuiFont! Recursive Mono Casual Static:h12
  " GuiFont! Recursive Mono Linear Static:h10.5
  " GuiFont! ShureTechMono Nerd Font:h11
  " GuiFont! Sometype Mono:h10.5
  " GuiFont! Source Code Pro:h11
  " GuiFont! Spleen 12x24:h10.5
  " GuiFont! TerminessTTF Nerd Font:h11
else
  " set guifont=Recursive\ Mono\ Casual\ Static:h12
  set guifont=mononoki\ Nerd\ Font:h14
  " set guifont=Hack\ Nerd\ Font:h13
  " set guifont=JetBrainsMono\ Nerd\ Font:h13
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
