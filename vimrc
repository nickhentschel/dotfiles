" * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
" *                                                           *
" *                 ██                                        *
" *                ░░                                         *
" *        ██    ██ ██ ██████████  ██████  █████              *
" *       ░██   ░██░██░░██░░██░░██░░██░░█ ██░░░██             *
" *       ░░██ ░██ ░██ ░██ ░██ ░██ ░██ ░ ░██  ░░              *
" *        ░░████  ░██ ░██ ░██ ░██ ░██   ░██   ██             *
" *         ░░██   ░██ ███ ░██ ░██░███   ░░█████              *
" *          ░░    ░░ ░░░  ░░  ░░ ░░░     ░░░░░               *
" *                                                           *
" * Author: Nicholas Hentschel                                *
" * Source: https://github.com/nickhentschel/dotfiles         *
" *                                                           *
" * WARNING: This file is modified frequently                 *
" *                                                           *
" * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

set shell=/bin/bash
filetype plugin indent on

" * * * * * * * * * * * * * * * * * * *
" * FUNCTIONS                         *
" * * * * * * * * * * * * * * * * * * *

" Functions for editing prose/markdown
function! ProseOn()
    Goyo 100
    wincmd w
    setlocal wrap
    setlocal spell
endfunction

function! ProseOff()
    Goyo!
    setlocal nowrap
    setlocal nospell
endfunction

command! ProseOn call ProseOn()
command! ProseOff call ProseOff()

" * * * * * * * * * * * * * * * * * * *
" * VIM SETTINGS                      *
" * * * * * * * * * * * * * * * * * * *

" Where to look for tag files
set tags=./tags;,~/.vimtags

set omnifunc=syntaxcomplete#Complete

" More natural splitting
set splitbelow
set splitright

set incsearch
set number

" Remove insert->normal delay
set ttimeoutlen=50

" Relaod files after change outside of VIM
set autoread

" Disable line wrap by default
set nowrap
set linebreak

" Title
set title

" This shows what you are typing as a command
set showcmd

" Who doesn't like autoindent?
set autoindent
set expandtab
set smarttab

" Who wants an 8 character tab?  Not me!
set shiftwidth=4
set softtabstop=4
set ts=4
set sts=4

" Use english for spellchecking, but don't spellcheck by default
set spl=en spell
set nospell

" Cool tab completion stuff
set wildmode=list:longest,full
set wildmenu

" Ignore while searching
set wildignore=*.o,*.obj,*~
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*DS_Store*
set wildignore+=vendor/rails/**
set wildignore+=vendor/cache/**
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=*.png,*.jpg,*.gif,*.pdf,*.psd
set wildignore+=*.log
set wildignore+=*.git,*.svn,*.hg,*.eyaml
set wildignore+=*/.git/*,*/tmp/*,*.swp
set wildignore+=*/.pyc*

" Enable mouse support in console
set mouse=a

" Ignoring case is a fun trick
set ignorecase
set smartcase

" Highlight things that we find with the search
set hlsearch

" buffers can exist in the background without being in a window.
set hidden

" Disable swap files
set noswapfile
set nobackup
set nowb

" Start scrolling when we're 8 lines away from margins
set scrolloff=8
set sidescrolloff=15
set sidescroll=1
set scrolljump=10

" Completion prefs
set complete=t,i,.
set completeopt=longest,menuone,preview

" Don't reset cursor to start of line when moving around
set nostartofline

" map leader to space
let mapleader=" "
let g:mapleader=" "

" Space does nothing in normal mode (prevent cursor from moving)
nnoremap <Space> <nop>

" Scroll viewport 3 lines instead of 1
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" Easier excape from insert
inoremap jk <Esc>

" map save to ctrl+s, requires some shell/terminal tweaking if not in gvim/macvim
inoremap <c-s> <Esc>:w<CR>
nnoremap <c-s> <Esc>:w<CR>
vnoremap <c-s> <Esc>:w<CR>

" allow multiple indentation/deindentation in visual mode
vnoremap < <gv
vnoremap > >gv
vnoremap = =gv

" Up and down are more logical with g
nnoremap <silent> k gk
nnoremap <silent> j gj

" Create Blank Newlines and stay in Normal mode
nnoremap <silent> zj o<Esc>
nnoremap <silent> zk O<Esc>

" Swap ; and :  Convenient.
nnoremap ; :
noremap : ;
vnoremap ; :
vnoremap : ;

" Tab navigation mappings
nnoremap gt :bnext<CR>
nnoremap gT :bprevious<CR>
nnoremap <C-c> :bdelete<CR>

" Make use of the arrow keys
nnoremap <left>  h
nnoremap <right> l
nnoremap <down>  j
nnoremap <up>    k

" w!! for writing read-only file
cmap w!! w !sudo tee % >/dev/null

" Map ctrl+a to ctrl+q to get around tmux bindings
nnoremap <C-q> <C-a>
vnoremap <C-q> <C-a>

" quickfix not listed in buffer lists
augroup qf
    autocmd!
    autocmd FileType qf set nobuflisted
    autocmd FileType qf nnoremap <silent><buffer> q :q<CR>
