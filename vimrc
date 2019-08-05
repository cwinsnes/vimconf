" vim: fdm=marker foldenable foldlevel=0 sw=4 ts=4 sts=4 :

" {{{ Plugins
" Requires Vim Plug: https://github.com/junegunn/vim-plug
call plug#begin('~/.vim/plugged')

" {{{ General plugins
Plug 'tpope/vim-dispatch'     " Enables easier compiler switching
Plug 'tpope/vim-fugitive'     " Git wrapper
Plug 'tpope/vim-eunuch'       " Enables syntactic sugar for several unix+vim commands
Plug 'tpope/vim-rsi'          " Add support for several emacsy movements
Plug 'tpope/vim-speeddating'  " Make C-a and similar work with dates

Plug 'ervandew/supertab'  " Make tab sane
" }}}

" {{{ Python plugins
Plug 'tmhedberg/SimpylFold'          " Better Python folding
Plug 'jeetsukumaran/vim-pythonsense' " Python word objects!
" }}}

" {{{ Tags plugins
Plug 'ludovicchabant/vim-gutentags'  " Autogeneration of ctags
" }}}

" {{{ Mode Plugins
Plug 'junegunn/goyo.vim' " Hyperfocus mode. Combine with limelight
Plug 'junegunn/limelight.vim'

Plug 'jceb/vim-orgmode' " Org mode for vim
" }}}

" {{{ GUI Plugins
Plug 'inkarkat/vim-SyntaxRange'
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

" {{{ Disaster recovery
if !isdirectory($HOME . "/.vim/backupdir")
    call mkdir($HOME . "/.vim/backupdir", "p")
endif
set backup
set backupdir=~/.vim/backupdir//
set backupskip=/tmp/* " Don't back up /tmp files
set writebackup

if !isdirectory($HOME . "/.vim/swapdir")
    call mkdir($HOME . "/.vim/swapdir", "p")
endif
set directory=~/.vim/swapdir//
" }}}
" {{{ Persistent undo
set undofile
if !isdirectory($HOME . "/.vim/undodir")
    call mkdir($HOME . "/.vim/undodir", "p")
endif
set undodir=~/.vim/undodir//"
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
nnoremap <tab> za
" }}}
" }}}

" {{{ Keybindings
nnoremap <leader>w :w<cr>
nnoremap <leader>g :Goyo<cr>

noremap <c-l> zz
inoremap <c-l> <c-o>zz
" }}}

" {{{ GUI Options
" Note: most settings are set in gvimrc instead
set noerrorbells visualbell t_vb=

colorscheme industry
" Set the colors of the terminal tab line
highlight TabLineFill ctermfg=black ctermbg=black
highlight TabLine ctermfg=black ctermbg=blue
highlight TabLineSel ctermfg=red ctermbg=black
" }}}

" {{{ Language specific options
" {{{ Python
source $HOME/.vim/syntax/python.vim
" }}}
" {{{ Org mode
let g:org_indent = 1
" }}}
" }}}
