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

set shell=/bin/bash
syntax on

" Needed for enabling omnicomplete
filetype plugin on
filetype indent on

if executable('ag')
    " Use Ag over Grep
    set grepprg=ag\ --nogroup\ --nocolor\ --ignore=log/\*\ --ignore=tags
endif

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

" Performance increase in syntax highlighting
set regexpengine=1

" Where to look for tag files
set tags=./tags;,~/.vimtags

" More natural splitting
set splitbelow
set splitright

set incsearch

set number

" Remove insert->normal delay
set ttimeoutlen=50

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
" set complete=.,],b,u
" set completeopt=menuone,preview
set complete=t,i,.
set completeopt=longest,menuone,preview

" Don't reset cursor to start of line when moving around
set nostartofline

" map leader to space
let mapleader=" "
let g:mapleader=" "

" Ctrl + v already does this
nnoremap <C-q> <nop>

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

" Tab navigation mappings
nnoremap gt :bnext<CR>
nnoremap gT :bprevious<CR>
nnoremap <C-c> :Bdelete<CR>

" Make use of the arrow keys
nnoremap <left>  :5winc ><CR>
nnoremap <right> :5winc <<CR>
nnoremap <down>  :5winc -<CR>
nnoremap <up>    :5winc +<CR>

" search for word under cursor with Q
nnoremap Q :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" * * * * * * * * * * * * * * * * * * *
" * AUTO COMMANDS                     *
" * * * * * * * * * * * * * * * * * * *

augroup silverstripe_syntax
    autocmd!
    au BufNewFile,BufRead *.ss set filetype=html
augroup END

augroup web_syntax
    autocmd!
    au Filetype html,css,scss,sass,ruby,javascript,yml,yaml,eruby,puppet setlocal ts=2 sts=2 sw=2
    " autocmd FileType html,eruby set omnifunc=htmlcomplete#CompleteTags
augroup END

" Close help sections with q
augroup autocommand_mappings
    autocmd!
    au FileType help nnoremap <silent><buffer> q :q<CR>
augroup END

" Enable omni completion. (Ctrl-X Ctrl-O)
" autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
" autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
" autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
" autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
" autocmd FileType css set omnifunc=csscomplete#CompleteCSS
" autocmd FileType c set omnifunc=ccomplete#Complete
" autocmd FileType java set omnifunc=javacomplete#Complete

" autocmd FileType ruby compiler ruby
" autocmd FileType eruby compiler eruby
" autocmd FileType ruby set omnifunc=rubycomplete#Complete
" autocmd FileType ruby let g:rubycomplete_buffer_loading=1
" autocmd FileType ruby let g:rubycomplete_classes_in_global=1

" use syntax complete if nothing else available
if has("autocmd") && exists("+omnifunc")
    autocmd Filetype *
                \ if &omnifunc == "" |
                \     setlocal omnifunc=syntaxcomplete#Complete |
                \ endif
endif

" Disable seach highlighting in insert mode, re-enable in normal mode
autocmd InsertEnter * :setlocal nohlsearch
autocmd InsertLeave * :setlocal hlsearch

" * * * * * * * * * * * * * * * * * * *
" * BUNDLES AND SUCH                  *
" * * * * * * * * * * * * * * * * * * *

call plug#begin('~/.vim/plugged')

" Delete buffers and close files in Vim without closing your windows or messing
" up your layout
Plug 'moll/vim-bbye'

" Allows easy code commenting of lines and blocks
Plug 'tomtom/tcomment_vim'

" Allows easy addition/changing of surrounding text
Plug 'tpope/vim-surround'

" Display the indention levels with thin vertical lines
Plug 'Yggdroot/indentLine'

" Easy tag completion for xml-like languages
" Must sym-link xml.vim in ftplugin directory for completions
Plug 'sukima/xmledit',
            \ { 'do': 'rm ftplugin/html.vim && ln -s ftplugin/xml.vim ftplugin/html.vim' }

" Fuzzy file, buffer, mru, tag, etc finder
" Similar to cmd + p for SublimeText
Plug 'kien/ctrlp.vim'
Plug 'sgur/ctrlp-extensions.vim'

" Custom and configurable status line for vim
" Much lighter than powerline
Plug 'bling/vim-airline'

" Allows ctrl h,j,k,l to navigate tmux panes and vim splits
Plug 'christoomey/vim-tmux-navigator'

