-- Highlight keywords
-- TODO:
-- HACK:
-- WARN:
-- PERF:
-- NOTE:
-- TEST:
vim.pack.add({ 'https://github.com/folke/todo-comments.nvim' })

require('todo-comments').setup({
  signs = false,
  keywords = { TODO = { color = 'warning' } },
  highlight = {
    multiline = false,
  },
})
