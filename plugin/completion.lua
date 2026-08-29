vim.o.autocomplete = true
vim.o.complete = 'o'
vim.o.completeopt = { 'menuone', 'noinsert', 'popup', 'fuzzy' }
vim.opt.shortmess:append('c')
vim.o.pumheight = 10

local function pum(active, inactive)
  return function()
    if vim.fn.pumvisible() ~= 0 then
      return active
    else
      return inactive
    end
  end
end

-- This makes <C-n> and <C-p> not do automatic insertion
vim.keymap.set('i', '<C-n>', pum('<Down>', '<C-n>'), { expr = true })
vim.keymap.set('i', '<C-p>', pum('<Up>', '<C-p>'), { expr = true })