" wisely add 'end' in ruby, endfunction/endif/more in vim script, etc
Plug 'tpope/vim-endwise', { 'for': ['eruby', 'ruby'] }

" Tree-like sidebar file manager for vim
Plug 'scrooloose/nerdtree'

" vim git wrapper
Plug 'tpope/vim-fugitive'

" Syntax checking hacks for vim
Plug 'scrooloose/syntastic'

" speeddating.vim: use CTRL-A/CTRL-X to increment dates, times, and more
Plug 'tpope/vim-speeddating'

" pairs of handy bracket mappings
Plug 'tpope/vim-unimpaired'

" Vim plugin for the_silver_searcher, 'ag', a replacement for the Perl module /
" CLI script 'ack'
Plug 'rking/ag.vim'

" Faster matcher for CtrlP
Plug 'FelikZ/ctrlp-py-matcher'

" colorscheme bundles
Plug 'djjcast/mirodark'
Plug 'w0ng/vim-hybrid'
Plug 'altercation/vim-colors-solarized'
Plug 'freeo/vim-kalisi'
Plug 'sickill/vim-monokai'
Plug 'chriskempson/vim-tomorrow-theme'

" syntax and language related bundles
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rails'
Plug 'othree/html5.vim'
Plug 'othree/yajs.vim'
Plug 'elzr/vim-json'
Plug 'tpope/vim-markdown'
Plug 'clones/vim-zsh'
Plug 'puppetlabs/puppet-syntax-vim'
Plug 'evanmiller/nginx-vim-syntax'

" Plugins for prose writing
Plug 'junegunn/goyo.vim'

" Vim + tmux navigation
Plug 'christoomey/vim-tmux-navigator'

call plug#end()

" * * * * * * * * * * * * * * * * * * *
" * PLUGIN SETTINGS AND MAPPINGS      *
" * * * * * * * * * * * * * * * * * * *

" NERDTree
nnoremap <leader>t :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

" ctrlp
let g:ctrlp_show_hidden = 1
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_working_path_mode = 2
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:10,results:10'
let g:ctrlp_switch_buffer = 'Et'
" let g:ctrlp_lazy_update = 350
" Open new files in current window
let g:ctrlp_open_new_file = 'r'
let g:ctrlp_extensions = ['tag', 'buffertag', 'dir', 'undo', 'line']
let g:ctrlp_use_caching = 1

if executable('ag')
    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
                \ --ignore .git
                \ --ignore .svn
                \ --ignore .hg
                \ --ignore .DS_Store
                \ --ignore "**/*.pyc"
                \ -g ""'
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

if !has('python')
    echo 'In order to use pymatcher plugin, you need +python compiled vim'
else
    let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
endif

" Vim Airline
" Uncomment below if not using a font with powerline symbols
" let g:airline_left_sep = ''
" let g:airline_right_sep = ''
" let g:airline_theme = "base16"
let g:airline_detect_paste=1
let g:airline_powerline_fonts = 1
let g:airline#extensions#bufferline#overwrite_variables = 0
let g:airline#extensions#bufferline#enabled = 0
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#empty_message = ''
let g:airline#extensions#ctrlp#enabled = 1
let g:airline#extensions#ctrlp#show_adjacent_modes = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

" Syntastic
let g:syntastic_ruby_checkers = ['ruby-lint', 'rubocop']
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_aggregate_errors = 1
let g:syntastic_check_on_open = 1
let g:syntastic_error_symbol = "✗"
let g:syntastic_warning_symbol = "⚠"
let g:syntastic_enable_signs = 0
let g:syntastic_echo_current_error = 0

" * * * * * * * * * * * * * * * * * * *
" * LOOK AND FEEL                     *
" * * * * * * * * * * * * * * * * * * *

" Make tabs, trailing whitespace, and non-breaking spaces visible
set listchars=tab:→\ ,trail:·,extends:↷,precedes:↶,nbsp:×
set list

" highlight past 80 characters
" execute "set colorcolumn=" . join(range(81,335), ',')

" set cursorline

" Cursor shows matching ) and }
set showmatch

set laststatus=2
set encoding=utf-8
set synmaxcol=300

" Set off the other paren
highlight MatchParen ctermbg=4

" disable sound on errors
set noeb vb t_vb=

if has("gui_running")
    " Remove scrollbars
    set guioptions-=r
    set guioptions-=L
    set guifont=PragmataPro\ for\ Powerline:h12
    colorscheme Tomorrow-Night
endif

set background=dark
colorscheme solarized
