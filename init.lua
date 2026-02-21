vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Allegedly gives 24 bit color
vim.o.termguicolors = true

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

require 'options'
require 'keymaps'

-- Colorscheme
vim.pack.add({
  'https://github.com/EdenEast/nightfox.nvim'
})
vim.cmd.colorscheme('nordfox')

-- Oil
vim.pack.add({
  'https://github.com/stevearc/oil.nvim'
})
require("oil").setup({
  view_options = {
    -- Show files and directories that start with "."
    show_hidden = true,
  }
})
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

-- Mini
vim.pack.add({
  'https://github.com/nvim-mini/mini.nvim'
})
require('mini.ai').setup { n_lines = 500 }
require('mini.surround').setup()
require('mini.cmdline').setup()
require('mini.statusline').setup()
require('mini.icons').setup()
MiniIcons.mock_nvim_web_devicons()
