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

-- Useful plugin to show you pending keybinds.
return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  opts = {
    -- delay between pressing a key and opening which-key (milliseconds)
    -- this setting is independent of vim.o.timeoutlen
    delay = 250,
    icons = {
      -- set icon mappings to true if you have a Nerd Font
      mappings = vim.g.have_nerd_font,
      -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
      -- default which-key.nvim defined Nerd Font icons, otherwise define a string table
      keys = {},
    },

    -- TODO: Git [H]unk from gitsigns isn't enabled by default, submit issue/PR?
    -- Document existing key chains
    spec = {
      { '<leader>f', group = '[f]ind' },
      { '<leader>g', group = 'Git' },
      { '<leader>l', group = 'LSP' },
    },
  },
}
