" vim: fdm=marker foldenable foldlevel=0 sw=4 ts=4 sts=4 :
if has("win32") || has("win16")
    let vimhome = $HOME . "/vimfiles/"
else
    let vimhome = $HOME . "/.vim/"
endif

" {{{ Plugins
" Requires Vim Plug: https://github.com/junegunn/vim-plug
call plug#begin(vimhome . '/plugged')

" {{{ General plugins
Plug 'tpope/vim-dispatch'     " Enables easier compiler switching
Plug 'tpope/vim-fugitive'     " Git wrapper
Plug 'sodapopcan/vim-twiggy'  " Git branch extension of Fugitive
Plug 'tpope/vim-eunuch'       " Enables syntactic sugar for several unix+vim commands
Plug 'tpope/vim-rsi'          " Add support for several emacsy movements
Plug 'tpope/vim-commentary'   " gc for toggling line comment
Plug 'tpope/vim-speeddating'  " Make C-a and similar work with dates
Plug 'tpope/vim-surround'     " Makes changing surrounding quotes and such easy
Plug 'tpope/vim-repeat'       " Allows for repetition of plugin maps
Plug 'tpope/vim-unimpaired'   " Paired mappings

Plug 'unblevable/quick-scope' " Highlight characters for f and t and such

Plug 'RRethy/vim-illuminate'  " Highlight instances of the same word

Plug 'christoomey/vim-tmux-navigator' "Interact with tmux. Requires tmux config as well!

Plug 'cwinsnes/vim-spotlight' " Highlight current line upon buffer switch
" }}}

" {{{ File system
Plug 'scrooloose/nerdtree' " Yes, netrw exists but it is worse by far
Plug 'ctrlpvim/ctrlp.vim'
" }}}

" {{{ Programming plugins
Plug 'dense-analysis/ale' " Asynch linting engine for most languages
Plug 'airblade/vim-gitgutter' " Git diff in the gutter
Plug 'tpope/vim-sleuth'   " Heuristically set tabwidth

Plug 'pangloss/vim-javascript'
Plug 'lervag/vimtex'
Plug 'plasticboy/vim-markdown' " Needed for expanded functionality in markdown

" {{{ Python plugins
Plug 'tmhedberg/SimpylFold'          " Better Python folding
Plug 'jeetsukumaran/vim-pythonsense' " Python word objects!
" }}}

" }}}

" {{{ Tags plugins
Plug 'ludovicchabant/vim-gutentags'  " Autogeneration of ctags
" }}}

" {{{ Visual plugins
Plug 'ryanoasis/vim-devicons' " Add icons to netrw and such. Requires a compatible Nerd Font.
Plug 'kien/rainbow_parentheses.vim' " Rainbow parenthesis for clearer surrounds
Plug 'machakann/vim-highlightedyank' " Highlights the yanked region when yanking
" }}}

call plug#end()
" }}}

" {{{ Basic vim settings
set showcmd
set scrolloff=5
set tabstop=4 softtabstop=0 shiftwidth=4 expandtab smarttab
set autoindent
set modeline
set modelines=3
set incsearch
set hidden
set ignorecase
set smartcase
set signcolumn=auto
set updatetime=100
set conceallevel=0
nnoremap Q <nop> 
let mapleader = " "
let maplocalleader = " "


" {{{ Disaster recovery
if !isdirectory(vimhome . "/backupdir")
    call mkdir(vimhome . "/backupdir", "p")
