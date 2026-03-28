return {
  enabled = false,
  'olimorris/codecompanion.nvim',
  version = '^19.0.0',
  cmd = { 'CodeCompanionChat' },
  opts = {},
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    require('codecompanion').setup {
      adapters = {
        http = {
          gemini = function()
            return require('codecompanion.adapters').extend('gemini', {
              schema = {
                model = {
                  default = 'gemini-3-flash-preview',
                },
              },
            })
          end,
        },
      },
      interactions = {
        chat = {
          adapter = 'gemini',
          model = 'gemini-3-flash-preview',
        },
      },
    }
  end,
}
