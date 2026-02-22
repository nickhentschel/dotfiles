-- UI plugins: lualine, nvim-tree, indent-blankline, colorscheme

return {
  {
    'tomasiser/vim-code-dark',
    priority = 1000,
    config = function()
      vim.cmd('colorscheme codedark')
      vim.api.nvim_set_hl(0, 'MatchParen', { ctermbg = 4, bg = 'lightblue' })
    end,
  },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      options = {
        theme = 'codedark',
        component_separators = '',
        section_separators = '',
      },
      extensions = { 'nvim-tree', 'fzf', 'ale' },
    },
  },

  {
    'nvim-tree/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      sort_by = 'case_sensitive',
      view = { width = 30 },
      renderer = { group_empty = true },
      filters = { dotfiles = false },
    },
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {
      indent = { char = '▏' },
    },
  },
}
