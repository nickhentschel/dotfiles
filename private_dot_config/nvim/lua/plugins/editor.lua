-- Editor plugins: autopairs, vim-go, polyglot, ale

return {
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {},
  },

  {
    'fatih/vim-go',
    ft = { 'go' },
    config = function()
      -- vim-go handles gofmt on save for Go files
      vim.g.go_fmt_command = 'gofmt'
      vim.g.go_fmt_autosave = 1
    end,
  },

  {
    'sheerun/vim-polyglot',
    init = function()
      -- Disable polyglot for filetypes handled by dedicated plugins
      vim.g.polyglot_disabled = { 'go', 'markdown', 'autoindent' }
    end,
  },

  {
    'dense-analysis/ale',
    config = function()
      vim.g.ale_linters = {
        sh         = { 'shellcheck' },
        yaml       = { 'yamllint' },
        dockerfile = { 'hadolint' },
      }
      vim.g.ale_linters_explicit = 1
      vim.g.ale_set_loclist      = 1
      vim.g.ale_set_quickfix     = 0
      vim.g.ale_open_list        = 0
    end,
  },
}