endif
set backspace=2 " Set backspace behaviour here because OS X is stupid...
set backup
set backupdir=~/.vim/backupdir//
set backupskip=/tmp/* " Don't back up /tmp files
set writebackup

if !isdirectory(vimhome . "/swapdir")
    call mkdir(vimhome . "/swapdir", "p")
endif
set directory=~/.vim/swapdir//
" }}}
" {{{ Persistent undo
set undofile
if !isdirectory(vimhome . "/undodir")
    call mkdir(vimhome . "/undodir", "p")
endif
set undodir=~/.vim/undodir//"
" }}}
" {{{ File finding
set path+=**
set wildignore+=**/node_modules/**
set wildmenu
" }}}
" {{{ File browsing
let g:netrw_banner=0        " disable annoying banner
let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'
autocmd FileType netrw setl bufhidden=delete " Make netrw not wanna save files
" }}}
" {{{ Code folding
set foldmethod=syntax
set foldnestmax=10
set foldlevel=2
set nofoldenable
nnoremap <tab> za
" }}}
" {{{ Note taking
" <leader>o opens a notes.org file in this directory, defined later.
if !isdirectory($HOME . "/notes")
    call mkdir($HOME . "/notes", "p")
endif
" }}}
" }}}

"{{{ NVim settings
if has('nvim')
    tnoremap <Esc> <C-\><C-n>
    set wildoptions+=pum
endif
"}}}

" {{{ Plugin options
" {{{ LimeLight
" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240

" Color name (:help gui-colors) or RGB color
let g:limelight_conceal_guifg = 'DarkGray'
let g:limelight_conceal_guifg = '#777777'

" Default: 0.5
let g:limelight_default_coefficient = 0.7

" Number of preceding/following paragraphs to include (default: 0)
let g:limelight_paragraph_span = 1

" Beginning/end of paragraph
"   When there's no empty line between the paragraphs
"   and each paragraph starts with indentation
let g:limelight_bop = '^\s'
let g:limelight_eop = '\ze\n^\s'

" Highlighting priority (default: 10)
"   Set it to -1 not to overrule hlsearch
let g:limelight_priority = -1
" }}}
" {{{ ALE
nmap <leader>k <Plug>(ale_previous_wrap)
nmap <leader>j <Plug>(ale_next_wrap)
                    
let g:ale_python_pylint_executable = 'python3' 

" }}}
" {{{ Vim-commentary
nnoremap <leader>c :Comment<cr>
" }}}
" {{{ CtrlP
let g:ctrlp_map = '<c-f>'
let g:ctrlp_cmd = 'CtrlPMixed'
" }}}
" {{{ Rainbow parenthesis
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
" }}}
" {{{ Quick scope
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
" }}}
" {{{ Illuminate
hi link illuminatedWord ToolbarLine
" }}}
" {{{ Spotlight
let g:SpotlightBlacklist=['nerdtree', 'twiggy', 'help']
" }}}
" {{{ Markdown
let g:vim_markdown_conceal = 0
let g:vim_markdown_fenced_languages = ['js=javascript', 'javascript=javascript', 'py=python', 'python=python', 'c=c', 'c++=cpp', 'viml=vim', 'bash=sh', 'ini=dosini']
" }}}
" {{{ VimTex
let g:vimtex_fold_enabled=1
" }}}
" }}}

" {{{ Keybindings
nnoremap <leader>w :w<cr>
nnoremap <leader>g :Goyo<cr>

noremap <leader>l zz
inoremap <c-l> <c-o>zz

nnoremap <leader>o :botright vnew $HOME/notes/notes.md<cr>

" Opening a file with the same path header as the current file
nnoremap <leader>e :e %:p:h/
nnoremap <leader>b :b#<cr>

nnoremap <leader>m :let @/='\<<c-r>=expand("<cword>")<cr>\>'<cr>:set hls<cr>
nnoremap <leader>n :nohlsearch<cr>

command! ChangeDir :cd %:p:h
" }}}

" {{{ GUI Options
" Note: Some settings might be set in gvimrc instead
set noerrorbells visualbell t_vb=
set background=dark
set nocursorline
set nocursorcolumn
colorscheme badwolf
" Set the colors of the terminal tab line
highlight TabLineFill ctermfg=black ctermbg=black
highlight TabLine ctermfg=black ctermbg=blue
highlight TabLineSel ctermfg=red ctermbg=black
syntax on

if exists('$TMUX')
  let &t_SI = "\ePtmux;\e\e[5 q\e\\"
  let &t_EI = "\ePtmux;\e\e[2 q\e\\"
else
  let &t_SI = "\e[5 q"
  let &t_EI = "\e[2 q"
endif
" }}}

" {{{ Language options
" {{{ Python
execute "source " . vimhome . "/syntax/python.vim"
" }}}
" }}}

