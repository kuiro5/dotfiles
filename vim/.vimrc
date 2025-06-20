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

" Make search case-insensitive, unless they contain upper-case letters
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

" Map leader to space
let mapleader=" "

" 120 Character Color Column
set colorcolumn=120
highlight ColorColumn ctermbg=black

" Remove highlighting on ESC
nnoremap <esc> :noh<return><esc>

" Change color for matching parens
highlight MatchParen cterm=NONE ctermbg=white ctermfg=black

" Loads vim-plug if needed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Required for Operator Mono
highlight htmlArg gui=italic
highlight htmlArg cterm=italic
highlight Comment gui=italic
highlight Comment cterm=italic

" Plugins
call plug#begin('~/.local/share/nvim/plugged')

" Navigation
Plug 'scrooloose/nerdtree'            " Directory Tree
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'easymotion/vim-easymotion'

" Visual
Plug 'vim-airline/vim-airline'        " Status/tabline
Plug 'vim-airline/vim-airline-themes' " Status/tabline themes

" Productivity
Plug 'jiangmiao/auto-pairs'
Plug 'qpkorr/vim-bufkill'
Plug 'andrewradev/splitjoin.vim'
Plug 'Asheq/close-buffers.vim'
Plug 'henrik/vim-reveal-in-finder'
Plug 'scrooloose/nerdcommenter'
Plug 'wakatime/vim-wakatime'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'

" Linting/Formatting
Plug 'ntpeters/vim-better-whitespace' " Trims trailing whitespace

" Git
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'airblade/vim-gitgutter'

" Languages/Frameworks
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'elixir-editors/vim-elixir', { 'for': 'elixir' }
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'mxw/vim-jsx', { 'for': 'javascript' }
Plug 'kana/vim-textobj-user', { 'for': 'ruby' } " Required for vim-textobj-rubyblock
Plug 'nelstrom/vim-textobj-rubyblock', { 'for': 'ruby' }
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'elixir-lsp/coc-elixir', {'do': 'yarn install && yarn prepack'}

" Markdown / Writing Plugins
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'vimwiki/vimwiki'
Plug 'logico/typewriter-vim'

call plug#end()

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

" NERDTree
nmap <leader>pt :NERDTreeTabsToggle<CR>
nmap <leader>pf :NERDTreeFind<CR>
let g:NERDTreeWinPos = 'right'
let g:NERDTreeShowHidden=1

" FZF
" Set ack to use the_silver_surfer
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
map <C-b> :Buffers<CR>
map <C-f> :Ag<CR>
map <C-m> :History<CR>
map <C-p> :Files<CR>
map <C-t> :Tags<CR>
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)

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

set splitbelow
set splitright

" Markdown Soft Wrap Lines
augroup Markdown
 autocmd!
 autocmd Filetype vimwiki setlocal colorcolumn=80
 autocmd Filetype vimwiki setlocal linebreak
 autocmd Filetype vimwiki nnoremap j gj
 autocmd Filetype vimwiki nnoremap k gk
 autocmd Filetype vimwiki colorscheme typewriter
 autocmd Filetype vimwiki let g:airline_theme='typewriter'
augroup end
let g:markdown_fenced_languages = ['bash=sh', 'css', 'javascript', 'js=javascript', 'json=javascript', 'ruby', 'html']

 " Close Buffers
 nnoremap <silent> <C-q> :CloseBuffersMenu<CR>

" JSON
set conceallevel=0

" Goyo
nmap <leader>g :Goyo<CR>:Limelight<CR>

" Vimwiki
let g:vimwiki_list = [{'path': '~/pensieve/notes',
      \ 'syntax': 'markdown', 'ext': '.md',
      \ 'diary_index': 'plan', 'diary_header': 'Plan',
      \ 'diary_rel_path': 'plan/',
      \ 'auto_toc': 1,
      \ 'auto_tags': 1,
      \ 'auto_diary_index': 1}]
nnoremap <leader>bl :VimwikiBacklinks<cr>

" Whitespace
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0

" Coc
set signcolumn=yes
highlight SignColumn ctermbg=NONE

nmap <leader>rn <Plug>(coc-rename)

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

