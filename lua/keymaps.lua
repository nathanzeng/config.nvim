-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`
vim.keymap.set('n', '<leader>w', '<cmd>w<CR>', { desc = '[w]rite' })

-- Enter and Shift+Enter to get new line below and above without entering insert mode
vim.keymap.set('n', '<CR>', 'o<Esc>')
vim.keymap.set('n', '<S-CR>', 'O<Esc>')

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '<leader>x', '<cmd>xa!<CR>', { desc = 'Quit [x]a!' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

--  Use CTRL+<hjkl> to switch between windows
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Resize windows
vim.keymap.set('n', '<C-left>', '<C-w><', { desc = 'Decrease window width' })
vim.keymap.set('n', '<C-right>', '<C-w>>', { desc = 'Increase window width' })
vim.keymap.set('n', '<C-up>', '<C-w>-', { desc = 'Decrease window height' })
vim.keymap.set('n', '<C-down>', '<C-w>+', { desc = 'Increase window height' })

-- NOTE: the native functionality for q is to record a macro, removing that for now
vim.keymap.set('n', 'q', '<cmd>q<CR>', { desc = '[q]uit window' })

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>D', vim.diagnostic.setloclist, { desc = 'Diagnostic quickfix list, for buffer' })

vim.keymap.set('n', '<leader>d', function()
  vim.diagnostic.open_float()
end, { desc = '[d]iagnostic window' })

local function toggle_spell_check()
  vim.o.spell = not vim.o.spell
  if vim.o.spell then
    vim.notify('Spell check enabled')
  else
    vim.notify('Spell check disabled')
  end
end

-- NOTE: I'm making this z for now so I remember z= for the suggestions, may want to remap
vim.keymap.set('n', '<leader>z', toggle_spell_check, { desc = 'Toggle spell check' })
-- Treate camel cased as separate words
vim.o.spelloptions = 'camel'

-- More ergonomic keymap for pasting from the yank register
vim.keymap.set({ 'n', 'x' }, '<leader>p', '"0p', { desc = '[p]aste from yank register "0' })

-- Restart neovim
vim.keymap.set('n', '<leader>n', '<cmd>restart<CR>', { desc = '[n]eovim restart' })

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
