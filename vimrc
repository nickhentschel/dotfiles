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
filetype off
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

" autowrite on build
set autowrite

" Where to look for tag files
set tags=./tags;,~/.vimtags

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
set completeopt-=preview
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

" netrw
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1

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

" netrw
" nnoremap <leader>t :Vexplore<CR>

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

au BufRead,BufNewFile *.md setlocal textwidth=80

augroup go
  autocmd!

  " Show by default 4 spaces for a tab
  autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4

  " :GoBuild and :GoTestCompile
  autocmd FileType go nmap <leader>b <Plug>(go-build)

  " :GoRun
  autocmd FileType go nmap <leader>r  <Plug>(go-run)

  " :GoInfo
  autocmd FileType go nmap <Leader>i <Plug>(go-info)

  " :GoMetaLinter
  autocmd FileType go nmap <Leader>l <Plug>(go-metalinter)

  " :GoAlternate  commands :A, :AV, :AS and :AT
  autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
  autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
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

" Vim script for text filtering and alignment
Plug 'godlygeek/tabular'

" colorscheme bundles
Plug 'djjcast/mirodark'
Plug 'andreasvc/vim-256noir'
Plug 'altercation/vim-colors-solarized'
Plug 'morhetz/gruvbox'
Plug 'NLKNguyen/papercolor-theme'
Plug 'w0ng/vim-hybrid'

" syntax and language related bundles
Plug 'sheerun/vim-polyglot'
Plug 'clones/vim-zsh', { 'for': ['zsh'] }
Plug 'rodjek/vim-puppet', { 'for': ['puppet'] }
Plug 'sclo/haproxy.vim', { 'for': ['haproxy'] }
Plug 'saltstack/salt-vim'

if has('nvim')
    let g:python3_host_prog = '/usr/local/bin/python3'
    let g:python3_host_skip_check = 1

    Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'zchee/deoplete-go', { 'do': 'make'}
    " Plug 'SirVer/ultisnips'
endif

call plug#end()

" * * * * * * * * * * * * * * * * * * *
" * PLUGIN SETTINGS AND MAPPINGS      *
" * * * * * * * * * * * * * * * * * * *

" Syntax
let g:vim_markdown_conceal = 0

" Go
let g:go_fmt_command = "goimports"
let g:go_autodetect_gopath = 1
let g:go_list_type = "quickfix"
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_generate_tags = 1

" deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#disable_auto_complete = 0
let g:deoplete#sources#go#gocode_binary = '/Users/nhentschel/go/bin/gocode'
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']

inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ deoplete#mappings#manual_complete()

inoremap <silent><expr> <S-TAB>
    \ pumvisible() ? "\<C-p>" :
    \ <SID>check_back_space() ? "\<S-TAB>" :
    \ deoplete#mappings#manual_complete()

function! s:check_back_space() abort "{{{
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}

" Indentline
let g:indentLine_char = '⎸'
let g:indentLine_color_term = 239

" Polyglot
let g:polyglot_disabled = ['puppet']

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
let g:airline_theme = 'minimalist'
let g:airline_detect_paste = 1
let g:airline_powerline_fonts = 0
let g:airline#extensions#bufferline#overwrite_variables = 0
let g:airline#extensions#bufferline#enabled = 0
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#branch#empty_message = ''
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
" set t_Co=256
syntax enable
" let g:mirodark_disable_color_approximation=1
colorscheme solarized
" let g:gruvbox_termcolors=16
set background=dark
hi Normal guibg=NONE ctermbg=NONE
