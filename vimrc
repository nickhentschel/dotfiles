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
filetype plugin indent on
set t_Co=256

set shell=/bin/bash

" * * * * * * * * * * * * * * * * * * *
" * FUNCTIONS                         *
" * * * * * * * * * * * * * * * * * * *

function! s:editProse()
    setlocal colorcolumn&
    setlocal spell
    setlocal nonumber
    setlocal guicursor+=a:blinkon0
    setlocal foldcolumn=12
    setlocal textwidth=80
endfunction

function! Multiple_cursors_before()
    exe 'NeoCompleteLock'
    echo 'Disabled autocomplete'
endfunction

function! Multiple_cursors_after()
    exe 'NeoCompleteUnlock'
    echo 'Enabled autocomplete'
endfunction

" * * * * * * * * * * * * * * * * * * *
" * AUTO COMMANDS                     *
" * * * * * * * * * * * * * * * * * * *

" Enable omnicomplete
autocmd FileType javascript     setlocal omnifunc=tern#Complete
autocmd FileType coffee         setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html,markdown  setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType css            setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType xml            setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType php            setlocal omnifunc=phpcomplete#CompletePHP
autocmd FileType c              setlocal omnifunc=ccomplete#Complete
autocmd FileType ruby           setlocal omnifunc=rubycomplete#Complete

" cd to current directory automatically
au BufEnter * silent! lcd %:p:h

" Syntax specific stuff
au BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn} set filetype=markdown
au BufNewFile,BufRead *.ss set filetype=html
au Filetype html,css,scss,sass,ruby,javascript setlocal ts=2 sts=2 sw=2

augroup pencil
    autocmd!
    autocmd FileType markdown,text call s:editProse()|call pencil#init()|NeoCompleteLock
augroup END

" * * * * * * * * * * * * * * * * * * *
" * VIM SETTINGS                      *
" * * * * * * * * * * * * * * * * * * *

set ofu=syntaxcomplete#Complete

" set 'hybrid' line number
set relativenumber
" set number

" Settings for ctags
set tags=tags;/

" Better screen redraw
set ttyfast
set lazyredraw

" More natural splitting
set splitbelow
set splitright

" Remove insert->normal delay
set ttimeoutlen=50

" disable sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" encoding dectection
set fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1

" Get rid of the delay when hitting esc!
set noesckeys

" extend the history length
set history=1000

" Relaod files after change outside of VIM
set autoread

" Disable line wrap by default
set nowrap
set linebreak

" Title
set title

" This shows what you are typing as a command
set showcmd

" Folding Stuffs
set foldmethod=syntax
set foldlevelstart=99

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

" Enable backspace in visual mode
set backspace=indent,eol,start

" Ignoring case is a fun trick
set ignorecase

" And so is Artificial Intellegence!
set smartcase

" Incremental searching is sexy
set incsearch

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

" set autocompletion when CTRL-P or CTRL-N are used.
" It is also used for whole-line
" . ... scan the current buffer
" b ... scan other loaded buffers that are in the buffer list
" w ... buffers from other windows
" u ... scan unloaded buffers that are in the buffer list
" U ... scan buffers that are not in the buffer list
" ] ... tag completion
" i ... scan current and included files
" set complete=i,.,b,w,u,U,]

" * * * * * * * * * * * * * * * * * * *
" * MAPPINGS                          *
" * * * * * * * * * * * * * * * * * * *

" Toggle paste mode with F2
set pastetoggle=<F2>

" map leader to space
let mapleader=" "
let g:mapleader=" "

" Space does nothing in normal mode (prevent cursor from moving)
nnoremap <Space> <nop>

" Set leader n to stop highlighting
nnoremap <leader>n :<C-u>noh<CR>

" save as root
cmap w!! w !sudo tee % >/dev/null<CR>:e!<CR><CR>

" Remap to yank to end of line
nnoremap Y y$

" Easy redo
nnoremap U <c-r>

" Call hlnext function on N or n
" nnoremap <silent> n n:call HLNext(0.4)<cr>
" nnoremap <silent> N N:call HLNext(0.4)<cr>

" Scroll viewport 3 lines instead of 1
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" Easier excape from insert
inoremap jk <Esc>

" Sane regex with /
nnoremap / /\v
vnoremap / /\v
nnoremap ? ?\v
vnoremap ? ?\v
cnoremap s/ s/\v

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
" * BUNDLES AND SUCH                  *
" * * * * * * * * * * * * * * * * * * *

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

Bundle 'tomtom/tcomment_vim'
Bundle 'tpope/vim-surround'
Bundle 'scrooloose/syntastic'
Bundle 'Shougo/neocomplete.vim'
Bundle 'bling/vim-airline'
Bundle 'tpope/vim-fugitive'
Bundle 'LaTeX-Box-Team/LaTeX-Box'
Bundle 'marijnh/tern_for_vim'
Bundle 'vim-ruby/vim-ruby'
" Bundle 'klen/python-mode'
Bundle 'reedes/vim-pencil'
Bundle 'reedes/vim-thematic'
Bundle 'Raimondi/delimitMate'
Bundle 'kien/ctrlp.vim'
Bundle 'sgur/ctrlp-extensions.vim'
Bundle 'FelikZ/ctrlp-py-matcher'
Bundle 'fholgado/minibufexpl.vim'
Bundle 'mhinz/vim-startify'
Bundle 'valloric/MatchTagAlways'
Bundle 'kris89/vim-multiple-cursors'
Bundle 'osyo-manga/vim-over'
Bundle 'christoomey/vim-tmux-navigator'
Bundle 'tpope/vim-endwise'
Bundle 'craigemery/vim-autotag'

