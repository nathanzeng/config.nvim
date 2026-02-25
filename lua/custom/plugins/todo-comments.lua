-- Highlight keywords
-- TODO
-- HACK
-- WARN
-- PERF
-- NOTE
-- TEST
return {
  'folke/todo-comments.nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = { signs = false, keywords = { TODO = { color = 'warning' } }, highlight = {
    multiline = false,
  } },
}
