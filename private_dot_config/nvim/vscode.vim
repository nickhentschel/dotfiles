filetype plugin indent on

if &compatible
  set nocompatible
end

" Leader key
let mapleader=" "

" Swap semicolon and colon for easier command mode access
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

" Easier escape from insert
inoremap jk <Esc>

" Yank to end of line, like D and C
noremap Y y$

" Center search result
noremap n nzz
noremap N Nzz

" Keep visual selection when indenting
vnoremap < <gv
vnoremap > >gv
vnoremap = =gv

" Better navigation for wrapped lines
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

" Create blank lines without entering insert mode
nnoremap <silent> zj o<Esc>
nnoremap <silent> zk O<Esc>

" Basic vim settings
set ignorecase            " Ignore case
set smartcase             " Be smart about case when searching
set hidden                " Allow hidden buffers
set incsearch             " Incremental searching
set hlsearch              " Highlight search

" Replace selection, use . to repeat
nnoremap c* *Ncgn
nnoremap c# #NcgN

" Save with Ctrl+S
inoremap <c-s> <Esc>:w<CR>
nnoremap <c-s> <Esc>:w<CR>
vnoremap <c-s> <Esc>:w<CR>

" Buffer navigation
nnoremap gt :bnext<CR>
nnoremap gT :bprevious<CR>
nnoremap <C-c> :bp\|bd #<CR>

" Search for selected text, forwards or backwards
vnoremap <silent> * :<C-U>
      \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
      \gvy/<C-R><C-R>=substitute(
      \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
      \gV:call setreg('"', old_reg, old_regtype)<CR>

vnoremap <silent> # :<C-U>
      \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
      \gvy?<C-R><C-R>=substitute(
      \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
      \gV:call setreg('"', old_reg, old_regtype)<CR>

call plug#begin('~/.vim/plugged')
  Plug 'tpope/vim-commentary'
  Plug 'tpope/vim-endwise'
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-sleuth'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-unimpaired'
call plug#end()