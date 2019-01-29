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
set nowb
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
set sts=2
set sw=2
set tags=./tags;,~/.vimtags                               " Where to look for tag files
set title                                                 " Title
set ts=2
set ttimeoutlen=50                                        " Remove insert->normal delay
set wildmenu
set wildmode=list:longest,list:full
" set colorcolumn=+1
set noeb vb t_vb=                                         " disable sound on errors
set listchars=tab:→\ ,trail:·,extends:↷,precedes:↶,nbsp:× " Make tabs, trailing whitespace, and non-breaking spaces visible
set list
set laststatus=2
set ruler
set backspace=2
" set clipboard=unnamedplus

if &compatible
  set nocompatible
end

let g:is_posix = 1

" netrw
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1

" Live find/replace
if has('nvim')
  set inccommand=nosplit
endif

" Ignore while searching
set wildignore=*.o,*.obj,*~,*vim/backups*,*sass-cache*,*DS_Store*,vendor/rails/**,vendor/cache/**,*.gem,log/**,tmp/**,*.png,*.jpg,*.gif,*.pdf,*.psd,*.log,*.git,*.svn,*.hg,*.eyaml,*/.git/*,*/tmp/*,*.swp,*/.pyc*

let mapleader=" "              " map leader to space
let g:mapleader=" "
nnoremap <Space> <nop>

nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

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

" Tab navigation mappings
nnoremap gt :bnext<CR>
nnoremap gT :bprevious<CR>
nnoremap <C-c> :bp\|bd #<CR>

" w!! for writing read-only file
cmap w!! w !sudo tee % >/dev/null

" Map ctrl+a to ctrl+q to get around tmux bindings
nnoremap <C-q> <C-a>
vnoremap <C-q> <C-a>

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

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

filetype plugin indent on

" * * * * * * * * * * * * * * * * * * *
" * BUNDLES AND SUCH                  *
" * * * * * * * * * * * * * * * * * * *

call plug#begin('~/.vim/plugged')

Plug 'christoomey/vim-tmux-navigator'
Plug 'godlygeek/tabular'
Plug 'jiangmiao/auto-pairs'
Plug 'jremmen/vim-ripgrep'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin'  }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'scrooloose/nerdtree'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'yggdroot/indentline'

" syntax and language related bundles
Plug 'clones/vim-zsh', { 'for': 'zsh' }
Plug 'sclo/haproxy.vim', { 'for': 'haproxy' }
Plug 'sheerun/vim-polyglot'
Plug 'towolf/vim-helm'
Plug 'vim-scripts/jcommenter.vim', { 'for': 'groovy' }
Plug 'endSly/groovy.vim', { 'for': 'groovy' }

" colorscheme bundles
Plug 'robertmeta/nofrils'
Plug 'djjcast/mirodark'
Plug 'nickhentschel/vim-sublime-monokai'
Plug 'lifepillar/vim-solarized8'
Plug 'cormacrelf/vim-colors-github'
Plug 'kamwitsta/flatwhite-vim'
Plug 'patstockwell/vim-monokai-tasty'
Plug 'jeffkreeftmeijer/vim-dim'

if has('nvim')
  let g:python3_host_prog = '/usr/local/bin/python3'

  Plug 'nickhentschel/ale'

  Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
  Plug 'shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'shougo/neco-syntax'
  " Plug 'sirver/ultisnips'
  Plug 'zchee/deoplete-go', { 'do': 'make'}
endif

call plug#end()


" * * * * * * * * * * * * * * * * * * *
" * LOOK AND FEEL                     *
" * * * * * * * * * * * * * * * * * * *

set termguicolors

" colorscheme sublimemonokai
" let g:nofrils_strbackgrounds=1
" let g:nofrils_heavycomments=0
" let g:nofrils_heavylinenumbers=0
"
" allow italics, set this before the colorscheme
let g:vim_monokai_tasty_italic=1
colorscheme vim-monokai-tasty
highlight MatchParen ctermbg=blue guibg=lightblue

set background=dark

" * * * * * * * * * * * * * * * * * * *
" * AUGROUPS                          *
" * * * * * * * * * * * * * * * * * * *

" quickfix not listed in buffer lists
augroup vimEx
  autocmd!

  autocmd BufReadPost *
        \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif

  autocmd FileType qf set nobuflisted
  autocmd FileType qf nnoremap <silent><buffer> q :q<CR>
  autocmd FileType help nnoremap <silent><buffer> q :q<CR>

  autocmd ColorScheme * highlight! Normal ctermbg=NONE guibg=NONE
  autocmd VimResized * wincmd =

  autocmd BufRead,BufNewFile */templates/*.yaml setlocal ft=helm
  autocmd BufNewFile,BufRead */.config/yamllint/config setlocal filetype=yaml
  autocmd Filetype Dockerfile,markdown setlocal ts=4 sts=4 sw=4
  autocmd BufNewFile,BufRead *.dockerfile setlocal filetype=Dockerfile
  autocmd BufNewFile,BufRead *.{jenkinsfile,Jenkinsfile} setlocal filetype=groovy
  autocmd BufNewFile,BufRead .{jscs,jshint,eslint,markdownlint,prettier,remark}rc setlocal filetype=json
augroup END

augroup go
  autocmd!
  autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
  autocmd FileType go nmap <leader>b <Plug>(go-build)
  autocmd FileType go nmap <leader>r <Plug>(go-run)
  autocmd FileType go nmap <Leader>i <Plug>(go-info)
  autocmd FileType go nmap <Leader>l <Plug>(go-metalinter)

  " :GoAlternate  commands :A, :AV, :AS and :AT
  autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
  autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
  autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
  autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
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
\   'markdown': ['markdownlint'],
\   'puppet': ['puppetlint'],
\   'sh': ['shellcheck'],
\   'yaml': ['yamllint'],
\}

let g:ale_linters_explicit = 1
let g:ale_fix_on_save = 1
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 1
let g:ale_open_list = 1

" Syntax
let g:vim_markdown_conceal = 0

" Go
let g:go_autodetect_gopath = 1
let g:go_fmt_command = 'goimports'
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_methods = 1
let g:go_highlight_types = 1
let g:go_list_type = 'quickfix'

" Vim Airline
let g:airline_detect_paste = 1
let g:airline_left_sep = ''
let g:airline_powerline_fonts = 0
let g:airline_right_sep = ''
" let g:airline_theme = 'minimalist'
let g:airline_theme='monokai_tasty'
let g:airline#extensions#branch#empty_message = ''
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#bufferline#enabled = 0
let g:airline#extensions#bufferline#overwrite_variables = 0
let g:airline#extensions#ale#enabled = 1

" deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#disable_auto_complete = 0
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']

inoremap <silent><expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
inoremap <silent><expr><s-tab> pumvisible() ? "\<c-p>" : "\<s-tab>"

function! s:check_back_space() abort "{{{
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}

" Indentline
let g:indentLine_char = '▏'
" let g:indentLine_color_term = 240

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

" Tabular mappings
nnoremap <Leader>= :Tabularize /=<CR>
vnoremap <Leader>= :Tabularize /=<CR>
nnoremap <Leader>> :Tabularize /=><CR>
vnoremap <Leader>> :Tabularize /=><CR>

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
