vim.schedule(function()
  vim.pack.add({ 'https://github.com/folke/which-key.nvim' })

  require('which-key').setup({
    -- delay between pressing a key and opening which-key (milliseconds)
    -- this setting is independent of vim.o.timeoutlen
    delay = 500,
    -- Document existing key chains
    spec = {
      { '<leader>f', group = '[f]ind' },
      { '<leader>g', group = '[g]it' },
      { '<leader>l', group = '[l]SP' },
      { '<leader>b', group = '[b]uffer' },
    },
  })
end)
