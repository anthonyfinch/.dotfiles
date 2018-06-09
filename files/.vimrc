set nocompatible   " Disable vi-compatibility
filetype plugin indent on

set background=dark
set updatetime=4000
set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show Unicode glyphs

if has("autocmd")
  augroup module
    autocmd BufRead,BufNewFile *.module set filetype=php
    autocmd BufRead,BufNewFile *.install set filetype=php
    autocmd BufRead,BufNewFile *.test set filetype=php
		autocmd BufRead,BufNewFile *.as set filetype=actionscript
		autocmd BufRead,BufNewFile *.blade set filetype=jade
		autocmd BufRead,BufNewFile *.elm set filetype=haskell
  augroup END
	autocmd BufReadPost fugitive://* set bufhidden=delete
endif
set incsearch
set hlsearch
syntax on
set number
set tabstop=2
set shiftwidth=2
set foldmethod=syntax
set foldlevel=0
set wrap 
set linebreak 
set nolist
set cursorline
set scrolloff=5

" Easier pane movement
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h

" Fast exit
inoremap fd <Esc>

nmap <C-S-Tab> :tabprevious<cr>
nmap <C-Tab> :tabnext<cr>
nmap <C-t> :tabnew<cr>
map <C-t> :tabnew<cr>
map <C-S-Tab> :tabprevious<cr>
map <C-Tab> :tabnext<cr>
imap <C-S-tab> <ESC>:tabprevious<cr>i
imap <C-tab> <ESC>:tabnext<cr>i
imap <C-t> <ESC>:tabnew<cr>
map <leader>l <Plug>TaskList
map <leader>g :GundoToggle<CR>
map <leader>n :NERDTreeToggle<CR>
map <leader>t :TlistToggle<CR>
" map <leader>f :CommandT<CR>
map <leader>f :CtrlP<CR>
nnoremap th  :tabfirst<CR>
nnoremap tj  :tabnext<CR>
nnoremap tk  :tabprev<CR>
nnoremap tl  :tablast<CR>

" Dispatch! 
nnoremap <leader><CR> :Dispatch<CR>

" Quickfix
" nmap <leader>c   :copen<CR>
" nmap <leader>cc  :cclose<CR>

" Write and quit
nnoremap <leader>q ZZ

" Sideways movement
nnoremap H ^
nnoremap L $

" Lines shift up and down
nnoremap - ddp
nnoremap _ ddkP

" Uppercase words
inoremap <leader>u <esc>viwUea
nnoremap <leader>u viwUe

" vimrc editing
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Abbreviations
iabbrev @@ actionspeakslouder@gmail.com
