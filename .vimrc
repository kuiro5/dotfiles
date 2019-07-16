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
set expandtab       " map tabs to sapces
set autoindent	    " autoindent based on line above
set smartindent     " smarter indent for c-like languages
set shiftwidth=2    " 2 space tabs when reading
set softtabstop=2   " 2 space tabs in insert mode
set tabstop=2       " Set tab width to 2

" Python Identation
au BufNewFile,BufRead *.py
      \ set tabstop=4
      \ set softtabstop=4
      \ set shiftwidth=4

" Spell check
" set spell spelllang=en_us

" Autocmds
autocmd BufEnter * EnableStripWhitespaceOnSave  " trim whitespace on save

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
Plug 'rakr/vim-one'                   " Atom one dark theme
Plug 'jistr/vim-nerdtree-tabs'
Plug 'ntpeters/vim-better-whitespace' " Trims trailing whitespace
Plug 'tpope/vim-unimpaired'
Plug 'jiangmiao/auto-pairs'
Plug 'ludovicchabant/vim-gutentags'
Plug 'qpkorr/vim-bufkill'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'terryma/vim-multiple-cursors'
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'andrewradev/splitjoin.vim'
Plug 'easymotion/vim-easymotion'
Plug 'Asheq/close-buffers.vim'
Plug 'edkolev/tmuxline.vim'
Plug 'kana/vim-textobj-line'
Plug 'henrik/vim-reveal-in-finder'
Plug 'mhinz/vim-startify'

" Notes
Plug 'vimwiki/vimwiki'

" Web Dev Plugins
Plug 'skammer/vim-css-color' " Hex colors
Plug 'pangloss/vim-javascript' " Javascript Highlighter
Plug 'mxw/vim-jsx' " JSX Syntax Highlighter
Plug 'cakebaker/scss-syntax.vim' " SCSS Syntax Highlighter
Plug 'vim-ruby/vim-ruby'
Plug 'kchmck/vim-coffee-script'
Plug 'w0rp/ale'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'scrooloose/nerdcommenter'
Plug 'Shougo/deoplete.nvim'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug 'wakatime/vim-wakatime'
Plug 'airblade/vim-gitgutter'
Plug 'elixir-editors/vim-elixir'
Plug 'fatih/vim-go'
Plug 'kana/vim-textobj-user' " Required for vim-textobj-rubyblock
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'vim-scripts/indentpython.vim'
Plug 'sbdchd/neoformat'
Plug 'tpope/vim-haml'
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

" Writing Plugs
Plug 'reedes/vim-pencil'

call plug#end()

" Neoformat
" vim-prettier is currently using a global executable
augroup NeoformatAutoFormat
    autocmd!
    autocmd FileType javascript,javascript.jsx setlocal formatprg=prettier
    autocmd BufWritePre *.js,*.jsx Neoformat
augroup END

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
highlight ALEWarning  ctermbg=Black
highlight ALEWarningSign ctermbg=Black
highlight ALEErrorSign ctermbg=Black

" Deoplete
let g:deoplete#enable_at_startup = 1
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Needed for vim-multiple-cursors,
" Called once right before you start selecting multiple cursors
function! Multiple_cursors_before()
    if exists('g:deoplete#disable_auto_complete')
           let g:deoplete#disable_auto_complete = 1
    endif
endfunction

" Needed for vim-multiple-cursors,
" Called once right before you start selecting multiple cursors
" Called once only when the multiple selection is canceled (default <Esc>)
function! Multiple_cursors_after()
    if exists('g:deoplete#disable_auto_complete')
           let g:deoplete#disable_auto_complete = 0
    endif
endfunction

nmap <leader>p <Plug>yankstack_substitute_older_paste
nmap <leader>P <Plug>yankstack_substitute_newer_paste

" Theme
set background=dark " for the dark version

let g:one_allow_italics = 1

" Change color for matching parens
hi! MatchParen cterm=NONE,bold gui=NONE,bold  guibg=#eee8d5 guifg=NONE

" Set ack to use the_silver_surfer
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" Neosnippet
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif
" 120 Character Color Column
set colorcolumn=120
highlight ColorColumn ctermbg=0 guibg=lightgrey

" Markdown Soft Wrap Lines
 "autocmd BufRead,BufNewFile *.md setlocal textwidth=120
 "autocmd BufRead,BufNewFile *.md setlocal formatoptions+=ar

 " Close Buffers
 nnoremap <silent> <C-q> :CloseBuffersMenu<CR>

" Required for Operator Mono
hi htmlArg gui=italic
hi htmlArg cterm=italic
hi Comment gui=italic
hi Comment cterm=italic

" JSON
set conceallevel=0

" vim-pencil settings
augroup pencil
  autocmd!
  autocmd FileType markdown,mkd call pencil#init()
  autocmd FileType text         call pencil#init()
augroup END
nnoremap <silent> Q gqap
xnoremap <silent> Q gq
nnoremap <silent> <leader>Q vapJgqap
