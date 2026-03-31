-- UI plugins: lualine, nvim-tree, indent-blankline, colorscheme

return {
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    priority = 1000,
    config = function()
      require('rose-pine').setup({
        variant = 'auto', -- auto, main, moon, dawn
        dark_variant = 'main',
        dim_inactive_windows = false,
        extend_background_behind_borders = true,
        enable = {
          terminal = true,
        },
        styles = {
          transparency = false,
        },
      })
      vim.cmd('colorscheme rose-pine')
    end,
  },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      options = {
        theme = 'rose-pine',
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
