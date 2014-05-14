set nocompatible   " Disable vi-compatibility
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-git'
Bundle 'tpope/vim-unimpaired'
Bundle 'ervandew/supertab'
" Bundle 'wincent/Command-T'
" Bundle 'Valloric/YouCompleteMe'
Bundle 'kien/ctrlp.vim'
Bundle 'mileszs/ack.vim'
Bundle 'sjl/gundo.vim'
Bundle 'vim-scripts/The-NERD-tree'
Bundle 'kchmck/vim-coffee-script'
Bundle 'othree/html5.vim'
Bundle 'mattn/emmet-vim'
Bundle 'klen/python-mode'
Bundle 'scrooloose/syntastic'
Bundle 'Lokaltog/vim-powerline'
Bundle 'altercation/vim-colors-solarized'
Bundle 'stephenmckinney/vim-solarized-powerline'
Bundle 'jmcantrell/vim-virtualenv'
Bundle 'tpope/vim-dispatch'
" Bundle 'epeli/slimux'
Bundle 'nanotech/jellybeans.vim'
" Bundle 'reinh/vim-makegreen'
" Bundle 'file:///home/tony/django-mg'
" Bundle 'pydave/AsyncCommand'
Bundle 'evanmiller/nginx-vim-syntax'
" snipmate dependiencies
Bundle "MarcWeber/vim-addon-mw-utils"
Bundle "tomtom/tlib_vim"
Bundle "honza/vim-snippets"

Bundle "garbas/vim-snipmate"
Bundle "jnwhiteh/vim-golang"
Bundle "jdonaldson/vaxe"
Bundle "Rykka/riv.vim" 
Bundle "plasticboy/vim-markdown.git"

Bundle "pangloss/vim-javascript"

Bundle "tpope/timl"
Bundle "dag/vim2hs"

Bundle "kovisoft/slimv"
Bundle "bitc/vim-hdevtools"

filetype on
filetype plugin indent on

set background=dark
set updatetime=4000
set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show Unicode glyphs

colorscheme solarized 
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
inoremap jk <Esc>

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

" Python Mode Settings"
function! PyMeUp()
	let g:pymode_lint_ignore="E501,C901"
endfunction

" autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType python call PyMeUp()
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete
" let g:SuperTabDefaultCompletionType = "context"
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" CtrlP Settings
set wildignore+=*.pyc,*.hi,*.o
let g:ctrlp_custom_ignore={
			\ 'dir': '\v\migrations',
			\}

nmap SQ <ESC>:mksession! ~/.vim/Session.vim<CR>:wqa<CR>

function! GetBufferList()
  redir =>buflist
  silent! ls
  redir END
  return buflist
endfunction

function! ToggleList(bufname, pfx)
  let buflist = GetBufferList()
  for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if bufwinnr(bufnum) != -1
      exec(a:pfx.'close')
      return
    endif
  endfor
  if a:pfx == 'l' && len(getloclist(0)) == 0
      echohl ErrorMsg
      echo "Location List is Empty."
      return
  endif
  let winnr = winnr()
  exec(a:pfx.'open')
  if winnr() != winnr
    wincmd p
  endif
endfunction

nmap <silent> <leader>l :call ToggleList("Location List", 'l')<CR>
nmap <silent> <leader>c :call ToggleList("Quickfix List", 'c')<CR>
