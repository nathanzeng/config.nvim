-- There are some great use cases in this link
-- https://www.reddit.com/r/neovim/comments/1f7jj15/how_do_you_work_without_diffviewnvim/
return {
  'sindrets/diffview.nvim',
  config = function()
    require('diffview').setup {}

    local diffviewIsOpen = false
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
