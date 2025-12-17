return {
  'sindrets/diffview.nvim',
  config = function()
    require('diffview').setup {}
    vim.keymap.set('n', '<leader>git', '<cmd>DiffviewOpen<CR>', { desc = '[git] Diff' })
  end,
}
