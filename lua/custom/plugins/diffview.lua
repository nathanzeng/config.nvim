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
        vim.cmd 'DiffviewOpen'
        diffviewIsOpen = true
      end
    end

    vim.keymap.set('n', '<leader>gd', toggle_diffview, { desc = '[d]iff' })
  end,
}
