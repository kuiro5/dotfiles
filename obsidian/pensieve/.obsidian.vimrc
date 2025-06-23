set clipboard=unnamed

" Allow o/O to maintain list context
exmap blankBelow obcommand obsidian-editor-shortcuts:insertLineBelow
exmap blankAbove obcommand obsidian-editor-shortcuts:insertLineAbove
nmap o :blankBelow<CR>i
nmap O :blankAbove<CR>i

" Navigate soft line wraps
set whichwrap+=h,l,[,]
nnoremap j gj
nnoremap k gk
