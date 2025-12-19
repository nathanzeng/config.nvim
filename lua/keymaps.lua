-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Save buffer
vim.keymap.set('n', '<leader>w', '<cmd>w<CR>', { desc = 'Save' })

-- Enter and Shift+Enter to get new line below and above without entering insert mode
vim.keymap.set('n', '<CR>', 'o<Esc>')
vim.keymap.set('n', '<S-CR>', 'O<Esc>')

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- TODO: not sure if I love this, might want to use q for quit
-- Diagnostic keymaps
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- NOTE: This was originally double escape in kickstart, but that doesn't work
-- This does have some conflicts like if you want to use vim in the neovim terminal
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Left and right arrow in normal mode scroll the page
vim.keymap.set('n', '<left>', '<C-y>')
vim.keymap.set('n', '<right>', '<C-e>')
-- Up and down arrow jump by half page
vim.keymap.set('n', '<down>', '<C-d>')
vim.keymap.set('n', '<up>', '<C-u>')

--  Use CTRL+<hjkl> to switch between windows
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes

-- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

-- TODO: I think I want a keybind for :xa, save all and close

-- TODO: Might want to enable this for the insert modes too

-- Page down and up for buffer next and previous
vim.keymap.set('n', '<PageDown>', '<cmd>bnext<CR>')
vim.keymap.set('n', '<PageUp>', '<cmd>bprev<CR>')
vim.keymap.set('n', '<leader>bd', '<cmd>bd<CR><cmd>bprev<CR>', { desc = 'Close buffer' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- vim: ts=2 sts=2 sw=2 et
