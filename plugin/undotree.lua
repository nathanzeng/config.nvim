-- Save undo history
vim.o.undofile = true

-- Undotree
vim.schedule(function()
  vim.cmd.packadd('nvim.undotree')

  vim.keymap.set('n', '<leader>u', function()
    require('undotree').open({ command = 'vnew' })
  end, { desc = '[u]ndo tree' })
end)
