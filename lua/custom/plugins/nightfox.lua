return {
  'EdenEast/nightfox.nvim',
  lazy = false,
  priority = 1000, -- Make sure to load this before all the other start plugins.
  config = function()
    local specs = {
      nordfox = {
        -- The below file shows the default values for syntax
        -- https://github.com/EdenEast/nightfox.nvim/blob/main/lua/nightfox/palette/nightfox.lua
        syntax = {
          -- Specs allow you to define a value using either a color or template. If the string does
          -- start with `#` the string will be used as the path of the palette table. Defining just
          -- a color uses the base version of that color.
          -- TODO: this remains to be tested in the rphq repo
          keyword = 'orange',
          number = 'magenta',
          const = 'magenta',
          type = 'pink',
          preproc = 'blue',
        },
      },
    }

    -- TODO: I think I still do want to brighten up the diffs and not use teal

    require('nightfox').setup { specs = specs }
    vim.cmd.colorscheme 'nordfox'
  end,
}
