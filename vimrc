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
" * Source: https://github.com/nickhentschel/dotfiles-2                       *
" *                                                                           *
" * WARNING: This file is modified frequently                                 *
" *                                                                           *
" * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

" Necesary  for lots of cool vim things
set nocompatible
filetype plugin indent on

set shell=/bin/bash

" * * * * * * * * * * * * * * * * * * *
" * FUNCTIONS                         *
" * * * * * * * * * * * * * * * * * * *

function! HLNext (blinktime)
    set invcursorline
    redraw
    exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
    set invcursorline
    redraw
endfunction

function! s:my_cr_function()
    return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction

function! s:editProse()
    setlocal colorcolumn&
    setlocal spell
    setlocal nonumber
    setlocal guicursor+=a:blinkon0
    setlocal foldcolumn=12
    setlocal textwidth=80
endfunction

" * * * * * * * * * * * * * * * * * * *
" * AUTO COMMANDS                     *
" * * * * * * * * * * * * * * * * * * *

au BufNewFile,BufRead *.ss set filetype=html

" Toggle relative line numbers in different modes
" autocmd InsertEnter * set number

" cd to current directory automatically
autocmd BufEnter * silent! lcd %:p:h

" Enable omni completion
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
autocmd FileType java setlocal omnifunc=javacomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Syntax specific stuff
au BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn} set filetype=markdown
au Filetype html,css,scss,sass,ruby setlocal ts=2 sts=2 sw=2
au Filetype javascript setlocal ts=4 sts=4 sw=4

augroup pencil
    autocmd!
    autocmd FileType markdown,text call s:editProse()|call pencil#init()|NeoCompleteLock
augroup END

" * * * * * * * * * * * * * * * * * * *
" * VIM SETTINGS                      *
" * * * * * * * * * * * * * * * * * * *

" set relative line numbers
set relativenumber

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

" This shows what you are typing as a command.  I love this!
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
  " set completeopt=menuone,menu,longest
  set completeopt=menuone,menu
endif

" * * * * * * * * * * * * * * * * * * *
" * MAPPINGS                          *
" * * * * * * * * * * * * * * * * * * *

" map leader to space
let mapleader=" "
let g:mapleader=" "

" save as root
cmap w!! w !sudo tee % >/dev/null<CR>:e!<CR><CR>

" Just stop with the arrow keys ok?
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Remap to yank to end of line
nnoremap Y y$

" Easy redo
nnoremap U <c-r>

" Call hlnext function on N or n
nnoremap <silent> n n:call HLNext(0.4)<cr>
nnoremap <silent> N N:call HLNext(0.4)<cr>

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

" Insert mode movement
inoremap <C-l> <right>
inoremap <C-h> <left>

" map save to ctrl+s
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

" Space will toggle folds!
" nnoremap <space> za

" Swap ; and :  Convenient.
nnoremap ; :
nnoremap : ;

" Split navigation mappings
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <S-Down> <C-W><C-J>
nnoremap <S-Up> <C-W><C-K>
nnoremap <S-Left> <C-W><C-H>
nnoremap <S-Right> <C-W><C-L>

inoremap gt :bn<CR>
nnoremap gt :bn<CR>
vnoremap gt :bn<CR>
inoremap gT :bp<CR>
nnoremap gT :bp<CR>
vnoremap gT :bp<CR>
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
Bundle 'kris89/vim-multiple-cursors'
Bundle 'Shougo/neocomplete.vim'
Bundle 'bling/vim-airline'
Bundle 'tpope/vim-fugitive'
Bundle 'LaTeX-Box-Team/LaTeX-Box'
Bundle 'marijnh/tern_for_vim'
Bundle 'docunext/closetag.vim'
" Bundle 'klen/python-mode'
Bundle 'tristen/vim-sparkup'
Bundle 'reedes/vim-pencil'
Bundle 'reedes/vim-thematic'
Bundle 'Raimondi/delimitMate'
Bundle 'gregsexton/MatchTag'
Bundle 'kien/ctrlp.vim'
Bundle 'sgur/ctrlp-extensions.vim'
Bundle 'fholgado/minibufexpl.vim'
Bundle 'mhinz/vim-startify'

" Unite bundles
" Bundle 'Shougo/vimproc.vim'
" Bundle 'Shougo/unite.vim'
" Bundle 'tsukkee/unite-tag'
" Bundle 'h1mesuke/unite-outline'

" colorscheme bundles
Bundle 'djjcast/mirodark'
Bundle 'chriskempson/base16-vim'
Bundle 'w0ng/vim-hybrid'
Bundle 'reedes/vim-colors-pencil'
Bundle 'altercation/vim-colors-solarized'

