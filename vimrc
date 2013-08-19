" Super Awesome Vimrc

" Necesary  for lots of cool vim things
set nocompatible

"{{{Auto Commands

" auto reload vimrc when editing it
autocmd! bufwritepost .vimrc source ~/.vimrc

" JQuery syntax support
autocmd Syntax javascript set syntax=jquery

" extend the matching capability with % key
runtime macros/matchit.vim

" Automatically cd into the directory that the file is in
autocmd BufEnter * execute "chdir ".escape(expand("%:p:h"), ' ')

" Remove any trailing whitespace that is in the file
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

" Restore cursor position to where it was before
augroup JumpCursorOnEdit
   au!
   autocmd BufReadPost *
            \ if expand("<afile>:p:h") !=? $TEMP |
            \   if line("'\"") > 1 && line("'\"") <= line("$") |
            \     let JumpCursorOnEdit_foo = line("'\"") |
            \     let b:doopenfold = 1 |
            \     if (foldlevel(JumpCursorOnEdit_foo) > foldlevel(JumpCursorOnEdit_foo - 1)) |
            \        let JumpCursorOnEdit_foo = JumpCursorOnEdit_foo - 1 |
            \        let b:doopenfold = 2 |
            \     endif |
            \     exe JumpCursorOnEdit_foo |
            \   endif |
            \ endif
   " Need to postpone using "zv" until after reading the modelines.
   autocmd BufWinEnter *
            \ if exists("b:doopenfold") |
            \   exe "normal zv" |
            \   if(b:doopenfold > 1) |
            \       exe  "+".1 |
            \   endif |
            \   unlet b:doopenfold |
            \ endif
augroup END

"}}}

"{{{Misc Settings

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

" Needed for Syntax Highlighting and stuff
set grepprg=grep\ -nH\ $*

" Who doesn't like autoindent?
set autoindent
set expandtab
set smarttab
set smartindent

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

"{{{Look and Feel
" set laststatus=2
" set statusline=%F%m%r%h%w\ (%{&ff}){%Y}\ [%l,%v][%p%%]

set guifont=PragmataPro:h12

" Cursor shows matching ) and }
set showmatch
set laststatus=2
set encoding=utf-8
set t_Co=256
set cursorline	" highlight current line
highlight CursorLine  guibg=#003853 ctermbg=24  gui=none cterm=none
" let g:Powerline_symbols = 'fancy'

" disable sound on errors
set noerrorbells visualbell t_vb=
set tm=500

" }}}

"{{{ Mappings

" escape text for hmtl
nnoremap <leader>1 :%s/’/\&rsquo\;/g<cr><bar>:%s/“/\&ldquo\;/g<cr><bar>:%s/”/\&rdquo\;/g<cr><bar>:%s/^\n//g<cr>
nnoremap <leader>2 :%s/^/<p>/g<cr><bar>:%s/$/<\/p>/g<cr>
nnoremap <leader>3 :%s/^/<p style=\"margin: 0 0 10px\; padding: 0\; color: rgb(0, 0, 0)\; line-height: 16px\; font-size: 13px\;\">/g<cr><bar>:%s/$/<\/p>/g<cr>

" map save to ctrl+s
inoremap <c-s> <Esc>:w<CR>
nnoremap <c-s> <Esc>:w<CR>

" map buffer toggles with leader
map <leader>n :bn<cr>
map <Leader>b :bp<cr>
map <leader>w :bd<cr>

" allow multiple indentation/deindentation in visual mode
vnoremap < <gv
vnoremap > >gv
vnoremap = =gv

" Loop to switch windows
nmap <S-w> :wincmd w<CR>

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

" make keypad work in vim with iTerm on OS X!
map <Esc>Oq 1
map <Esc>Or 2
map <Esc>Os 3
map <Esc>Ot 4
map <Esc>Ou 5
map <Esc>Ov 6
map <Esc>Ow 7
map <Esc>Ox 8
map <Esc>Oy 9
map <Esc>Op 0
map <Esc>On .
map <Esc>OQ /
map <Esc>OR *
map <kPlus> +
map <Esc>OS -
map! <Esc>Oq 1
map! <Esc>Or 2
map! <Esc>Os 3
map! <Esc>Ot 4
map! <Esc>Ou 5
map! <Esc>Ov 6
map! <Esc>Ow 7
map! <Esc>Ox 8
map! <Esc>Oy 9
map! <Esc>Op 0
map! <Esc>On .
map! <Esc>OQ /
map! <Esc>OR *
map! <kPlus> +
map! <Esc>OS -

" Split navigation mappings
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" More natural splitting
set splitbelow
set splitright

 "}}}

" {{{ Bundles and Such

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

Bundle 'Lokaltog/vim-powerline'
Bundle 'kien/ctrlp.vim'
Bundle 'Bogdanp/browser-connect.vim'
Bundle 'tomtom/tcomment_vim'
Bundle 'scrooloose/nerdtree'
Bundle 'tpope/vim-surround'
Bundle 'scrooloose/syntastic'
<<<<<<< HEAD
Bundle 'nono/vim-handlebars'
=======
>>>>>>> 476c14b8fe0d0e60dc33a97a605bd49ec42c678f
Bundle 'terryma/vim-multiple-cursors'
Bundle 'Shougo/neocomplcache.vim'
Bundle 'ervandew/supertab'
Bundle 'sukima/xmledit'
Bundle 'Townk/vim-autoclose'
Bundle 'vim-scripts/ZoomWin'
Bundle 'shawncplus/phpcomplete.vim'
Bundle 'joonty/vdebug.git'

" syntax
Bundle 'itspriddle/vim-jquery'
Bundle 'pangloss/vim-javascript'
Bundle 'concise/vim-html5-fix'
<<<<<<< HEAD
Bundle 'vim-scripts/TagHighlight'

" syntax
Bundle 'itspriddle/vim-jquery'
Bundle 'pangloss/vim-javascript'
=======
Bundle 'skammer/vim-css-color'
<<<<<<< HEAD
>>>>>>> 88d7ab5a6e5968db51205049011f56dd7bb1f6d4
=======
Bundle 'nono/vim-handlebars'
>>>>>>> 476c14b8fe0d0e60dc33a97a605bd49ec42c678f

" colorschemes
Bundle 'chmllr/vim-colorscheme-elrodeo'
Bundle 'zeis/vim-kolor'
Bundle 'chriskempson/base16-vim'
Bundle 'junegunn/seoul256.vim'
Bundle 'chriskempson/vim-tomorrow-theme'

" }}}

" {{{ File type specific settings

" Settings for markdown files
au BufRead,BufNewFile *.md setl sw=2 sts=2 spell et wrap linebreak
au BufRead,BufNewFile *.txt setl sw=2 sts=2 spell et wrap linebreak

" }}}

" {{{ Syntastic

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

" }}}

filetype plugin indent on
syntax on
set background=dark
colorscheme base16-default

