-- Key mappings

vim.g.mapleader = ' '
vim.keymap.set('n', '<Space>', '<nop>')

vim.keymap.set('n', '<C-e>', '3<C-e>')
vim.keymap.set('n', '<C-y>', '3<C-y>')

-- Yank to end of line, like D and C
vim.keymap.set({ 'n', 'v' }, 'Y', 'y$')

-- Center search result
vim.keymap.set({ 'n', 'v' }, 'n', 'nzz')
vim.keymap.set({ 'n', 'v' }, 'N', 'Nzz')

-- Replace selection, use . to repeat
vim.keymap.set('n', 'c*', '*Ncgn')
vim.keymap.set('n', 'c#', '#NcgN')

-- Easier escape from insert
vim.keymap.set('i', 'jk', '<Esc>')

-- Save with ctrl+s
vim.keymap.set('i', '<C-s>', '<Esc>:w<CR>')
vim.keymap.set('n', '<C-s>', '<Esc>:w<CR>')
vim.keymap.set('v', '<C-s>', '<Esc>:w<CR>')

-- Allow multiple indentation/deindentation in visual mode
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')
vim.keymap.set('v', '=', '=gv')

-- Up and down more logical with g
vim.keymap.set('n', 'j', function() return vim.v.count > 0 and 'j' or 'gj' end, { expr = true })
vim.keymap.set('n', 'k', function() return vim.v.count > 0 and 'k' or 'gk' end, { expr = true })

-- Create blank newlines and stay in normal mode
vim.keymap.set('n', 'zj', 'o<Esc>', { silent = true })
vim.keymap.set('n', 'zk', 'O<Esc>', { silent = true })

-- Swap ; and :
vim.keymap.set('n', ';', ':')
vim.keymap.set('n', ':', ';')
vim.keymap.set('v', ';', ':')
vim.keymap.set('v', ':', ';')

-- w!! for writing read-only file
vim.keymap.set('c', 'w!!', 'w !sudo tee % >/dev/null')

-- Map ctrl+a to ctrl+q to get around tmux bindings
vim.keymap.set('n', '<C-q>', '<C-a>')
vim.keymap.set('v', '<C-q>', '<C-a>')

-- Buffer navigation
vim.keymap.set('n', 'gt', ':bnext<CR>')
vim.keymap.set('n', 'gT', ':bprevious<CR>')
vim.keymap.set('n', '<C-c>', ':bp|bd #<CR>')

-- Formatting commands that remember cursor position
vim.keymap.set('n', 'g=', 'mmgg=G`m')
vim.keymap.set('n', 'gQ', 'mmgggqG`m')

-- Search for selected text forwards or backwards
vim.keymap.set('v', '*', [[:<C-U>let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>gvy/<C-R><C-R>=substitute(escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>gV:call setreg('"', old_reg, old_regtype)<CR>]], { silent = true })
vim.keymap.set('v', '#', [[:<C-U>let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>gvy?<C-R><C-R>=substitute(escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>gV:call setreg('"', old_reg, old_regtype)<CR>]], { silent = true })

-- FZF
vim.keymap.set('n', '<C-p>', ':FZF<CR>')
vim.keymap.set('n', '<C-o>', ':Buffers<CR>')
vim.keymap.set('n', '<C-i>', ':Find<CR>')

-- Tabular
vim.keymap.set('n', '<Leader>=', ':Tabularize /=<CR>')
vim.keymap.set('v', '<Leader>=', ':Tabularize /=<CR>')
vim.keymap.set('n', '<Leader>>', ':Tabularize /=><CR>')
vim.keymap.set('v', '<Leader>>', ':Tabularize /=><CR>')

-- nvim-tree (replaces NERDTree, same key)
vim.keymap.set('n', '<Leader>t', ':NvimTreeToggle<CR>')

-- ALE fix (replaces Autoformat, same key)
vim.keymap.set('n', '<Leader>f', ':ALEFix<CR>')

-- CodeCompanion
vim.keymap.set('n', '<Leader>cc', ':CodeCompanionChat Toggle<CR>')
vim.keymap.set('n', '<Leader>ca', ':CodeCompanionActions<CR>')
