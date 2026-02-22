-- Core plugins: tpope suite, tmux-navigator, tabular, fzf

return {
  { 'tpope/vim-commentary' },
  { 'tpope/vim-endwise' },
  { 'tpope/vim-repeat' },
  { 'tpope/vim-sleuth' },
  { 'tpope/vim-surround' },
  { 'tpope/vim-unimpaired' },

  { 'christoomey/vim-tmux-navigator' },

  { 'godlygeek/tabular' },

  {
    'junegunn/fzf',
    build = './install --all --no-fish',
    dir = '~/.fzf',
  },
  {
    'junegunn/fzf.vim',
    config = function()
      vim.g.fzf_layout = { down = '~40%' }
      vim.g.fzf_buffers_jump = 1
      vim.g.fzf_action = {
        ['ctrl-s'] = 'split',
        ['ctrl-v'] = 'vsplit',
      }

      vim.api.nvim_create_user_command('Find', function(opts)
        local bang = opts.bang
        local args = opts.args
        local preview_opts = bang
          and require('fzf-lua').defaults  -- fallback; handled via fzf#vim below
          or nil
        -- Use vimscript command for fzf#vim#grep compatibility
        local cmd = string.format(
          'rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" %s',
          vim.fn.shellescape(args)
        )
        vim.fn['fzf#vim#grep'](
          cmd,
          1,
          bang and vim.fn['fzf#vim#with_preview']('up:60%')
               or  vim.fn['fzf#vim#with_preview']('right:50%:hidden', '?'),
          bang and 1 or 0
        )
      end, { bang = true, nargs = '*' })

      if vim.fn.executable('rg') == 1 then
        vim.opt.grepprg = 'rg --vimgrep --color=never'
      end
    end,
  },
}
