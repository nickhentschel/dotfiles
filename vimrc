" * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
" *          ___      ___ ___  _____ ______   ________  ________              *
" *         |\  \    /  /|\  \|\   _ \  _   \|\   __  \|\   ____\             *
" *         \ \  \  /  / | \  \ \  \\\__\ \  \ \  \|\  \ \  \___|             *
" *          \ \  \/  / / \ \  \ \  \\|__| \  \ \   _  _\ \  \                *
" *         __\ \    / /   \ \  \ \  \    \ \  \ \  \\  \\ \  \____           *
" *        |\__\ \__/ /     \ \__\ \__\    \ \__\ \__\\ _\\ \_______\         *
" *        \|__|\|__|/       \|__|\|__|     \|__|\|__|\|__|\|_______|         *
" *                                                                           *
" *                                                                           *
" * Author: Nicholas Hentschel                                                *
" * Source: https://github.com/nickhentschel/dotfiles                         *
" *                                                                           *
" * WARNING: This file is modified frequently                                 *
" *                                                                           *
" * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

" Necesary  for lots of cool vim things
set nocompatible
set shell=/bin/bash

if executable('ag')
    " Use Ag over Grep
    set grepprg=ag\ --nogroup\ --nocolor
endif

" * * * * * * * * * * * * * * * * * * *
" * VIM SETTINGS                      *
" * * * * * * * * * * * * * * * * * * *

set number

" Better screen redraw
set ttyfast
set lazyredraw

" Remove insert->normal delay
set ttimeoutlen=50

" encoding dectection
set fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1

" Get rid of the delay when hitting esc!
set noesckeys

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
set wildmenu
set wildmode=list:longest,full

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
set wildignore+=*.png,*.jpg,*.gif

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

" Completion in command mode
if v:version >= 700
    set completeopt=menuone,menu
endif

" map leader to space
let mapleader=" "
let g:mapleader=" "

" Space does nothing in normal mode (prevent cursor from moving)
nnoremap <Space> <nop>

" Set leader n to stop highlighting
nnoremap <leader>n :<C-u>noh<CR>

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

" Up and down are more logical with g..
nnoremap <silent> k gk
nnoremap <silent> j gj

" Create Blank Newlines and stay in Normal mode
nnoremap <silent> zj o<Esc>
nnoremap <silent> zk O<Esc>

" Swap ; and :  Convenient.
nnoremap ; :
nnoremap : ;

" Split navigation mappings
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nnoremap gt :bn<CR>
nnoremap gT :bp<CR>
nnoremap <C-c> :bp\|bd #<CR>

" * * * * * * * * * * * * * * * * * * *
" * AUTO COMMANDS                     *
" * * * * * * * * * * * * * * * * * * *

autocmd VimEnter * NERDTree
autocmd BufEnter * NERDTreeMirror

autocmd VimEnter * wincmd w

" Enable omnicomplete
autocmd FileType * if exists("+omnifunc") && &omnifunc == "" | setlocal omnifunc=syntaxcomplete#Complete | endif
autocmd FileType * if exists("+completefunc") && &completefunc == "" | setlocal completefunc=syntaxcomplete#Complete | endif

" Syntax specific stuff
au BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn} set filetype=markdown
au BufNewFile,BufRead *.ss set filetype=html
au Filetype html,css,scss,sass,ruby,javascript,yml,yaml setlocal ts=2 sts=2 sw=2
au FileType help nnoremap <silent><buffer> q :q<CR>

" * * * * * * * * * * * * * * * * * * *
" * BUNDLES AND SUCH                  *
" * * * * * * * * * * * * * * * * * * *

filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#begin()

" let Vundle manage Vundle
" required!
Plugin 'gmarik/vundle'

Plugin 'tomtom/tcomment_vim'
Plugin 'kien/ctrlp.vim'
Plugin 'sgur/ctrlp-extensions.vim'
Plugin 'tpope/vim-surround'
Plugin 'bling/vim-airline'
Plugin 'Raimondi/delimitMate'
Plugin 'fholgado/minibufexpl.vim'
Plugin 'valloric/MatchTagAlways'
Plugin 'kris89/vim-multiple-cursors'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'tpope/vim-endwise'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-rails'
Plugin 'scrooloose/nerdtree'
Plugin 'Shougo/neocomplete.vim'

" Must sym-link xml.vim in ftplugin directory for completions
Bundle 'sukima/xmledit'

" colorscheme bundles
Bundle 'djjcast/mirodark'
Bundle 'chriskempson/base16-vim'
Bundle 'w0ng/vim-hybrid'

" syntax related bundles
Bundle 'othree/html5.vim'
Bundle 'pangloss/vim-javascript'
Bundle 'nono/vim-handlebars'
Bundle 'elzr/vim-json'
Bundle 'tpope/vim-markdown'
Bundle 'chase/vim-ansible-yaml'
Bundle 'evanmiller/nginx-vim-syntax'
Bundle 'cakebaker/scss-syntax.vim'
Bundle 'Keithbsmiley/tmux.vim'

