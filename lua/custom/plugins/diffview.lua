-- There are some great use cases in this link
-- https://www.reddit.com/r/neovim/comments/1f7jj15/how_do_you_work_without_diffviewnvim/
return {
  'sindrets/diffview.nvim',
  config = function()
    local diffviewIsOpen = false

    require('diffview').setup {
      keymaps = {
        file_panel = {
          {
            'n',
            'gf',
            function()
              require('diffview.config').actions.goto_file_edit()
              -- Close the last accessed tab (the diffview)
              vim.cmd 'tabclose #'
              diffviewIsOpen = false
            end,
            { desc = 'Open the file in the previous tabpage' },
          },
        },
      },
    }

    -- TODO: this is a little bit hacky, there is a PR addressing this
    -- e.g. if you toggle close outside of the diffview everything will break
    local function toggle_diffview()
      if diffviewIsOpen then
        vim.cmd 'DiffviewClose'
        diffviewIsOpen = false
      else
        -- Save before entering the diff view just in case
        vim.cmd 'wa'
        vim.cmd 'DiffviewOpen'
        diffviewIsOpen = true
      end
    end

    vim.keymap.set('n', '<leader>gd', toggle_diffview, { desc = '[d]iff' })
  end,
}
