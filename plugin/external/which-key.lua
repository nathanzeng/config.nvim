-- NOTE: Plugins can also be configured to run Lua code when they are loaded.
--
-- This is often very useful to both group configuration, as well as handle
-- lazy loading plugins that don't need to be loaded immediately at startup.
--
-- For example, in the following configuration, we use:
--  event = 'VimEnter'
--
-- which loads which-key before all the UI elements are loaded. Events can be
-- normal autocommands events (`:help autocmd-events`).
--
-- Then, because we use the `opts` key (recommended), the configuration runs
-- after the plugin has been loaded as `require(MODULE).setup(opts)`.
vim.pack.add({ 'https://github.com/folke/which-key.nvim' })

require('which-key').setup({
  -- delay between pressing a key and opening which-key (milliseconds)
  -- this setting is independent of vim.o.timeoutlen
  delay = 500,
  -- Document existing key chains
  spec = {
    { '<leader>f', group = '[f]ind' },
    { '<leader>g', group = '[g]it' },
    { '<leader>l', group = '[l]SP' },
    { '<leader>b', group = '[b]uffer' },
  },
})
