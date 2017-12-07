" Josh Kuiros
" .vimrc

" noncompatible with vi, required for Vundle
set nocompatible

" use system clipboard
set clipboard=unnamed

" turn file autodetect off, required for Vundle
filetype off

" show line numbers
set number

" show relative line numbers
set relativenumber

set noswapfile

" Make searches case-insensitive, unless they contain upper-case letters
set ignorecase
set smartcase

" encoding is utf-8
set encoding=utf-8
set fileencoding=utf-8

" enable matchit plugin, ships with vim and enhances '%'
runtime macros/matchit.vim

" automatically delete line breaks or automatically inserted
" identation on insert mode backspace
set backspace=indent,eol,start

" don't unload buffers when they are abandoned, stay in background
set hidden

" set unix line endings
set fileformat=unix

" unix for new bufferes and fallback line endings to dos
set fileformats=unix,dos

" save up to 100 marks, enable capital marks
set viminfo='100,f1

" no redraw while running macros, registers, or other non-typed comments
set lazyredraw

" indentation
set expandtab       " map tabs to sapces
set autoindent	    " autoindent based on line above
set smartindent     " smarter indent for c-like languages
set shiftwidth=2    " 2 space tabs when reading
set softtabstop=2   " 2 space tabs in insert mode

" Automatically trim trailing whitespace
autocmd BufEnter * EnableStripWhitespaceOnSave

" Plug - used for Prettier
call plug#begin('~/.local/share/nvim/plugged')

"Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

" General Plugins
Plug 'scrooloose/nerdtree'            " Directory Tree
Plug 'vim-scripts/l9'                 " required for FuzzyFinder
Plug 'vim-airline/vim-airline'        " Status/tabline
Plug 'vim-airline/vim-airline-themes' " Status/tabline themes
Plug 'tpope/vim-surround'             " Editing, deleting strings, parentheses, brackets, etc
Plug 'mileszs/ack.vim'                " Fuzzy directory search
Plug 'junegunn/fzf'                   " Fuzzy file search
Plug 'junegunn/fzf.vim'               " required for fzf
Plug 'rakr/vim-one'                   " Atom one dark theme
Plug 'jistr/vim-nerdtree-tabs'
Plug 'ntpeters/vim-better-whitespace' " Trims trailing whitespace
Plug 'tpope/vim-unimpaired'
Plug 'vim-scripts/AutoClose'
Plug 'ludovicchabant/vim-gutentags'
Plug 'eugen0329/vim-esearch'

" Web Dev Plugs
Plug 'skammer/vim-css-color' " Hex colors
Plug 'pangloss/vim-javascript' " Javascript Highlighter
Plug 'mxw/vim-jsx' " JSX Syntax Highlighter
Plug 'cakebaker/scss-syntax.vim' " SCSS Syntax Highlighter
Plug 'vim-ruby/vim-ruby'
Plug 'kchmck/vim-coffee-script'
Plug 'vim-syntastic/syntastic'
Plug 'mtscout6/syntastic-local-eslint.vim'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdcommenter'
"Plug 'Shougo/neocomplete.vim'
Plug 'Shougo/deoplete.nvim'
Plug 'wakatime/vim-wakatime'
Plug 'airblade/vim-gitgutter'

call plug#end()

" Prettier
"let g:prettier#exec_cmd_async = 1
"let g:prettier#autoformat = 0
"let g:prettier#config#bracket_spacing = 'true'
"let g:prettier#config#jsx_bracket_same_line = 'false'
"let g:prettier#config#parser = 'babylon'
"autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md PrettierAsync
"
" Include .jsx syntax highlighting in .js files
let g:jsx_ext_required = 0

" Airline
let g:airline#extensions#tabline#enabled = 1
set laststatus=2
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"
let g:airline_theme='solarized'
"let g:airline_solarized_bg='dark'


" Setup some default ignores
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|\_site)$',
  \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
\}

" Use the nearest .git directory as the cwd
let g:ctrlp_working_path_mode = 'r'

" Required for coffeescript
syntax enable               " Syntax highlighting
filetype plugin indent on

let mapleader=" "   " map space to leader

" Key Mappings
nmap <leader>nt :NERDTreeTabsToggle<CR>
nmap <leader>nf :NERDTreeFind<CR>

map <C-p> :FZF<CR>
inoremap jj <ESC>

" This allows buffers to be hidden if you've modified a buffer.
" " This is almost a must if you wish to use buffers in this way.
set hidden

" To open a new empty buffer
" This replaces :tabnew which I used to bind to this mapping
nmap <leader>t :enew<cr>

" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
nmap <leader>q :bp <BAR> bd #<CR>
nmap <leader>qq bd <CR>

nmap <leader>q :bp <BAR> bd #<CR>

" Show all open buffers and their status
nmap <leader>bl :ls<CR>

" Use a leader instead of the actual named binding
nmap <leader>p :FZF<CR>

nmap <leader>f :Ack!

nmap <leader>r :SyntasticReset<CR>

" Easier split navigation
nmap <C-J> <C-W><C-J>
nmap <C-K> <C-W><C-K>
nmap <C-L> <C-W><C-L>
nmap <C-H> <C-W><C-H>

set splitbelow
set splitright
"
" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exe='$(npm bin)/eslint'

" Deoplete
let g:deoplete#enable_at_startup = 1
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Esearch
let g:esearch = {
      \ 'adapter':    'ag',
      \ 'backend':    'nvim',
      \ 'out':        'win',
      \ 'batch_size': 1000,
      \ 'use':        ['visual', 'hlsearch', 'last'],
      \}

" Theme
set background=dark " for the dark version
"colorscheme one
let g:one_allow_italics = 1

" Set ack to use the_silver_surfer
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" Required for Operator Mono
hi htmlArg gui=italic
hi htmlArg cterm=italic
hi Comment gui=italic
hi Comment cterm=italic
hi Type    gui=italic
hi Type    cterm=italic
