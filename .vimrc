" noncompatible with vi, required for Vundle
set nocompatible

" required for Vundle
filetype off                " Turn file autodetect off,

" show line numbers
set number

set noswapfile

" reload files changed outside vim
set autoread

" Show matching brackets/braces/parentheses
set showmatch

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

set guifont=Operator\ Mono

" indentation
set expandtab       " map tabs to sapces
set autoindent	    " autoindent based on line above
set smartindent     " smarter indent for c-like languages
set shiftwidth=2    " 2 space tabs when reading   
set softtabstop=2   " 2 space tabs in insert mode

" Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" General Plugins
Plugin 'scrooloose/nerdtree'          " Directory Tree
Plugin 'vim-scripts/l9'               " required for FuzzyFinder
Plugin 'itchyny/lightline.vim'        " Status bar
Plugin 'tpope/vim-surround'           " Editing, deleting strings, parentheses, brackets, etc 
Plugin 'mileszs/ack.vim'              " Fuzzy directory search
Plugin 'junegunn/fzf'                 " Fuzzy file search
Plugin 'junegunn/fzf.vim'             " required for fzf
Plugin 'rakr/vim-one'                 " Atom one dark theme

" Web Dev Plugins
Plugin 'skammer/vim-css-color' " Hex colors
Plugin 'mxw/vim-jsx' " JSX Syntax Highlighter
Plugin 'cakebaker/scss-syntax.vim' " SCSS Syntax Highlighter
Plugin 'vim-ruby/vim-ruby'
Plugin 'kchmck/vim-coffee-script'   

" Include .jsx syntax highlighting in .js files
let g:jsx_ext_required = 0

call vundle#end()            " Required

" Required for coffeescript
syntax enable               " Syntax highlighting
filetype plugin indent on

" Key Mappings
map <C-n> :NERDTreeToggle<CR>
map <C-p> :FZF<CR>
inoremap jj <ESC>
nnoremap <C-tab>   :tabnext<CR>
nnoremap <C-Delete> :tabclose<CR>

" Theme
set background=dark " for the dark version
colorscheme one

" Set ack to use the_silver_surfer
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
