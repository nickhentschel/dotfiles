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
filetype plugin indent on
syntax enable

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

set autowrite                  " autowrite on build
set autoread                   " Relaod files after change outside of VIM
set tags=./tags;,~/.vimtags    " Where to look for tag files
set splitbelow                 " More natural splitting
set splitright
set incsearch                  " Incremental searching
set ttimeoutlen=50             " Remove insert->normal delay
set nowrap                     " Disable line wrap by default
set linebreak
set title                      " Title
set showcmd                    " This shows what you are typing as a command
set autoindent                 " Auto indent
set expandtab
set smarttab
set ts=2
set sts=2
set sw=2
set spl=en spell               " Set English spell check
set nospell                    " Don't spell check by default
set wildmenu
set completeopt=menu,preview
set wildmode=list:longest,full
set mouse=a                    " Enable mouse support in console
set ignorecase                 " Ignore case
set smartcase
set hlsearch                   " Highlight search
set hidden                     " Allow hidden buffers
set noswapfile                 " Disable swap files
set nobackup
set nowb
set nostartofline              " Don't reset cursor to start of line when moving around
set scrolloff=8                " Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1
set scrolljump=10
set synmaxcol=200              " Stop syntax highlighting after 200 chars
" set breakindent
set showbreak=\\\\\

let g:netrw_banner = 0         " netrw
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1

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

" Formatting commands that will remember cursor position
nnoremap g= mmgg=G`m
nnoremap gQ mmgggqG`m

" Better replace
xnoremap gs y:%s/<C-r>//g<Left><Left>

autocmd VimResized * wincmd =

" quickfix not listed in buffer lists
augroup quit_qf_help
  autocmd!
  autocmd FileType qf set nobuflisted
  autocmd FileType qf nnoremap <silent><buffer> q :q<CR>
  autocmd FileType help nnoremap <silent><buffer> q :q<CR>
augroup END

augroup ColorChg
  au!
  au ColorScheme nofrils-light hi ibTplString term=italic cterm=italic gui=italic
augroup END

augroup formatting
  autocmd!
  autocmd BufRead,BufNewFile */templates/*.yaml setlocal ft=helm
  autocmd FileType markdown setlocal textwidth=80
  autocmd Filetype Dockerfile,markdown setlocal ts=4 sts=4 sw=4 expandtab spell
  autocmd Filetype Jenkinsfile setlocal filetype=groovy
  autocmd BufNewFile,BufRead *.dockerfile setlocal filetype=Dockerfile
  autocmd BufNewFile,BufRead *.jenkinsfile setlocal filetype=groovy
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
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-endwise', { 'for': ['eruby', 'ruby', 'bash'] }
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'w0rp/ale'
Plug 'yggdroot/indentline'
Plug 'severin-lemaignan/vim-minimap'

" syntax and language related bundles
Plug 'avakhov/vim-yaml', { 'for': 'yaml' }
Plug 'clones/vim-zsh', { 'for': 'zsh' }
Plug 'rdolgushin/groovy.vim', { 'for': 'groovy' }
Plug 'saltstack/salt-vim'
Plug 'sclo/haproxy.vim', { 'for': 'haproxy' }
Plug 'sheerun/vim-polyglot'
Plug 'sukima/xmledit',
Plug 'towolf/vim-helm', { 'do': 'rm ftplugin/html.vim && ln -s ftplugin/xml.vim ftplugin/html.vim' }
Plug 'vim-scripts/groovyindent-unix', { 'for': 'groovy' }
Plug 'vim-scripts/jcommenter.vim', { 'for': 'groovy' }

" colorscheme bundles
Plug 'robertmeta/nofrils'
Plug 'andreasvc/vim-256noir'
Plug 'djjcast/mirodark'
Plug 'nickhentschel/vim-sublime-monokai'
Plug 'morhetz/gruvbox'
Plug 'nlknguyen/papercolor-theme'
Plug 'w0ng/vim-hybrid'
Plug 'endel/vim-github-colorscheme'
Plug 'owickstrom/vim-colors-paramount'
Plug 'noahfrederick/vim-noctu'
Plug 'pbrisbin/vim-colors-off'

if has('nvim')
  let g:python3_host_prog = '/usr/local/bin/python3'

  Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
  Plug 'shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'shougo/neco-syntax'
  " Plug 'sirver/ultisnips'
  Plug 'zchee/deoplete-go', { 'do': 'make'}
endif

call plug#end()

" * * * * * * * * * * * * * * * * * * *
" * PLUGIN SETTINGS AND MAPPINGS      *
" * * * * * * * * * * * * * * * * * * *

" ALE
let g:ale_fixers = {
\   'markdown': ['remark', 'remove_trailing_lines', 'trim_whitespace'],
\   'sh': ['shfmt', 'remove_trailing_lines', 'trim_whitespace'],
\   'vim': ['remove_trailing_lines', 'trim_whitespace'],
\   'yaml': ['remove_trailing_lines', 'trim_whitespace'],
\}

let g:ale_linters = {
\   'puppet': ['puppet-lint'],
\   'markdown': ['remark-lint'],
\}

let g:ale_fix_on_save = 1

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
let g:indentLine_char = '│'
let g:indentLine_color_term = 240

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

" Vim Airline
let g:airline_detect_paste = 1
let g:airline_left_sep = ''
let g:airline_powerline_fonts = 0
let g:airline_right_sep = ''
let g:airline_theme = 'minimalist'
let g:airline#extensions#branch#empty_message = ''
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#bufferline#enabled = 0
let g:airline#extensions#bufferline#overwrite_variables = 0
let g:airline#extensions#ale#enabled = 1

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

" disable sound on errors
set noeb vb t_vb=

let g:nofrils_strbackgrounds=1
let g:nofrils_heavycomments=0
let g:nofrils_heavylinenumbers=0

" Theme
set background=dark
colorscheme nofrils-dark

" Line at 80 characters
" hi MatchParen cterm=bold ctermbg=none ctermfg=red
" highlight ColorColumn ctermbg=235
set colorcolumn=80
