vim.keymap.set('n', '_', '<CMD>e .<CR>', { desc = 'Open CWD' })

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('dir_nathan'),
  pattern = 'directory',
  callback = function()
    vim.bo.bufhidden = 'wipe'
    vim.opt_local.foldcolumn = '0'
    vim.opt_local.statuscolumn = "%l %{%v:lua.require'dir'.directory()%}"
  end,
})
