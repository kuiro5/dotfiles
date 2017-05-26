" Josh Kuiros
" .vimrc

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
"set showmatch

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

" Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" General Plugins
Plugin 'scrooloose/nerdtree'            " Directory Tree
Plugin 'vim-scripts/l9'                 " required for FuzzyFinder
Plugin 'vim-airline/vim-airline'        " Status/tabline
Plugin 'tpope/vim-surround'             " Editing, deleting strings, parentheses, brackets, etc
Plugin 'mileszs/ack.vim'                " Fuzzy directory search
Plugin 'junegunn/fzf'                   " Fuzzy file search
Plugin 'junegunn/fzf.vim'               " required for fzf
Plugin 'rakr/vim-one'                   " Atom one dark theme
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'SirVer/ultisnips'               " Snippets
Plugin 'ntpeters/vim-better-whitespace' " Trims trailing whitespace

" Web Dev Plugins
Plugin 'skammer/vim-css-color' " Hex colors
Plugin 'mxw/vim-jsx' " JSX Syntax Highlighter
Plugin 'cakebaker/scss-syntax.vim' " SCSS Syntax Highlighter
Plugin 'vim-ruby/vim-ruby'
Plugin 'kchmck/vim-coffee-script'
Plugin 'vim-syntastic/syntastic'
Plugin 'mtscout6/syntastic-local-eslint.vim'

" Include .jsx syntax highlighting in .js files
let g:jsx_ext_required = 0

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" " Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" Setup some default ignores
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|\_site)$',
  \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
\}

" Use the nearest .git directory as the cwd
" This makes a lot of sense if you are working on a project that is in
"  version  control. It also supports works with .svn, .hg, .bzr.
let g:ctrlp_working_path_mode = 'r'

call vundle#end()            " Required

" Required for coffeescript
syntax enable               " Syntax highlighting
filetype plugin indent on

let mapleader=" "   " map space to leader

" Key Mappings
map <C-n> <plug>NERDTreeTabsToggle<CR>
map <C-p> :FZF<CR>
inoremap jj <ESC>
" nnoremap <C-tab>   :tabnext<CR>
" nnoremap <C-Delete> :tabclose<CR>

" This allows buffers to be hidden if you've modified a buffer.
" " This is almost a must if you wish to use buffers in this way.
set hidden

" " To open a new empty buffer
" " This replaces :tabnew which I used to bind to this mapping
nmap <leader>t :enew<cr>

" " Move to the next buffer
nmap <Tab> :bnext<CR>

" " Move to the previous buffer
nmap <S-Tab> :bprevious<CR>

" " Close the current buffer and move to the previous one
" " This replicates the idea of closing a tab
nmap <leader>q :bp <BAR> bd #<CR>

" " Show all open buffers and their status
nmap <leader>bl :ls<CR>

" Use a leader instead of the actual named binding
nmap <leader>p :FZF<CR>

nmap <leader>f :Ack!

" " Easy bindings for its various modes
nmap <leader>bb :CtrlPBuffer<cr>
nmap <leader>bm :CtrlPMixed<cr>
nmap <leader>bs :CtrlPMRU<cr>

" Ultisnips bindings
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" Eslint
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exe='$(npm bin)/eslint'

" Theme
set background=dark " for the dark version
colorscheme one

" Set ack to use the_silver_surfer
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
Bundle 'wakatime/vim-wakatime'
