return {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('nvim-tree').setup {}
    -- Don't do random things in the setup table, do it in the config function instead
    -- Also saw it in the on_attach as well I think
    local api = require 'nvim-tree.api'

    -- Toggle the tree
    vim.keymap.set('n', '<leader>tt', api.tree.toggle, { desc = 'Toggle tree' })

    -- Increase and decrease tree width
    vim.keymap.set('n', '<leader>t<right>', function()
      api.tree.resize { relative = 20 }
    end, { desc = 'Increase tree width' })

    vim.keymap.set('n', '<leader>t<left>', function()
      api.tree.resize { relative = -20 }
    end, { desc = 'Decrease tree width' })
  end,
}
