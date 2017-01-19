" pathogen
execute pathogen#infect()

" noncompatible with vi
set nocompatible

" syntax highlighting
syntax on 

" show line numbers
set number

" detect file types and load plugins
filetype on
filetype plugin on
filetype indent on

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

" let g:solarized_termcolors=256
" syntax enable
" set background=dark
" colorscheme solarized
