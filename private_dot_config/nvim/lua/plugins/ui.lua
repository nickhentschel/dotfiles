-- UI plugins: lualine, nvim-tree, indent-blankline, colorscheme

return {
  {
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()
      require('onedark').setup({
        style = 'dark', -- dark, darker, cool, deep, warm, warmer, light
        transparent = false,
        term_colors = true,
        code_style = {
          comments = 'italic',
          keywords = 'none',
          functions = 'none',
          strings = 'none',
          variables = 'none',
        },
        diagnostics = {
          darker = true,
          undercurl = true,
          background = true,
        },
      })
      require('onedark').load()
    end,
  },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      options = {
        theme = 'onedark',
        component_separators = '',
        section_separators = '',
      },
      extensions = { 'nvim-tree', 'fzf' },
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
