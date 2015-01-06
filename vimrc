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

" Performance increase in syntax highlighting
set regexpengine=1

" Set fold method
set foldmethod=manual

" More natural splitting
set splitbelow
set splitright

set incsearch

set number

" Better screen redraw
set ttyfast
" set lazyredraw
set ttyscroll=1

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
" set sidescrolloff=15
" set sidescroll=1
" set scrolljump=10

" Completion in command mode
if v:version >= 700
    set completeopt=menuone,menu
endif

" map leader to space
let mapleader=" "
let g:mapleader=" "

" Remap ex mode cause it sucks
nnoremap Q <nop>

" Ctrl + v already does this
nnoremap <C-q> <nop>

" Space does nothing in normal mode (prevent cursor from moving)
nnoremap <Space> <nop>

" Set leader n to stop highlighting
nnoremap <leader>n :<C-u>noh<CR>

" Scroll viewport 3 lines instead of 1
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" Easier excape from insert
inoremap jk <Esc>
inoremap jj <Esc>

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
nnoremap : ;

" Split navigation mappings
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nnoremap gt :MBEbn<CR>
nnoremap gT :MBEbp<CR>
nnoremap <C-c> :MBEbd<CR>
" nnoremap <C-c> :bp\|bd #<CR>
" nnoremap <C-c> :bp\|bd #<CR>

" search for word under cursor with K
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" * * * * * * * * * * * * * * * * * * *
" * AUTO COMMANDS                     *
" * * * * * * * * * * * * * * * * * * *

augroup nerd_tree
    autocmd!
    autocmd VimEnter * NERDTree
    " autocmd BufEnter * NERDTreeMirror
    autocmd VimEnter * wincmd w
augroup END

" Syntax specific stuff

augroup markdown_syntax
    autocmd!
    autocmd BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn} set filetype=markdown
augroup END

augroup silverstripe_syntax
    autocmd!
    au BufNewFile,BufRead *.ss set filetype=html
augroup END

augroup web_syntax
    autocmd!
    au Filetype html,css,scss,sass,ruby,javascript,yml,yaml,eruby setlocal ts=2 sts=2 sw=2
augroup END

augroup autocommand_mappings
    autocmd!
    au FileType help nnoremap <silent><buffer> q :q<CR>
    autocmd! GUIEnter * set vb t_vb=
augroup END


" * * * * * * * * * * * * * * * * * * *
" * BUNDLES AND SUCH                  *
" * * * * * * * * * * * * * * * * * * *

filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#begin()

" let Vundle manage Vundle
" required!
Plugin 'gmarik/vundle'

" Allows easy code commenting of lines and blocks
Plugin 'tomtom/tcomment_vim'
"
" Allows easy addition/changing of surrounding text
Plugin 'tpope/vim-surround'

" Provides insert mode auto-completion for quotes, parens, brackets, etc.
Plugin 'Raimondi/delimitMate'

" Always highlight the enclosing html/xml tags
Plugin 'valloric/MatchTagAlways'

" True Sublime Text style multiple selections for Vim
Plugin 'kris89/vim-multiple-cursors'

" Display the indention levels with thin vertical lines
Plugin 'Yggdroot/indentLine'

" Easy tag completion for xml-like languages
" Must sym-link xml.vim in ftplugin directory for completions
Plugin 'sukima/xmledit'

" Fuzzy file, buffer, mru, tag, etc finder
" Similar to cmd + p for SublimeText
Plugin 'kien/ctrlp.vim'
Plugin 'sgur/ctrlp-extensions.vim'

" Custom and configurable status line for vim
" Much lighter than powerline
Plugin 'bling/vim-airline'

" Display open buffers pinned to top of window
Plugin 'fholgado/minibufexpl.vim'

" Allows ctrl h,j,k,l to navigate tmux panes and vim splits
Plugin 'christoomey/vim-tmux-navigator'

" wisely add 'end' in ruby, endfunction/endif/more in vim script, etc
Plugin 'tpope/vim-endwise'

" Tree-like sidebar file manager for vim
Plugin 'scrooloose/nerdtree'
"
" Plugin that displays tags in a window, ordered by scope
Plugin 'majutsushi/tagbar'

