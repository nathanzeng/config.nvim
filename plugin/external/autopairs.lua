-- Autopairs and autotags for html
vim.schedule(function()
  vim.pack.add({ 'https://github.com/windwp/nvim-autopairs' })
  vim.pack.add({ 'https://github.com/windwp/nvim-ts-autotag' })

  require('nvim-autopairs').setup()
  require('nvim-ts-autotag').setup({
    opts = {
      enable_close_on_slash = true, -- Auto close on trailing </
    },
  })
end)