" syntax related bundles
Bundle 'itspriddle/vim-jquery'
Bundle 'concise/vim-html5-fix'
Bundle 'vim-scripts/TagHighlight'
" Bundle 'skammer/vim-css-color'
Bundle 'nono/vim-handlebars'
Bundle 'elzr/vim-json'
Bundle 'jelera/vim-javascript-syntax'
Bundle 'tpope/vim-markdown'
Bundle 'chase/vim-ansible-yaml'
Bundle 'evanmiller/nginx-vim-syntax'
Bundle 'cakebaker/scss-syntax.vim'

" * * * * * * * * * * * * * * * * * * *
" * PLUGIN SETTINGS AND MAPPINGS      *
" * * * * * * * * * * * * * * * * * * *

" Markdown
let g:markdown_fenced_languages = ['css', 'erb=eruby', 'javascript',
    \ 'js=javascript', 'json=javascript', 'ruby', 'sass', 'xml', 'sql']

" Unite settings
" let g:unite_enable_start_insert = 1
" let g:unite_split_rule = "botright"
" let g:unite_force_overwrite_statusline = 0
" let g:unite_enable_short_source_mes = 0
" let g:unite_winheight = 10
" let g:unite_prompt = '>>> '
" let g:unite_marked_icon = '✓'
" let g:unite_source_file_rec_max_cache_files = 1000
" let g:unite_source_rec_max_cache_files = 5000
" let g:unite_data_directory = '~/.vim/.cache/unite'
" let g:unite_source_history_yank_enable = 1
"
" if executable('ag')
"     let g:unite_source_grep_command='ag'
"     let g:unite_source_grep_default_opts='--nocolor --nogroup -S -C4'
"     let g:unite_source_grep_recursive_opt=''
"     let g:unite_source_grep_search_word_highlight = 1
" elseif executable('ack')
"     let g:unite_source_grep_command='ack'
"     let g:unite_source_grep_default_opts='--no-heading --no-color -C4'
"     let g:unite_source_grep_recursive_opt=''
"     let g:unite_source_grep_search_word_highlight = 1
" endif
"
" call unite#filters#matcher_default#use(['matcher_fuzzy'])
" call unite#filters#sorter_default#use(['sorter_rank'])
" call unite#set_profile('files', 'smartcase', 1)
" call unite#custom#source('file,file/new,buffer,file_rec',
"      \ 'matchers', 'matcher_fuzzy')
" call unite#custom_source('file_rec,file_rec/async,file_mru,file,buffer,grep',
"       \ 'ignore_pattern', join([
"       \ '\.git/',
"       \ '\.bundle/',
"       \ '\.cups/',
"       \ '\.svn/',
"       \ '\.subversion/',
"       \ '\.andriod/',
"       \ '\.codeintel/',
"       \ '\.cache/',
"       \ '\.bundler/',
"       \ '\.sass/',
"       \ '\.sass-cache/',
"       \ '\.gem/',
"       \ '\.dropbox/',
"       \ '\.codeintel/',
"       \ '\.config/',
"       \ '\.fontconfig/',
"       \ '\.meteor/',
"       \ '\.meteorite/',
"       \ '\.neocomplcache/',
"       \ '\.npm/',
"       \ '\.node-gyp/',
"       \ ], '\|'))

" autocmd FileType unite call s:unite_settings()
" function! s:unite_settings()
"     imap <buffer> <C-j>   <Plug>(unite_select_next_line)
"     imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
"     imap <buffer> <C-f>   <Plug>(unite_rotate_next_source)
"     nmap <buffer> <C-f>   <Plug>(unite_rotate_next_source)
"     imap <buffer> jk      <Plug>(unite_insert_leave)
"     imap <buffer> <TAB>   <Plug>(unite_select_next_line)
"     imap <buffer><expr> <C-x> unite#do_action('split')
"     imap <buffer><expr> <C-v> unite#do_action('vsplit')
"     imap <buffer> <C-y>     <Plug>(unite_narrowing_path)
"     nmap <buffer> <C-y>     <Plug>(unite_narrowing_path)
"     nmap <buffer> <ESC> <Plug>(unite_exit)
"     nmap <buffer> <C-p> <Plug>(unite_exit)
"     imap <buffer> <C-p> <Plug>(unite_exit)
"     nmap <buffer> <C-o> <Plug>(unite_exit)
"     imap <buffer> <C-o> <Plug>(unite_exit)
"     nmap <buffer> <C-i> <Plug>(unite_exit)
"     imap <buffer> <C-i> <Plug>(unite_exit)
" endfunction

