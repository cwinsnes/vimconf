set guioptions-=m  "remove menu bar
set guioptions-=T  "remove toolbar
set guioptions-=r  "remove right-hand scroll bar
set guioptions-=L  "remove left-hand scroll bar
set guioptions+=c  "Remove popups
set noerrorbells visualbell t_vb=
if has('unix')
    set guifont=Inconsolata\ Nerd\ Font\ 11
endif
if has('macunix')
    set guifont=Inconsolata\ Nerd\ Font:h13
endif

" Toggle full screen using F11
map <silent> <F11>
\    :call system("wmctrl -ir " . v:windowid . " -b toggle,fullscreen")<CR>:redraw<CR>
