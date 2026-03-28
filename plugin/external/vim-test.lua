vim.pack.add({ 'https://github.com/vim-test/vim-test' })

-- These were written as vimscript in the README and this is what LLM gave me
vim.g['test#strategy'] = 'neovim'
vim.g['test#neovim#term_position'] = 'vert'

vim.keymap.set('n', '<leader>t', '<CMD>TestNearest<CR>', { desc = '[t]est nearest' })
vim.keymap.set('n', '<leader>td', '<CMD>TestNearest XDEBUG_SESSION=1<CR>', { desc = '[t]est [d]ebug nearest' })
vim.keymap.set('n', '<leader>tf', '<CMD>TestFile<CR>', { desc = '[t]est [f]ile' })
