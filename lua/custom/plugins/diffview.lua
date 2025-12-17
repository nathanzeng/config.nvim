return {
  'sindrets/diffview.nvim',
  config = function()
    require('diffview').setup {}
    vim.keymap.set('n', '<leader>gd', '<cmd>DiffviewOpen<CR>', { desc = '[d]iff' })
  end,
}