" Unite mappings
" nnoremap <C-p> :<C-u>Unite -buffer-name=files file_rec/async:! file<cr>
" nnoremap <C-i> :<C-u>Unite -buffer-name=buffers buffer<cr>
" nnoremap <C-y> :<C-u>Unite -buffer-name=yank -start-insert history/yank<cr>
" nnoremap <C-t> :<C-u>Unite -buffer-name=tags -start-insert tag<cr>
" nnoremap <C-o> :<C-u>Unite -buffer-name=outline -start-insert line outline<cr>

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
" let g:neocomplete#auto_completion_start_length = 3
let g:neocomplete#max_list = 10
let g:neocomplete#enable_refresh_always = 1
let g:neocomplete#sources#buffer#cache_limit_size = 10000
let g:neocomplete#data_directory = $HOME.'/.vim/cache/noecompl'
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#enable_auto_select = 0
let g:neocomplete#sources#syntax#min_keyword_length = 1

" NeoComplete mappings
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
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
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" Syntastic mappings
nnoremap <Leader>e <Esc>:Errors<CR>

" Vim Airline
let g:airline_powerline_fonts = 0
let g:airline_left_sep = ''
let g:airline_right_sep = ''
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

" Sparkup - remap to avoid conflict
let g:sparkupNextMapping='<c-x>'

" * * * * * * * * * * * * * * * * * * *
" * LOOK AND FEEL                     *
" * * * * * * * * * * * * * * * * * * *

" Remove scrollbars
set guioptions-=r
set guioptions-=L

" Make tabs, trailing whitespace, and non-breaking spaces visible
" set listchars=tab:→\ ,eol:↵,trail:·,extends:↷,precedes:↶
" set list

" highlight past 80 characters
execute "set colorcolumn=" . join(range(81,335), ',')

" Thematic
let g:thematic#themes = {
\ 'pencil_light_code'       :{ 'typeface': 'Meslo LG M DZ for Powerline',
\                  'colorscheme': 'pencil',
\                  'background': 'light',
\                  'font-size': 12,
\                  'transparency': 0,
\                  'airline-theme': 'sol',
\                  'linespace': 1,
\                },
\ 'pencil_dark_code'       :{ 'typeface': 'Meslo LG M DZ for Powerline',
\                  'colorscheme': 'pencil',
\                  'background': 'dark',
\                  'font-size': 12,
\                  'transparency': 0,
\                  'airline-theme': 'sol',
\                  'linespace': 1,
\                },
\ 'hybrid_dark'      :{ 'typeface': 'PragmataPro for Powerline',
\                  'colorscheme': 'hybrid',
\                  'background': 'dark',
\                  'font-size': 12,
\                  'transparency': 0,
\                  'airline-theme': 'luna',
\                  'linespace': 1,
\                },
\ 'solarized_dark'   :{ 'typeface': 'PragmataPro for Powerline',
\                  'colorscheme': 'solarized',
\                  'background': 'dark',
\                  'font-size': 12,
\                  'transparency': 0,
\                  'airline-theme': 'solarized',
\                  'linespace': 1,
\                },
\ 'solarized_light'   :{ 'typeface': 'PragmataPro for Powerline',
\                  'colorscheme': 'solarized',
\                  'background': 'light',
\                  'font-size': 12,
\                  'transparency': 0,
\                  'airline-theme': 'solarized',
\                  'linespace': 1,
\                },
\ 'matrix'      :{ 'colorscheme': 'base16-greenscreen',
\                  'background': 'dark',
\                  'typeface': 'Meyrin',
\                  'linespace': 8,
\                  'font-size': 14,
\                },
\ 'pencil_dark' :{ 'colorscheme': 'pencil',
\                  'background': 'dark',
\                  'ruler': 1,
\                  'laststatus': 0,
\                  'typeface': 'Cousine',
\                  'font-size': 14,
\                  'linespace': 10,
\                  'columns': 120,
\                },
\ 'pencil_lite_prose' :{ 'colorscheme': 'pencil',
\                  'background': 'light',
\                  'laststatus': 0,
\                  'ruler': 1,
\                  'typeface': 'Courier Prime',
\                  'sign-column-color-fix': 1,
\                  'font-size': 14,
\                  'linespace': 10,
\                  'columns': 120,
\                },
\ }

let g:thematic#theme_name = 'solarized_dark'

" Thematic mappings
nnoremap <Leader>h :Thematic solarized_dark<CR>
nnoremap <Leader>l :Thematic pencil_lite_prose<CR>

" Cursor shows matching ) and }
set showmatch
set laststatus=2
set encoding=utf-8
set t_Co=256

" Set off the other paren
highlight MatchParen ctermbg=4

" disable sound on errors
set noerrorbells visualbell t_vb=
set tm=500

" highlight current line and column

syntax on
