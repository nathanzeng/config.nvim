vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Allegedly gives 24 bit color
vim.o.termguicolors = true

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

require 'options'

require 'keymaps'

-- require 'lazy-install'

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
