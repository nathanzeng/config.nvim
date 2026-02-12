-- [[ Setting options ]]
-- See `:help vim.o`
-- For more options, you can see `:help option-list`
-- NOTE: Do not use `vim.opt` as it will be deprecated https://github.com/neovim/neovim/issues/20107

-- Add line numbers and make them relative
vim.o.number = true
vim.o.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'a'

-- Disable status line since I'm using lualine to put that at the top in winbar
vim.o.laststatus = 0

-- COMMAND LINE OPTIONS
-- Don't show the mode
vim.o.showmode = false
-- Don't show this ruler thing that is line number and file progress
vim.o.ruler = false
-- Show partial command flickers j and k when scrolling
vim.o.showcmd = false

-- Keep the cursor fat in all modes, use highlighting for insert modes
-- TODO: what is the select mode shown in the status line after autocompleting a function
-- feel like that should get the orange highlight
vim.api.nvim_set_hl(0, 'InsertCursor', { bg = '#C68642' })
vim.o.guicursor = 'i-r-t:block-InsertCursor'

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
-- TODO: kickstart had this at 300
-- I think that is too fast/hard when whichkey is turned off
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-options-guide`
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Visual only controlling how wide tabs look
vim.o.tabstop = 4

-- Do not insert comments automatically with o and O
vim.api.nvim_create_autocmd('FileType', {
  desc = 'Do not insert comments automatically with o and O',
  pattern = '*',
  callback = function()
    vim.opt.formatoptions:remove 'o'
  end,
})

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

-- Globally set window borders to rounded
vim.o.winborder = 'rounded'

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
