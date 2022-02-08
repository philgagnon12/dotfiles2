set path+=$PWD/**
" Show line numbers
set number
set relativenumber

" Always show tabline
set showtabline=2

" When split be positionned down, ( OFF )
" set splitbelow
" Split from left to right
set splitright

" Show white spaces
set list

" Standard vim things
source @CMAKE_INSTALL_PREFIX@/sensible.vim

"Tab 4 into spaces 
set expandtab
set tabstop=4
set shiftwidth=4

" Show cursor line only in the active window
augroup CursorLine
	au!
	au VimEnter,WinEnter,BufWinEnter * setlocal cursorline 
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorcolumn
	au WinLeave * setlocal nocursorline
	au WinLeave * setlocal nocursorcolumn
augroup END

" Cursor line style
" if not looking good try
" hi CursorLine term=reverse ctermbg=8
hi CursorLine term=reverse ctermbg=19
hi CursorColumn term=reverse ctermbg=19

" Color theme
source @CMAKE_INSTALL_PREFIX@/base16-shell.vim

" White space style
hi SpecialKey ctermfg=red
 
" TabLine
hi TabLineFill term=bold ctermbg=18
hi TabLineSel  term=bold ctermfg=18 ctermbg=4

" StatusLine
hi StatusLine term=bold,reverse ctermfg=21 ctermbg=6
 
" () {} [] coloring when hovering
hi MatchParen term=reverse ctermfg=14 ctermbg=18

" Tab Title
hi Title NONE
