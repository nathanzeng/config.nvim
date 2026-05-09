-- There are some great use cases in this link
-- https://www.reddit.com/r/neovim/comments/1f7jj15/how_do_you_work_without_diffviewnvim/

vim.schedule(function()
  -- NOTE: using the actively maintained fork
  vim.pack.add({ 'https://github.com/dlyongemallo/diffview.nvim' })

  require('diffview').setup({
    file_panel = {
      win_config = {
        position = 'bottom',
        height = 10,
        -- Maintain the full cursorline in the file panel
        win_opts = { cursorlineopt = 'both' },
      },
    },
    -- Some custom file panel keymaps
    keymaps = {
      file_panel = {
        {
          'n',
          'gf',
          function()
            require('diffview.config').actions.goto_file_edit_close()
          end,
          { desc = 'Open the file in the previous tabpage' },
        },
        {
          'n',
          '<leader>gd',
          vim.cmd.DiffviewToggle,
          { desc = 'Toggle the diffview' },
        },
      },
    },
    show_help_hints = false,
  })

  vim.keymap.set('n', '<leader>gd', vim.cmd.DiffviewToggle, { desc = '[d]iff' })
end)
