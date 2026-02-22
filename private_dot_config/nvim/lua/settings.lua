-- Settings

vim.opt.autoindent    = true
vim.opt.autoread      = true
vim.opt.autowrite     = true
vim.opt.completeopt   = { 'menu', 'preview' }
vim.opt.expandtab     = true
vim.opt.hidden        = true
vim.opt.hlsearch      = true
vim.opt.ignorecase    = true
vim.opt.incsearch     = true
vim.opt.linebreak     = true
vim.opt.mouse         = 'a'
vim.opt.backup        = false
vim.opt.spell         = false
vim.opt.startofline   = false
vim.opt.swapfile      = false
vim.opt.writebackup   = false
vim.opt.wrap          = false
vim.opt.number        = true
vim.opt.scrolljump    = 10
vim.opt.scrolloff     = 8
vim.opt.showbreak     = '\\\\\\'
vim.opt.showcmd       = true
vim.opt.sidescroll    = 1
vim.opt.sidescrolloff = 15
vim.opt.smartcase     = true
vim.opt.smarttab      = true
vim.opt.splitbelow    = true
vim.opt.splitright    = true
vim.opt.softtabstop   = 4
vim.opt.shiftwidth    = 4
vim.opt.tags          = { './tags;', '~/.vimtags' }
vim.opt.title         = true
vim.opt.tabstop       = 4
vim.opt.ttimeoutlen   = 50
vim.opt.wildmenu      = true
vim.opt.wildmode      = { 'list:longest', 'list:full' }
vim.opt.colorcolumn   = '80'
vim.opt.errorbells    = false
vim.opt.visualbell    = true
vim.opt.listchars     = { tab = '→ ', trail = '·', extends = '↷', precedes = '↶', nbsp = '×' }
vim.opt.list          = true
vim.opt.ruler         = true
vim.opt.cursorline    = true
vim.opt.encoding      = 'UTF-8'
vim.opt.inccommand    = 'nosplit'
vim.opt.termguicolors = true
vim.opt.background    = 'dark'

vim.opt.wildignore:append({
  '*.o', '*.obj', '*~', '*vim/backups*', '*sass-cache*', '*DS_Store*',
  'vendor/rails/**', 'vendor/cache/**', '*.gem', 'log/**', 'tmp/**',
  '*.png', '*.jpg', '*.gif', '*.pdf', '*.psd', '*.log',
  '*.git', '*.svn', '*.hg', '*.eyaml', '*/.git/*', '*/tmp/*', '*.swp', '*/.pyc*',
})

vim.g.is_posix = 1

-- Augroups
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local vimEx = augroup('vimEx', { clear = true })

autocmd('FileType', {
  group = vimEx,
  pattern = 'qf',
  callback = function()
    vim.opt_local.buflisted = false
    vim.keymap.set('n', 'q', '<CMD>q<CR>', { silent = true, buffer = true })
  end,
})

autocmd('FileType', {
  group = vimEx,
  pattern = 'help',
  callback = function()
    vim.keymap.set('n', 'q', '<CMD>q<CR>', { silent = true, buffer = true })
  end,
})

autocmd('VimResized', {
  group = vimEx,
  callback = function() vim.cmd('wincmd =') end,
})

autocmd({ 'BufNewFile', 'BufRead' }, {
  group = vimEx,
  pattern = '*/templates/*.yaml',
  callback = function() vim.opt_local.filetype = 'helm' end,
})

autocmd({ 'BufNewFile', 'BufRead' }, {
  group = vimEx,
  pattern = '*/.config/yamllint/config',
  callback = function() vim.opt_local.filetype = 'yaml' end,
})

autocmd({ 'BufNewFile', 'BufRead' }, {
  group = vimEx,
  pattern = '*.dockerfile',
  callback = function() vim.opt_local.filetype = 'Dockerfile' end,
})

autocmd({ 'BufNewFile', 'BufRead' }, {
  group = vimEx,
  pattern = { '*.jenkinsfile', '*.Jenkinsfile' },
  callback = function() vim.opt_local.filetype = 'groovy' end,
})

autocmd({ 'BufNewFile', 'BufRead' }, {
  group = vimEx,
  pattern = { '.jscsrc', '.jshintrc', '.eslintrc', '.markdownlintrc', '.prettierrc', '.remarkrc' },
  callback = function() vim.opt_local.filetype = 'json' end,
})

autocmd('FileType', {
  group = vimEx,
  pattern = { 'markdown', 'groovy' },
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.softtabstop = 4
    vim.opt_local.shiftwidth = 4
  end,
})
