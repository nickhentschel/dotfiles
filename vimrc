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

filetype plugin indent on

if &compatible
  set nocompatible
end

" * * * * * * * * * * * * * * * * * * *
" * PLUGINS                           *
" * * * * * * * * * * * * * * * * * * *

call plug#begin('~/.vim/plugged')

Plug 'christoomey/vim-tmux-navigator'
Plug 'godlygeek/tabular'
Plug 'jiangmiao/auto-pairs'
Plug 'jremmen/vim-ripgrep'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'

" syntax and language related bundles
Plug 'clones/vim-zsh', { 'for': 'zsh' }
Plug 'towolf/vim-helm'
Plug 'hashivim/vim-terraform'
Plug 'plasticboy/vim-markdown'
Plug 'elzr/vim-json'
" Plug 'modille/groovy.vim'
Plug 'endSly/groovy.vim', { 'for': 'groovy' }
Plug 'rodjek/vim-puppet', { 'for': 'puppet' }
" Plug 'stephpy/vim-yaml'

" Plug 'sheerun/vim-polyglot'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin'  }
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'yggdroot/indentline'

" colorscheme bundles
Plug 'rakr/vim-one'
Plug 'tomasiser/vim-code-dark'
" Plug 'djjcast/mirodark'
" Plug 'lifepillar/vim-solarized8'
" Plug 'cormacrelf/vim-colors-github'
" Plug 'kamwitsta/flatwhite-vim'
" Plug 'patstockwell/vim-monokai-tasty'
" Plug 'arcticicestudio/nord-vim'
" Plug 'mhartington/oceanic-next'

if has('nvim')
  let g:python3_host_prog = '/usr/local/bin/python3'

  Plug 'shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'shougo/neco-syntax'
  Plug 'nickhentschel/ale'
endif

call plug#end()

" * * * * * * * * * * * * * * * * * * *
" * LOOK AND FEEL                     *
" * * * * * * * * * * * * * * * * * * *

if has("termguicolors")
  set termguicolors
endif

let g:one_allow_italics = 1
colorscheme one
set background=dark

set guifont=Consolas:h12

highlight MatchParen ctermbg=blue guibg=lightblue

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

" * * * * * * * * * * * * * * * * * * *
" * SETTINGS AND MAPPINGS             *
" * * * * * * * * * * * * * * * * * * *

set autoindent                                            " Auto indent
set autoread                                              " Relaod files after change outside of VIM
set autowrite                                             " autowrite on build
set completeopt=menu,preview
set expandtab
set hidden                                                " Allow hidden buffers
set hlsearch                                              " Highlight search
set ignorecase                                            " Ignore case
set incsearch                                             " Incremental searching
set linebreak
set mouse=a                                               " Enable mouse support in console
set nobackup
set nospell                                               " Don't spell check by default
set nostartofline                                         " Don't reset cursor to start of line when moving around
set noswapfile                                            " Disable swap files
set nowritebackup
set nowrap                                                " Disable line wrap by default
set number
set scrolljump=10
set scrolloff=8                                           " Start scrolling when we're 8 lines away from margins
set showbreak=\\\\\
set showcmd                                               " This shows what you are typing as a command
set sidescroll=1
set sidescrolloff=15
set smartcase
set smarttab
set splitbelow                                            " More natural splitting
set splitright
set softtabstop=2
set shiftwidth=2
set tags=./tags;,~/.vimtags                               " Where to look for tag files
set title                                                 " Title
set tabstop=2
set ttimeoutlen=50                                        " Remove insert->normal delay
set wildmenu
set wildmode=list:longest,list:full
set colorcolumn=80
set noerrorbells vb t_vb=                                 " disable sound on errors
set listchars=tab:→\ ,trail:·,extends:↷,precedes:↶,nbsp:× " Make tabs, trailing whitespace, and non-breaking spaces visible
set list
set ruler
set backspace=2
set re=1
set cursorline
set encoding=UTF-8

let g:is_posix = 1

if has('nvim')
  " Live find/replace
  set inccommand=nosplit

  " Esc from terminal
  " tnoremap <Esc> <C-\><C-n>
endif

" Ignore while searching
set wildignore=*.o,*.obj,*~,*vim/backups*,*sass-cache*,*DS_Store*,vendor/rails/**,vendor/cache/**,*.gem,log/**,tmp/**,*.png,*.jpg,*.gif,*.pdf,*.psd,*.log,*.git,*.svn,*.hg,*.eyaml,*/.git/*,*/tmp/*,*.swp,*/.pyc*

let mapleader=" "              " map leader to space
let g:mapleader=" "
nnoremap <Space> <nop>

nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" Yank to end of line, like D and C
noremap Y y$

" Center search result
noremap n nzz
noremap N Nzz

" Replace selection, use . to repeat
nnoremap c* *Ncgn
nnoremap c# #NcgN

" Easier excape from insert
inoremap jk <Esc>

" map save to ctrl+s
inoremap <c-s> <Esc>:w<CR>
nnoremap <c-s> <Esc>:w<CR>
vnoremap <c-s> <Esc>:w<CR>

