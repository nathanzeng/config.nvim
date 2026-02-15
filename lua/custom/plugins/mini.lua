-- Collection of various small independent plugins/modules
return {
  'nvim-mini/mini.nvim',
  version = '*',
  config = function()
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
    --  - ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup { n_lines = 500 }

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require('mini.surround').setup()

    require('mini.bufremove').setup()
    -- Don't delete the window when deleting the buffer (splits)
    vim.keymap.set('n', '<leader>bd', function()
      MiniBufremove.delete()
    end, { desc = '[b]uffer [d]elete' })

    -- Icons and mock the nvim-tree one
    require('mini.icons').setup()
    MiniIcons.mock_nvim_web_devicons()

    -- Highlight hex colors
    local hipatterns = require 'mini.hipatterns'
    hipatterns.setup {
      highlighters = {
        hex_color = hipatterns.gen_highlighter.hex_color(),
      },
    }
  end,
}