call vundle#end()
filetype plugin indent on

" * * * * * * * * * * * * * * * * * * *
" * PLUGIN SETTINGS AND MAPPINGS      *
" * * * * * * * * * * * * * * * * * * *

" NERDTree
nnoremap <leader>t :NERDTreeToggle<CR>

" DelimitMate
let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 0
" don't match <>, save that for separate tag closing plugin
let g:delimitMate_matchpairs = "(:),[:],{:}"

" ctrlp
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:10,results:10'
let g:ctrlp_switch_buffer = 'Et'
let g:ctrlp_show_hidden = 1
" Open new files in current window
let g:ctrlp_open_new_file = 'r'
let g:ctrlp_extensions = ['tag', 'buffertag', 'dir',
            \ 'undo', 'line', 'yankring']
if executable('ag')
    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

    " ag is fast enough that CtrlP doesn't need to cache
    let g:ctrlp_use_caching = 0
else
    let g:ctrlp_custom_ignore = {
                \ 'dir': '\v[\/](\.git|\.hg|\.svn|CVS|tmp|Library|Applications|Music|[^\/]*-store)$',
                \ 'file': '\v\.(exe|so|dll)$',
                \ }
    let g:ctrlp_user_command = {
                \ 'types' : {
                \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
                \ 2: ['.hg', 'hg --cwd %s locate -I .'],
                \ }
                \ }
endif

" ctrlp mappings
nnoremap <leader>i :<C-u>CtrlPLine<CR>
nnoremap <leader>p :<C-u>CtrlP<CR>
nnoremap <leader>o :<C-u>CtrlPBuffer<CR>
nnoremap <leader>y :<C-u>CtrlPYankring<CR>

" NeoComplete
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#force_overwrite_completefunc = 1
let g:neocomplete#data_directory = $HOME.'/.vim/cache/noecompl'
let g:neocomplete#auto_completion_start_length = 1
let g:neocomplete#manual_completion_start_length = 0
let g:neocomplete#enable_auto_close_preview = 1
let g:neocomplete#max_list = 15
let g:neocomplete#enable_refresh_always = 1
let g:neocomplete#enable_smart_case = 1

let g:neocomplete#keyword_patterns = {}
let g:neocomplete#keyword_patterns._  = '\h\w*'

" let g:neocomplete#sources#omni#input_patterns = {}
" let g:neocomplete#sources#omni#input_patterns.php  = '[^. \t]->\h\w*\|\h\w*::'

" let g:neocomplete#force_omni_input_patterns = {}
" let g:neocomplete#force_omni_input_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::\w*'

" let g:neocomplete#same_filetypes = {}
" let g:neocomplete#same_filetypes.gitconfig = '_'
" let g:neocomplete#same_filetypes._ = '_'

let g:neocomplete#enable_auto_select = 0
let g:neocomplete#sources#syntax#min_keyword_length = 1
" let g:neocomplete#force_omni_input_patterns.javascript = '[^. \t]\.\w*'

" NeoComplete mappings
inoremap <expr><Space> pumvisible() ? neocomplete#smart_close_popup().
            \ "\<Space>" : "\<Space>"
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Vim Airline
" let g:airline_theme = "powerlineish"
let g:airline_powerline_fonts = 1
" let g:airline_left_sep = ''
" let g:airline_right_sep = ''
let g:airline#extensions#bufferline#overwrite_variables = 0
let g:airline#extensions#bufferline#enabled = 0
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#ctrlp#enabled = 1
let g:airline#extensions#ctrlp#show_adjacent_modes = 1

" Minibuff Explorer
let g:miniBufExplAutoStart = 1
let g:miniBufExplorerMoreThanOne = 0
let g:miniBufExplCycleArround = 1
let g:miniBufExplBRSplit = 0

" * * * * * * * * * * * * * * * * * * *
" * LOOK AND FEEL                     *
" * * * * * * * * * * * * * * * * * * *

" Remove scrollbars
set guioptions-=r
set guioptions-=L

" Make tabs, trailing whitespace, and non-breaking spaces visible
set listchars=tab:→\ ,trail:·,extends:↷,precedes:↶
set list

" highlight past 80 characters
execute "set colorcolumn=" . join(range(81,335), ',')

set background=dark
colorscheme hybrid
set guifont=Terminus\ (TTF):h12
set noantialias

" Cursor shows matching ) and }
set showmatch
set laststatus=2
set encoding=utf-8

" Set off the other paren
highlight MatchParen ctermbg=4

" disable sound on errors
autocmd! GUIEnter * set vb t_vb=
set noerrorbells
set novisualbell
set t_vb=
set tm=500

syntax on
