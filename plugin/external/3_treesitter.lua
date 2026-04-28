vim.pack.add({ 'https://github.com/nvim-treesitter/nvim-treesitter' })

local filetypes = {
  'bash',
  'c',
  'diff',
  'html',
  'lua',
  'luadoc',
  'markdown',
  'markdown_inline',
  'query',
  'vim',
  'vimdoc',
  'vue',
  'typescript',
  'javascript',
  'tsx',
  'jsx',
  'css',
  'php',
  'phpdoc',
  'json',
  'gitcommit',
  'gitignore',
  'git_rebase',
  'yaml',
  'graphql',
}
-- Force install on following line was neccesary when migrating from lazy
require('nvim-treesitter').install(filetypes)

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('treesitter', { clear = true }),
  pattern = filetypes,
  callback = function(args)
    -- Blacklist: treesitter does not work for graphql with our lighthouse resolvers and whatnot
    if args.match == 'graphql' then
      return
    end

    vim.treesitter.start()
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

-- Consider keeping the following (copied) code up to date with core:
-- Incremental selection, 'an' and 'in' defaults remapped to up and down arrow
vim.keymap.set({ 'x', 'o' }, '<up>', function()
  if vim.treesitter.get_parser(nil, nil, { error = false }) then
    require('vim.treesitter._select').select_parent(vim.v.count1)
  else
    vim.lsp.buf.selection_range(vim.v.count1)
  end
end, { desc = 'Select parent (outer) node' })

vim.keymap.set({ 'x', 'o' }, '<down>', function()
  if vim.treesitter.get_parser(nil, nil, { error = false }) then
    require('vim.treesitter._select').select_child(vim.v.count1)
  else
    vim.lsp.buf.selection_range(-vim.v.count1)
  end
end, { desc = 'Select child (inner) node' })
