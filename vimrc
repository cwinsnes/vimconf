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
Plug 'tpope/vim-vinegar'      " Make netrw slightly more sensible.

Plug 'unblevable/quick-scope' " Highlight characters for f and t and such

Plug 'vimwiki/vimwiki', {'branch': 'dev'}    " Personal wiki in vim

Plug 'cwinsnes/vim-spotlight' " Highlight current line upon buffer switch
" }}}

" {{{ File system
Plug 'ctrlpvim/ctrlp.vim'
" }}}

" {{{ Programming plugins
Plug 'airblade/vim-gitgutter' " Git diff in the gutter
Plug 'tpope/vim-sleuth'   " Heuristically set tabwidth

Plug 'pangloss/vim-javascript'
Plug 'lervag/vimtex'
Plug 'plasticboy/vim-markdown' " Needed for expanded functionality in markdown
if has('nvim')
    Plug 'neovim/nvim-lspconfig'
    Plug 'nvim-treesitter/nvim-treesitter'
endif

Plug 'fisadev/vim-isort'


" {{{ Rust plugins
Plug 'rust-lang/rust.vim'
" }}}

" {{{ Python plugins
Plug 'tmhedberg/SimpylFold'          " Better Python folding
Plug 'jeetsukumaran/vim-pythonsense' " Python word objects!
Plug 'psf/black', { 'commit': 'ce14fa8b497bae2b50ec48b3bd7022573a59cdb1' }
Plug 'cjrh/vim-conda' " Conda envs
Plug 'vim-python/python-syntax'
Plug 'jpalardy/vim-slime', { 'for': 'python' }
Plug 'hanschen/vim-ipython-cell', { 'for': 'python' }
" }}}

" {{{ Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
" }}}

" }}}

" {{{ Tags and Marks plugins
Plug 'ludovicchabant/vim-gutentags'  " Autogeneration of ctags
Plug 'kshenoy/vim-signature'         " Show marks on the side
" }}}

" {{{ Visual plugins
Plug 'kien/rainbow_parentheses.vim' " Rainbow parenthesis for clearer surrounds
Plug 'machakann/vim-highlightedyank' " Highlights the yanked region when yanking
Plug 'Yggdroot/indentLine'
Plug 'itchyny/lightline.vim'

" {{{ Colorschemes
Plug 'bluz71/vim-nightfly-guicolors'
Plug 'joshdick/onedark.vim'
" }}}
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
set conceallevel=2
set concealcursor=
set cmdheight=2
set nolist
let g:vimsyn_embed='lPr'
nnoremap Q <nop>
let mapleader = " "
let maplocalleader = " "

" {{{ Bug fixes
" Stop weird characters showing up due to 'modifyOtherKeys' if present.
let &t_TI = ""
let &t_TE = ""
" }}}

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
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'
augroup NetrwMappings
    autocmd!
    autocmd FileType netrw setl bufhidden=delete " Make netrw not wanna save files
    autocmd FileType netrw nnoremap <buffer> ? :help netrw-quickmap<cr>
    autocmd FileType netrw nnoremap <buffer> c :Ntree<cr>
augroup END
" }}}
" {{{ Code folding
set foldmethod=syntax
set foldnestmax=10
set foldlevel=2
set nofoldenable
" }}}
" {{{ Note taking
" <leader>o opens a notes.org file in this directory, defined later.
if !isdirectory($HOME . "/org")
    call mkdir($HOME . "/org", "p")
endif
" }}}
" }}}

"{{{ NVim specific settings
if has('nvim')
    tnoremap <Esc> <C-\><C-n>
    set wildoptions+=pum