" allow multiple indentation/deindentation in visual mode
vnoremap < <gv
vnoremap > >gv
vnoremap = =gv

" Up and down are more logical with g
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'

" Create Blank Newlines and stay in Normal mode
nnoremap <silent> zj o<Esc>
nnoremap <silent> zk O<Esc>

" Swap ; and :  Convenient.
nnoremap ; :
noremap : ;
vnoremap ; :
vnoremap : ;

" w!! for writing read-only file
cmap w!! w !sudo tee % >/dev/null

" Map ctrl+a to ctrl+q to get around tmux bindings
nnoremap <C-q> <C-a>
vnoremap <C-q> <C-a>

" Tab navigation mappings
nnoremap gt :bnext<CR>
nnoremap gT :bprevious<CR>
nnoremap <C-c> :bp\|bd #<CR>

" Formatting commands that will remember cursor position
nnoremap g= mmgg=G`m
nnoremap gQ mmgggqG`m

" Search for selected text, forwards or backwards.
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


" * * * * * * * * * * * * * * * * * * *
" * AUGROUPS                          *
" * * * * * * * * * * * * * * * * * * *

" quickfix not listed in buffer lists
augroup vimEx
  autocmd!

  autocmd FileType qf set nobuflisted
  autocmd FileType qf nnoremap <silent><buffer> q :q<CR>
  autocmd FileType help nnoremap <silent><buffer> q :q<CR>

  " autocmd ColorScheme * highlight! Normal ctermbg=NONE guibg=NONE
  autocmd VimResized * wincmd =

  autocmd BufNewFile,BufRead */templates/*.yaml setlocal filetype=helm
  autocmd BufNewFile,BufRead */.config/yamllint/config setlocal filetype=yaml
  autocmd BufNewFile,BufRead *.dockerfile setlocal filetype=Dockerfile
  autocmd BufNewFile,BufRead *.{jenkinsfile,Jenkinsfile} setlocal filetype=groovy
  autocmd BufNewFile,BufRead .{jscs,jshint,eslint,markdownlint,prettier,remark}rc setlocal filetype=json
  autocmd Filetype markdown,groovy set ts=4 sts=4 sw=4
augroup END

" * * * * * * * * * * * * * * * * * * *
" * PLUGIN SETTINGS AND MAPPINGS      *
" * * * * * * * * * * * * * * * * * * *

" NerdTree
nnoremap <Leader>t :NERDTreeToggle<CR>

" ALE
let g:ale_fixers = {
      \   'json': ['prettier','remove_trailing_lines', 'trim_whitespace'],
      \   'markdown': ['remark', 'remove_trailing_lines', 'trim_whitespace'],
      \   'puppet': ['puppetlint'],
      \   'sh': ['shfmt', 'remove_trailing_lines', 'trim_whitespace'],
      \   'terraform': ['terraform'],
      \   'vim': ['remove_trailing_lines', 'trim_whitespace'],
      \   'yaml': ['prettier','remove_trailing_lines', 'trim_whitespace'],
      \}

let g:ale_linters = {
      \   'dockerfile': ['hadolint'],
      \   'Dockerfile': ['hadolint'],
      \   'markdown': ['markdownlint'],
      \   'puppet': ['puppetlint', 'puppet'],
      \   'sh': ['shellcheck'],
      \   'yaml': ['yamllint'],
      \}

let g:ale_linters_explicit = 1
let g:ale_fix_on_save = 1
let g:ale_set_loclist = 1
let g:ale_set_quickfix = 0
let g:ale_open_list = 0

" Syntax
let g:vim_markdown_conceal = 0

" deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#disable_auto_complete = 0

inoremap <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <silent><expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"

function! s:check_back_space() abort "{{{
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}

" Vim Airline
let g:airline_detect_paste = 1
let g:airline_left_sep = ''
let g:airline_powerline_fonts = 0
let g:airline_right_sep = ''
" let g:airline_theme = 'minimalist'
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#ale#enabled = 1

" Indentline
let g:indentLine_char = '▏'
let g:indentLine_color_term = 240
let g:indentLine_concealcursor=""

" FZF
let g:fzf_layout = { 'down': '~40%'  }
let g:fzf_buffers_jump = 1
let g:fzf_action = {
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit'
      \ }

command! -bang -nargs=* Find
      \ call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1,
      \   <bang>0 ? fzf#vim#with_preview('up:60%')
      \           : fzf#vim#with_preview('right:50%:hidden', '?'),
      \   <bang>0)

nnoremap <c-p> :FZF<cr>
nnoremap <c-o> :Buffers<cr>
nnoremap <c-i> :Find<cr>

if executable('rg')
  set grepprg=rg\ --vimgrep\ --color=never
endif

" Markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

" json
let g:vim_json_syntax_conceal = 0

" Tabular mappings
nnoremap <Leader>= :Tabularize /=<CR>
vnoremap <Leader>= :Tabularize /=<CR>
nnoremap <Leader>> :Tabularize /=><CR>
vnoremap <Leader>> :Tabularize /=><CR>
