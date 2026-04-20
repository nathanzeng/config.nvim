-- There are some great use cases in this link
-- https://www.reddit.com/r/neovim/comments/1f7jj15/how_do_you_work_without_diffviewnvim/

vim.schedule(function()
  -- NOTE: using the actively maintained fork
  vim.pack.add({ 'https://github.com/dlyongemallo/diffview.nvim' })

  require('diffview').setup({
    keymaps = {
      file_panel = {
        -- Conflicts with leader key
        { { 'n', 'x' }, '<space>', false },
        -- TODO: I would like to upstream this
        {
          'n',
          'gf',
          function()
            require('diffview.config').actions.goto_file_edit()
            -- Close the last accessed tab (the diffview)
            vim.cmd.tabclose('#')
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
  })

  vim.keymap.set('n', '<leader>gd', vim.cmd.DiffviewToggle, { desc = '[d]iff' })
end)
