-- NOTE: there exist other commands but this is all I'm mapping for now
return {
  'vim-test/vim-test',
  config = function()
    vim.keymap.set('n', '<leader>t', '<CMD>TestNearest<CR>', { desc = '[t]est nearest' })
    vim.keymap.set('n', '<leader>T', '<CMD>TestFile<CR>', { desc = '[T]est file' })
  end,
}
