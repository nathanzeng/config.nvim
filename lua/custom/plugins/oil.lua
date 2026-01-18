-- NOTE: float seems like it could be cool
return {
  'stevearc/oil.nvim',
  dependencies = { { 'nvim-mini/mini.icons', opts = {} } },
  config = function()
    require('oil').setup {
      view_options = {
        show_hidden = true,
      },
      -- These keymaps apply to oil buffers only
      keymaps = {
        -- Collides with floaterminal
        -- Was originally open file in a new tab
        ['<C-t>'] = false,
        -- Live grep in current directory
        ['<leader>fg'] = {
          function()
            require('telescope.builtin').live_grep {
              cwd = require('oil').get_current_dir(),
            }
          end,
          mode = 'n',
          --nowait to see if there is a longer key combo elsewhere
          nowait = true,
          desc = 'Live grep in the current directory',
        },
        -- Find files in current directory
        ['<leader>ff'] = {
          function()
            require('telescope.builtin').find_files {
              cwd = require('oil').get_current_dir(),
            }
          end,
          mode = 'n',
          nowait = true,
          desc = 'Find files in the current directory',
        },
      },
    }
    vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
  end,
  -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
  lazy = false,
}