" Must sym-link xml.vim in ftplugin directory for completions
Bundle 'sukima/xmledit'

" colorscheme bundles
Bundle 'djjcast/mirodark'
Bundle 'chriskempson/base16-vim'
Bundle 'w0ng/vim-hybrid'
Bundle 'reedes/vim-colors-pencil'
Bundle 'altercation/vim-colors-solarized'
Bundle 'chriskempson/tomorrow-theme', {'rtp': 'vim/'}
Bundle 'morhetz/gruvbox'

" syntax related bundles
Bundle 'concise/vim-html5-fix'
Bundle 'nono/vim-handlebars'
Bundle 'elzr/vim-json'
Bundle 'jelera/vim-javascript-syntax'
Bundle 'tpope/vim-markdown'
Bundle 'chase/vim-ansible-yaml'
Bundle 'evanmiller/nginx-vim-syntax'
Bundle 'cakebaker/scss-syntax.vim'
Bundle 'Keithbsmiley/tmux.vim'

" * * * * * * * * * * * * * * * * * * *
" * PLUGIN SETTINGS AND MAPPINGS      *
" * * * * * * * * * * * * * * * * * * *

" VIM Notes
let g:notes_directories = ['~/Dropbox/notes']

" Markdown
let g:markdown_fenced_languages = ['css', 'erb=eruby', 'javascript',
    \ 'js=javascript', 'json=javascript', 'ruby', 'sass', 'xml', 'sql']

" DelimitMate
let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 0
" don't match <>, save that for separate tag closing plugin
let g:delimitMate_matchpairs = "(:),[:],{:}"

" ctrlp
let g:ctrlp_custom_ignore='\.git$\|\.hg$\|\.svn$'
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_match_window = 'bottom,order:btt,min:1,max:10,results:10'
let g:ctrlp_switch_buffer = 'Et'
let g:ctrlp_use_caching = 1
let g:ctrlp_show_hidden = 1
" Open new files in current window
let g:ctrlp_open_new_file = 'r'
let g:ctrlp_extensions = ['tag', 'buffertag', 'dir',
                      \ 'undo', 'line', 'yankring']
if !has('python')
    echo 'In order to use pymatcher plugin, you need +python compiled vim'
else
    let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
endif
let g:ctrlp_lazy_update = 350
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_max_files = 5000
if executable("ag")
    set grepprg=ag\ --nogroup\ --nocolor
    let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --ignore ''.git'' --ignore ''.svn'' --ignore ''.DS_Store'' --ignore ''node_modules'' --hidden -g ""'
endif

" ctrlp mappings
nnoremap <leader>i :<C-u>CtrlPLine<CR>
nnoremap <leader>p :<C-u>CtrlP<CR>
nnoremap <leader>o :<C-u>CtrlPBuffer<CR>
nnoremap <leader>y :<C-u>CtrlPYankring<CR>

" Pencil
let g:pencil#wrapModeDefault = 'hard'
let g:pencil#textwidth = 80
let g:pencil#autoformat = 1

" Pencil mappings
nnoremap <silent> <leader>ps :SoftPencil<cr>
nnoremap <silent> <leader>ph :HardPencil<cr>
nnoremap <silent> <leader>pt :TogglePencil<cr>
nnoremap <silent> <leader>pp :ShiftPencil<cr>

" NeoComplete
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#max_list = 15
let g:neocomplete#enable_refresh_always = 1
let g:neocomplete#sources#buffer#cache_limit_size = 10000
let g:neocomplete#data_directory = $HOME.'/.vim/cache/noecompl'
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#enable_auto_select = 0
let g:neocomplete#sources#syntax#min_keyword_length = 1
" let g:neocomplete#force_omni_input_patterns.javascript = '[^. \t]\.\w*'

" NeoComplete mappings
inoremap <expr><Space> pumvisible() ? neocomplete#smart_close_popup().
                       \ "\<Space>" : "\<Space>"
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

" Tern.js
let g:tern_map_keys=1
let g:tern_show_argument_hints='on_hold'

" LatexBox
let g:LatexBox_latexmk_options='-xelatex'
let g:LatexBox_latexmk_preview_continuously=1

" Syntastic settings
let g:syntastic_mode_map = { 'mode': 'active',
    \ 'active_filetypes': [],
    \ 'passive_filetypes': ['html'] }
let g:syntastic_check_on_open = 1
let g:syntastic_echo_current_error = 0
let g:syntastic_aggregate_errors = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_javascript_checkers = ['jsl']
let g:syntastic_html_checkers = ['tidy']
let g:syntastic_php_checkers=['php', 'phpcs']
let g:syntastic_ruby_checkers=['mri']
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" Syntastic mappings
nnoremap <Leader>e <Esc>:Errors<CR>

" Vim Airline
let g:airline_theme = "powerlineish"
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
" execute "set colorcolumn=" . join(range(81,335), ',')

set background=dark
" colorscheme base16-railscasts
colorscheme hybrid

" Cursor shows matching ) and }
set showmatch
set laststatus=2
set encoding=utf-8

" Set off the other paren
highlight MatchParen ctermbg=4

" disable sound on errors
set noerrorbells visualbell t_vb=
set tm=500

" highlight current line and column
" set cursorline

syntax on
