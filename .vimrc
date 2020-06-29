" Josh Kuiros
" .vimrc

set nocompatible

" Use system clipboard
set clipboard=unnamed

" Turn file autodetect off, required for Vundle
filetype off

" Show line numbers
set number

" Show relative line numbers
set relativenumber

set noswapfile

" Make searches case-insensitive, unless they contain upper-case letters
set ignorecase
set smartcase

" Encoding is utf-8
set encoding=utf-8
set fileencoding=utf-8

" Enable matchit plugin, ships with vim and enhances '%'
" Required for vim-textobj-rubyblock
runtime macros/matchit.vim

" Automatically delete line breaks or automatically inserted
" Identation on insert mode backspace
set backspace=indent,eol,start

" Don't unload buffers when they are abandoned, stay in background
set hidden

" Set unix line endings
set fileformat=unix

" Unix for new bufferes and fallback line endings to dos
set fileformats=unix,dos

" Save up to 100 marks, enable capital marks
set viminfo='100,f1

" No redraw while running macros, registers, or other non-typed comments
set lazyredraw

" Indentation
set expandtab       " map tabs to spaces
set autoindent	    " autoindent based on line above
set smartindent     " smarter indent for c-like languages
set shiftwidth=2    " 2 space tabs when reading
set softtabstop=2   " 2 space tabs in insert mode
set tabstop=2       " Set tab width to 2

" Spell check
" set spell spelllang=en_us

" Loads vim-plug if needed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plug - used for Prettier
call plug#begin('~/.local/share/nvim/plugged')

" General Plugins
Plug 'scrooloose/nerdtree'            " Directory Tree
Plug 'vim-scripts/l9'                 " required for FuzzyFinder
Plug 'vim-airline/vim-airline'        " Status/tabline
Plug 'vim-airline/vim-airline-themes' " Status/tabline themes
Plug 'tpope/vim-surround'             " Editing, deleting strings, parentheses, brackets, etc
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'ntpeters/vim-better-whitespace' " Trims trailing whitespace
Plug 'tpope/vim-unimpaired'
Plug 'jiangmiao/auto-pairs'
"Plug 'ludovicchabant/vim-gutentags'
Plug 'qpkorr/vim-bufkill'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'andrewradev/splitjoin.vim'
Plug 'easymotion/vim-easymotion'
Plug 'Asheq/close-buffers.vim'
Plug 'henrik/vim-reveal-in-finder'

" Web Dev Plugins
Plug 'pangloss/vim-javascript', { 'for': 'javascript' } " Javascript Highlighter
Plug 'mxw/vim-jsx', { 'for': 'javascript' } " JSX Syntax Highlighter
"Plug 'cakebaker/scss-syntax.vim' " SCSS Syntax Highlighter
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'w0rp/ale'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'scrooloose/nerdcommenter'
Plug 'Shougo/deoplete.nvim'
Plug 'wakatime/vim-wakatime'
Plug 'elixir-editors/vim-elixir', { 'for': 'elixir' }
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'airblade/vim-gitgutter'
Plug 'kana/vim-textobj-user', { 'for': 'ruby' } " Required for vim-textobj-rubyblock
Plug 'nelstrom/vim-textobj-rubyblock', { 'for': 'ruby' }
Plug 'sbdchd/neoformat'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

" Markdown / Writing Plugins
Plug 'junegunn/goyo.vim'
Plug 'vimwiki/vimwiki'

call plug#end()

" Neoformat
autocmd BufWritePre *.js,*.jsx Neoformat prettier
autocmd BufWritePre *.ex,*.exs Neoformat

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

" Required for coffeescript
syntax enable               " Syntax highlighting
filetype plugin indent on

let mapleader=" "   " map space to leader

" NERDTree
nmap <leader>pt :NERDTreeTabsToggle<CR>
nmap <leader>pf :NERDTreeFind<CR>
let g:NERDTreeWinPos = 'right'
let g:NERDTreeShowHidden=1

" FZF
map <C-b> :Buffers<CR>
map <C-f> :Ag<CR>
map <C-m> :History<CR>
map <C-p> :Files<CR>
map <C-t> :Tags<CR>
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)

inoremap jj <ESC>

" This allows buffers to be hidden if you've modified a buffer.
" This is almost a must if you wish to use buffers in this way.
set hidden

" To open a new empty buffer
" This replaces :tabnew which I used to bind to this mapping
nmap <leader>t :enew<cr>

" Buffers
nmap <leader>bd :BD<CR>                   " bufkill - close buffer without closing window
nmap <leader>bd! :bd!<CR>                 " close without saving changes
nmap <leader>bdo :CloseOtherBuffers<CR>   " close other buffers

" Show all open buffers and their status
nmap <leader>bl :ls<CR>

" Close quickfix window
nmap <leader>c :ccl<CR>

" Easier split navigation
nmap <C-J> <C-W><C-J>
nmap <C-K> <C-W><C-K>
nmap <C-L> <C-W><C-L>
nmap <C-H> <C-W><C-H>

" Remove highlighting on ESC
nnoremap <esc> :noh<return><esc>

set splitbelow
set splitright

" Ale
let g:ale_completion_enabled = 1
let g:ale_sign_column_always = 1
let g:ale_linters = {
\   'elixir': [],
\}
highlight ALEWarningSign ctermbg=136
highlight ALEErrorSign ctermbg=125
highlight ALEWarning  ctermbg=235
highlight ALEError ctermbg=235

" Deoplete
let g:deoplete#enable_at_startup = 1
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
augroup Deoplete
  autocmd!
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup end


" Change color for matching parens
hi! MatchParen cterm=NONE,bold gui=NONE,bold  guibg=#eee8d5 guifg=NONE

" Set ack to use the_silver_surfer
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif
" 120 Character Color Column
set colorcolumn=120
highlight ColorColumn ctermbg=0 guibg=lightgrey

" Markdown Soft Wrap Lines
augroup Markdown
 au!
 au BufRead,BufNewFile *.md,*.markdown setlocal colorcolumn=80
 au BufRead,BufNewFile *.md,*.markdown setlocal linebreak
augroup end
let g:markdown_fenced_languages = ['bash=sh', 'css', 'javascript', 'js=javascript', 'json=javascript', 'ruby', 'html']

 " Close Buffers
 nnoremap <silent> <C-q> :CloseBuffersMenu<CR>

" Required for Operator Mono
hi htmlArg gui=italic
hi htmlArg cterm=italic
hi Comment gui=italic
hi Comment cterm=italic

" JSON
set conceallevel=0

" Goyo
nmap <leader>g :Goyo<CR>

" Vimwiki
let g:vimwiki_list = [{'path': '~/pensieve/notes',
      \ 'syntax': 'markdown', 'ext': '.md',
      \ 'diary_index': 'plan', 'diary_header': 'Plan',
      \ 'diary_rel_path': 'plan/',
      \ 'auto_toc': 1,
      \ 'auto_tags': 1,
      \ 'auto_diary_index': 1}]
nnoremap <leader>bl :VimwikiBacklinks<cr>

nnoremap <silent> Q gqap
xnoremap <silent> Q gq
nnoremap <silent> <leader>Q vapJgqap

" Whitespace
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0