" A code-completion engine for Vim http://valloric.github.io/YouCompleteMe/
Plugin 'Valloric/YouCompleteMe'

" Javascript code completion stuff
Plugin 'marijnh/tern_for_vim'

" Dep for easytags
Plugin 'xolox/vim-misc'

" Automated tag file generation and syntax highlighting of tags in Vim
Plugin 'xolox/vim-easytags'

" Syntax checking hacks for vim
Plugin 'scrooloose/syntastic'

" speeddating.vim: use CTRL-A/CTRL-X to increment dates, times, and more
Plugin 'tpope/vim-speeddating'

" pairs of handy bracket mappings
Plugin 'tpope/vim-unimpaired'

" Vim plugin for the_silver_searcher, 'ag', a replacement for the Perl module / CLI script 'ack'
Plugin 'rking/ag.vim'

" colorscheme bundles
Plugin 'djjcast/mirodark'
Plugin 'chriskempson/base16-vim'
Plugin 'w0ng/vim-hybrid'
Plugin 'tomasr/molokai'
Plugin 'altercation/vim-colors-solarized'

" syntax and language related bundles
Plugin 'vim-ruby/vim-ruby'
Plugin 'ngmy/vim-rubocop'
Plugin 'tpope/vim-rails'
Plugin 'othree/html5.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'nono/vim-handlebars'
Plugin 'elzr/vim-json'
Plugin 'tpope/vim-markdown'
Plugin 'chase/vim-ansible-yaml'
Plugin 'evanmiller/nginx-vim-syntax'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'Keithbsmiley/tmux.vim'
Plugin 'dag/vim-fish'

call vundle#end()
filetype plugin indent on

" * * * * * * * * * * * * * * * * * * *
" * PLUGIN SETTINGS AND MAPPINGS      *
" * * * * * * * * * * * * * * * * * * *

" Easytags
let g:eastags_async=1

" Tagbar
nnoremap <silent> <F3> :TagbarToggle<CR>

" Numbertoggle
let g:NumberToggleTrigger="<F2>"

" NERDTree
nnoremap <leader>t :NERDTreeToggle<CR>
let NERDTreeShowHidden=1

" DelimitMate
let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 0
" don't match <>, save that for separate tag closing plugin
let g:delimitMate_matchpairs = "(:),[:],{:}"

" ctrlp
let g:ctrlp_show_hidden = 1
let g:ctrlp_cmd = 'CtrlP'
" let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_working_path_mode = 2
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:10,results:10'
let g:ctrlp_switch_buffer = 'Et'
let g:ctrlp_show_hidden = 1
" Open new files in current window
let g:ctrlp_open_new_file = 'r'
let g:ctrlp_extensions = ['tag', 'buffertag', 'dir', 'undo', 'line']
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

" Vim Airline
" Uncomment below if not using a font with powerline symbols
" let g:airline_left_sep = ''
" let g:airline_right_sep = ''
" let g:airline_theme = "luna"
let g:airline_powerline_fonts = 1
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

" Syntastic
let g:syntastic_ruby_checkers = ['ruby-lint', 'rubocop']
let g:syntastic_javascript_ruby_checkers = ['jslint']
let g:syntastic_aggregate_errors = 1
let g:syntastic_check_on_open = 1
let g:syntastic_error_symbol = "✗"
let g:syntastic_warning_symbol = "⚠"

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
" execute "set colorcolumn=" . join(range(81,335), ',')

set background=dark
colorscheme solarized
" let g:molokai_original = 1

if has("gui_macvim")
    " set noantialias
    " set guifont=Envy\ Code\ R\ for\ Powerline:h12
    " set guifont=Terminus\ (TTF):h12
    " set guifont=PragmataPro\ for\ Powerline:h12
    set guifont=Meslo\ LG\ L\ DZ\ Regular\ for\ Powerline:h10
endif

" set cursorline

" Cursor shows matching ) and }
set showmatch

set laststatus=2
set encoding=utf-8
set synmaxcol=1000

" Set off the other paren
highlight MatchParen ctermbg=4

" disable sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

syntax on
