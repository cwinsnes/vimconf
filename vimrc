" vim: fdm=marker foldenable foldlevel=0 sw=4 ts=4 sts=4 :

" {{{ Plugins
" Requires Vim Plug: https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')

" {{{ General plugins
Plug 'tpope/vim-dispatch' " Enables easier compiler switching
Plug 'tpope/vim-fugitive' " Git wrapper
" }}}

" {{{ Python plugins
Plug 'tmhedberg/SimpylFold' " Better folding
Plug 'jeetsukumaran/vim-pythonsense' " Python word objects!
" }}}

call plug#end()
" }}}

" {{{ Basic vim settings
set showcmd
set scrolloff=5
let mapleader = " "
set tabstop=4 softtabstop=0 shiftwidth=4 expandtab smarttab
set autoindent
set modeline
set modelines=3
set incsearch
nnoremap Q <nop> 
noremap <c-l> zz
inoremap <c-l> <c-o>zz
" }}}

" {{{ Persistent undo
set undofile
if !isdirectory($HOME . "/.vim/undodir")
    call mkdir($HOME . "/.vim/undodir", "p")
endif
set undodir=~/.vim/undodir"
" }}}

" {{{ File finding
set path+=**
set wildmenu
" }}}

" {{{ File browsing
let g:netrw_banner=0        " disable annoying banner
let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'
" }}}

" {{{ Code folding
set foldmethod=syntax
set foldnestmax=10
set foldlevel=2
set nofoldenable
" autocmd BufReadPre *.py setlocal foldmethod=indent nofoldenable
nnoremap <tab> za
" }}}

" {{{ Code tags
command! MakeTags !ctags -R .
" }}}

" {{{ GUI Options
" Note: most settings are set in gvimrc instead
set noerrorbells visualbell t_vb=

colorscheme aurora

" Toggle full screen using F11
map <silent> <F11>
\    :call system("wmctrl -ir " . v:windowid . " -b toggle,fullscreen")<CR>:redraw<CR>
" }}}

" {{{ Language specific options
" {{{ Python
source $HOME/.vim/syntax/python.vim
" }}}
" }}}