endif
"}}}
"{{{ LSP
if has('nvim')
lua <<EOF
require'lspconfig'.pyls.setup{}
EOF
nnoremap <silent> K <cmd>lua vim.lsp.buf.definition()<CR>
autocmd Filetype python setlocal omnifunc=v:lua.vim.lsp.omnifunc
endif
"}}}
" {{{ Treesitter
if has('nvim')
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all", -- "all", "maintained", or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = {},  -- list of language that will be disabled
  },
  indent = {
    enable = true,
  }
}
EOF
endif
" }}}
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
" {{{ Vim-commentary
nnoremap <leader>c :Comment<cr>
" }}}
" {{{ CtrlP
let g:ctrlp_map = '<c-f>'
let g:ctrlp_cmd = 'CtrlPMixed'
" }}}
" {{{ Rainbow parenthesis
autocmd VimEnter * RainbowParenthesesToggle
autocmd Syntax * RainbowParenthesesLoadRound
autocmd Syntax * RainbowParenthesesLoadSquare
autocmd Syntax * RainbowParenthesesLoadBraces
" }}}
" {{{ Quick scope
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
" }}}
" {{{ Illuminate
hi link illuminatedWord ToolbarLine
" }}}
" {{{ Spotlight
let g:SpotlightBlacklist=['twiggy', 'help', 'netrw']
" }}}
" {{{ Markdown
let g:vim_markdown_conceal = 1
let g:vim_markdown_fenced_languages = ['js=javascript', 'javascript=javascript', 'py=python', 'python=python', 'c=c', 'c++=cpp', 'viml=vim', 'bash=sh', 'ini=dosini']
" }}}
" {{{ VimWiki
let g:vimwiki_hl_headers = 1
let wiki = {'path': '~/org/', 'path_html': '~/org/html/', 'ext': '.wiki', 'css_name': 'style.css'}
let wiki.nested_syntaxes = {'python': 'python', 'c++': 'cpp', 'c': 'c', 'rust': 'rust'}
let wiki.index = 'notes'
let g:vimwiki_list = [wiki]
let g:vimwiki_folding = 'expr'
autocmd FileType vimwiki inoremap <silent><buffer> <C-CR> <Esc>:VimwikiReturn 2 2<CR>
" }}}
" {{{ VimTex
let g:vimtex_fold_enabled=1
let g:tex_flavor = 'latex'
" }}}
" {{{ Black
let g:black_linelength = 88
" }}}
" {{{ SLIME
let g:slime_target = 'tmux'
let g:slime_python_ipython = 1
let g:slime_default_config = {
            \ 'socket_name': get(split($TMUX, ','), 0),
            \ 'target_pane': '{top-right}' }
let g:slime_dont_ask_default = 1
" }}}
" {{{ iPython cell
augroup IpythonMappings
    autocmd!
    autocmd FileType python nnoremap <buffer> <localleader>rs :SlimeSend1 ipython3 --matplotlib<cr>
    autocmd FileType python nnoremap <buffer> <localleader>rc :IPythonCellExecuteCell<cr>
    autocmd FileType python nnoremap <buffer> <localleader>r<cr> :IPythonCellExecuteCellJump<cr>
    autocmd FileType python nnoremap <buffer> <localleader>rr :IPythonCellRestart<cr>
    autocmd FileType python nnoremap <buffer> <localleader>rp :IPythonCellRun<cr>
augroup END
" }}}
" {{{ Conda
let g:conda_startup_msg_suppress = 1
let g:conda_startup_wrn_suppress = 1
" }}}
" {{{ Ultisnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
" }}}
" {{{ Python syntax
let g:python_highlight_all = 1
" }}}
" {{{ rust.vim
let g:rustfmt_autosave = 1
" }}}
" {{{ indentguides
let g:indentLine_setConceal = 0
" }}}
" }}}
"{{{ Custom functions
function! DeleteTS()
    " Deletes trailing whitespace
    let l:cursor_pos = getpos('.')
    keepjumps keeppatterns %s/\s\+$//e
    call setpos('.', l:cursor_pos)
endfunction

autocmd BufWritePre * call DeleteTS()
"}}}

" {{{ Keybindings
nnoremap <leader>s :w<cr>

noremap <c-l> zz

nmap <Leader>o <Plug>VimwikiIndex

" Opening a file with the same path header as the current file
nnoremap <leader>e :e %:p:h/
nnoremap <leader>b :b#<cr>

" Highlight all instances of current word
nnoremap <leader>m :let @/='\<<c-r>=expand("<cword>")<cr>\>'<cr>:set hls<cr>
" Unhighlight
nnoremap <leader>n :nohlsearch<cr>

" Generate ctags, in case gutentags hasn't generated them.
nnoremap <leader>gt :!ctags -R %:p:h<cr>

function FileDrawer()
    let tabnum = tabpagenr()
    let bufnum = bufwinnr('netrwfiledrawer' . '-' . tabnum)
    if bufnum > 0
        execute(bufnum . 'wincmd q')
    else
        execute('Vexplore')
        execute('f0')
        execute('f netrwfiledrawer' . '-' . tabnum)
    endif
endfunction

nnoremap <silent> <f8> :call FileDrawer()<cr>

command! ChangeDir :cd %:p:h
" }}}

" {{{ GUI Options
" Note: Some settings might be set in gvimrc instead
set noerrorbells visualbell t_vb=
set background=dark
set nocursorline
set nocursorcolumn
set ruler
set termguicolors
colorscheme onedark
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
augroup PythonPreWrite
    autocmd!
    autocmd BufWrite *.py Black
    autocmd BufWrite *.py Isort
augroup END
execute "source " . vimhome . "/syntax/python.vim"
" }}}
" }}}

