-- Claude integration via codecompanion.nvim

return {
  {
    'olimorris/codecompanion.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
    },
    config = function()
      require('codecompanion').setup({
        adapters = {
          anthropic = function()
            return require('codecompanion.adapters').extend('anthropic', {
              env = { api_key = 'ANTHROPIC_API_KEY' },
            })
          end,
        },
        strategies = {
          chat   = { adapter = 'anthropic' },
          inline = { adapter = 'anthropic' },
        },
      })
    end,
  },
}
