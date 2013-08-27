" Super Awesome Vimrc

" Necesary  for lots of cool vim things
set nocompatible
filetype plugin indent on

"{{{ Auto Commands

" Syntax specific stuff
autocmd Syntax javascript set syntax=jquery
au BufRead,BufNewFile *.md setl sw=2 sts=2 spell et wrap linebreak
au BufRead,BufNewFile *.txt setl sw=2 sts=2 spell et wrap linebreak

" extend the matching capability with % key
runtime macros/matchit.vim

"}}}

" {{{ Misc Settings

" Syntastic settings
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=0
let g:syntastic_echo_current_error=1
let g:syntastic_enable_signs=1
let g:syntastic_enable_balloons = 1
let g:syntastic_auto_jump=0
let g:syntastic_loc_list_height=5
let g:syntastic_javascript_checkers = ['jsl']
let g:syntastic_html_checkers = ['tidy']
let g:syntastic_php_checkers = ['php']
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" autoclose and indent on {}
let g:AutoCloseExpandEnterOn = "{"

" Vim Airline
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#whitespace#symbol = '!'
let g:airline#extensions#whitespace#show_message = 1
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline_theme="luna"
let g:airline_powerline_fonts = 1

" MiniBuff
let g:miniBufExplBuffersNeeded = 1
let g:miniBufExplorerAutoStart = 1
let g:miniBufExplCycleArround = 1
let g:miniBufExplBRSplit = 0

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

" Syntastic
let g:syntastic_check_on_open=1
let g:syntastic_enable_signs=1

" NeoComplCache
let g:neocomplcache_enable_at_startup=1
let g:neoComplcache_disableautocomplete=0
let g:neocomplcache_enable_smart_case=1
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
set completeopt-=preview

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType c setlocal omnifunc=ccomplete#Complete
autocmd FileType php setlocal omnifunc=phpcomplete#Complete

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" SuperTab
let g:SuperTabDefaultCompletionType = '<C-x><C-o>'
" let g:SuperTabDefaultCompletionType = 'context'
" let g:SuperTabRetainCompletionType=2
"
" ctrlp
let g:ctrlp_custom_ignore = '\.git$\|\.hg$\|\.svn$'

" Disable line wrap by default
set nowrap
set linebreak

" Title
set title

" This shows what you are typing as a command.  I love this!
set showcmd

" Folding Stuffs
set foldmethod=marker

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
if version >= 700
   set spl=en spell
   set nospell
endif

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

" Line Numbers PWN!
set number

" Ignoring case is a fun trick
set ignorecase

" And so is Artificial Intellegence!
set smartcase

" This is totally awesome - remap jj to escape in insert mode.  You'll never type jj anyway, so it's great!
inoremap jj <Esc>

nnoremap JJJJ <Nop>

" Incremental searching is sexy
set incsearch

" Highlight things that we find with the search
set hlsearch

" buffers can exist in the background without being in a window.
set hidden

" Set off the other paren
highlight MatchParen ctermbg=4

" map leader to comma
let mapleader=","
let g:mapleader=","

" Disable swap files
set noswapfile
set nobackup
set nowb

" Start scrolling when we're 8 lines away from margins
set scrolloff=8
set sidescrolloff=15
set sidescroll=1

" Scroll viewport 3 lines instead of 1
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" }}}

"{{{ Look and Feel

set guifont=PragmataPro\ for\ Powerline:h12
" set guifont=ProFont:h12
" set guifont=M+\ 1m:h12
" set guifont=Envy\ Code\ R:h12
" set guifont=Terminus\ (TTF)\ for\ Powerline:h12
" set guifont=Terminus\ (TTF):h12

set noantialias

" Cursor shows matching ) and }
set showmatch
set laststatus=2
set encoding=utf-8
set t_Co=256

" highlight current line and column
set cursorline cursorcolumn

" disable sound on errors
set noerrorbells visualbell t_vb=
set tm=500

"}}}

"{{{ Mappings

" Sane regex with /
nnoremap / /\v
vnoremap / /\v
nnoremap ? ?\v
vnoremap ? ?\v
cnoremap s/ s/\v

" Insert mode movement
inoremap <C-l> <right>
inoremap <C-h> <left>

" Syntastic
nnoremap <Leader>e <Esc>:Errors<CR>

" Minibuff
noremap <C-TAB>   :MBEbn<CR>
noremap <C-S-TAB> :MBEbp<CR>

" escape text for html
nnoremap <leader>1 :%s/’/\&rsquo\;/g<cr><bar>:%s/“/\&ldquo\;/g<cr><bar>:%s/”/\&rdquo\;/g<cr><bar>:%s/^\n//g<cr>
nnoremap <leader>2 :%s/^/<p>/g<cr><bar>:%s/$/<\/p>/g<cr>
nnoremap <leader>3 :%s/^/<p style=\"margin: 0 0 10px\; padding: 0\; color: rgb(0, 0, 0)\; line-height: 16px\; font-size: 13px\;\">/g<cr><bar>:%s/$/<\/p>/g<cr>
nnoremap <Leader>4 :%s/<\/body>/<script src="http:\/\/localhost:9001\/ws"><\/script><\/body>/g<cr>

" close current buffer, leaving window open
nnoremap <c-c> <Esc>:MBEbd<CR>

" map save to ctrl+s
inoremap <c-s> <Esc>:w<CR>
nnoremap <c-s> <Esc>:w<CR>
vnoremap <c-s> <Esc>:w<CR>

" allow multiple indentation/deindentation in visual mode
vnoremap < <gv
vnoremap > >gv
vnoremap = =gv

" Nerd Tree
map <C-t> :NERDTreeToggle<CR>
inoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-t> :NERDTreeToggle<CR>

" Up and down are more logical with g..
nnoremap <silent> k gk
nnoremap <silent> j gj

" Create Blank Newlines and stay in Normal mode
nnoremap <silent> zj o<Esc>
nnoremap <silent> zk O<Esc>

" Space will toggle folds!
nnoremap <space> za

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
map N Nzz
map n nzz

" Swap ; and :  Convenient.
nnoremap ; :
nnoremap : ;

" CtrlP mapping
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'c'

" Split navigation mappings
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

 "}}}

" {{{ Bundles and Such

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

Bundle 'kien/ctrlp.vim'
Bundle 'Bogdanp/browser-connect.vim'
Bundle 'tomtom/tcomment_vim'
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-surround'
Bundle 'scrooloose/syntastic'
Bundle 'terryma/vim-multiple-cursors'
Bundle 'Shougo/neocomplcache.vim'
Bundle 'ervandew/supertab'
Bundle 'Townk/vim-autoclose'
Bundle 'fholgado/minibufexpl.vim'
Bundle 'bling/vim-airline'
Bundle 'mileszs/ack.vim'
Bundle 'tpope/vim-fugitive'

" syntax
Bundle 'itspriddle/vim-jquery'
Bundle 'pangloss/vim-javascript'
Bundle 'concise/vim-html5-fix'
Bundle 'vim-scripts/TagHighlight'
Bundle 'skammer/vim-css-color'
Bundle 'nono/vim-handlebars'
Bundle 'shawncplus/phpcomplete.vim'
Bundle 'sukima/xmledit'

" colorschemes
Bundle 'chmllr/vim-colorscheme-elrodeo'
Bundle 'chriskempson/base16-vim'

" }}}

syntax on
set background=dark
colorscheme base16-default