augroup END

augroup two_spaces
    autocmd!
    au Filetype html,css,scss,sass,ruby,javascript,yml,yaml,eruby,puppet,zsh,bash,sh,conf,nginx setlocal ts=2 sts=2 sw=2
augroup END

" Close help sections with q
augroup autocommand_mappings
    autocmd!
    au FileType help nnoremap <silent><buffer> q :q<CR>
augroup END

" * * * * * * * * * * * * * * * * * * *
" * BUNDLES AND SUCH                  *
" * * * * * * * * * * * * * * * * * * *

call plug#begin('~/.vim/plugged')

Plug 'tomtom/tcomment_vim'

" Allows easy addition/changing of surrounding text
Plug 'tpope/vim-surround'

" Display the indention levels with thin vertical lines
Plug 'Yggdroot/indentLine'

" Easy tag completion for xml-like languages
" Must sym-link xml.vim in ftplugin directory for completions
Plug 'sukima/xmledit',
            \ { 'do': 'rm ftplugin/html.vim && ln -s ftplugin/xml.vim ftplugin/html.vim' }

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin'  }
Plug 'junegunn/fzf.vim'

" Custom and configurable status line for vim
" Much lighter than powerline
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" wisely add 'end' in ruby, endfunction/endif/more in vim script, etc
Plug 'tpope/vim-endwise', { 'for': ['eruby', 'ruby'] }

" Tree-like sidebar file manager for vim
Plug 'scrooloose/nerdtree'

" vim git wrapper
Plug 'tpope/vim-fugitive'

" Syntax checking hacks for vim
Plug 'w0rp/ale'

" pairs of handy bracket mappings
Plug 'tpope/vim-unimpaired'

" matching braces and such
Plug 'jiangmiao/auto-pairs'

" Asynchronous grep plugin for Vim
Plug 'jremmen/vim-ripgrep'

" Plugins for prose writing
Plug 'junegunn/goyo.vim'

" Vim + tmux navigation
Plug 'christoomey/vim-tmux-navigator'

" incremental serach improvements
Plug 'haya14busa/incsearch.vim'

" Vim script for text filtering and alignment
Plug 'godlygeek/tabular'

" colorscheme bundles
Plug 'djjcast/mirodark'
Plug 'w0ng/vim-hybrid'
Plug 'andreasvc/vim-256noir'

" syntax and language related bundles
Plug 'sheerun/vim-polyglot'
Plug 'clones/vim-zsh', { 'for': ['zsh'] }
Plug 'rodjek/vim-puppet', { 'for': ['puppet'] }
Plug 'sclo/haproxy.vim', { 'for': ['haproxy'] }

call plug#end()

" * * * * * * * * * * * * * * * * * * *
" * PLUGIN SETTINGS AND MAPPINGS      *
" * * * * * * * * * * * * * * * * * * *

" Indentline
let g:indentLine_char = '│'

" Polyglot
let g:polyglot_disabled = ['puppet']

" NERDTree
nnoremap <leader>t :NERDTreeToggle<CR>
let NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1

" FZF
let g:fzf_buffers_jump = 1
let g:fzf_action = {
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit'
      \ }
let g:fzf_layout = { 'down': '~20%'  }

" To use ripgrep instead of ag:
command! -bang -nargs=* FZFRg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --glob "!.git/*" '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:30%')
  \           : fzf#vim#with_preview('right:20%:hidden', '?'),
  \   <bang>0)

nnoremap <c-p> :FZF<cr>
nnoremap <c-o> :Buffers<cr>
nnoremap <c-i> :FZFRg<cr>

if executable('rg')
    set grepprg=rg\ --vimgrep\ --color=never
endif

" Vim Airline
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_theme = 'luna'
let g:airline_detect_paste=1
let g:airline_powerline_fonts = 0
let g:airline#extensions#bufferline#overwrite_variables = 0
let g:airline#extensions#bufferline#enabled = 0
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#empty_message = ''
let g:airline#extensions#ctrlp#enabled = 1
let g:airline#extensions#ctrlp#show_adjacent_modes = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

" Tabular mappings
nnoremap <Leader>= :Tabularize /=<CR>
vnoremap <Leader>= :Tabularize /=<CR>
nnoremap <Leader>> :Tabularize /=><CR>
vnoremap <Leader>> :Tabularize /=><CR>

" * * * * * * * * * * * * * * * * * * *
" * LOOK AND FEEL                     *
" * * * * * * * * * * * * * * * * * * *

" Make tabs, trailing whitespace, and non-breaking spaces visible
set listchars=tab:→\ ,trail:·,extends:↷,precedes:↶,nbsp:×
set list

" fixes airline on vim
set laststatus=2
set synmaxcol=300

" disable sound on errors
set noeb vb t_vb=

" Line at 80 characters
set colorcolumn=80

" Theme
set t_Co=256
syntax enable
let g:mirodark_disable_color_approximation=1
colorscheme mirodark
set background=dark
