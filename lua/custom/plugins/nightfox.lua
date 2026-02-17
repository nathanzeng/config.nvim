--NOTE: tweaked to make vue files look good
-- Diffview looks a little bit odd now however
return {
  'EdenEast/nightfox.nvim',
  lazy = false,
  priority = 1000, -- Make sure to load this before all the other start plugins.
  config = function()
    local palettes = {
      -- Everything defined under `all` will be applied to every style, can alternatively apply to specific themes
      nightfox = {
        -- Each palette defines these colors:
        --   black, red, green, yellow, blue, magenta, cyan, white, orange, pink
        --
        -- These colors have 3 shades: base, bright, and dim
        --
        -- Defining just a color defines it's base color

        -- Use a more colorblind friendly blue and magenta/purple
        blue = '#0072B2',
        magenta = '#6F6AE1',
        -- Use a pink that is closer to white so more discernable from cyan
        pink = '#e1a1de',
      },
    }

    local Color = require 'nightfox.lib.color'

    local background = '#192330'
    -- NOTE: these originally used the dim versions of the colors
    -- I didn't have the energy to import the shades library
    local diff_blue = Color.from_hex(background):blend(Color.from_hex '#719cd6', 0.35)
    local diff_red = Color.from_hex(background):blend(Color.from_hex '#c94f6d', 0.30)
    local diff_green = Color.from_hex(background):blend(Color.from_hex '#81b29a', 0.18)

    local specs = {
      nightfox = {
        -- The below file shows the default values for syntax
        -- https://github.com/EdenEast/nightfox.nvim/blob/main/lua/nightfox/palette/nightfox.lua
        syntax = {
          -- Specs allow you to define a value using either a color or template. If the string does
          -- start with `#` the string will be used as the path of the palette table. Defining just
          -- a color uses the base version of that color.
          keyword = 'orange',
          number = 'magenta',
          const = 'magenta',
          type = 'pink',
          preproc = 'blue',
        },
        diff = {
          add = diff_green:to_css(),
          delete = diff_red:to_css(),
          text = diff_blue:to_css(),
        },
      },
    }

    require('nightfox').setup { palettes = palettes, specs = specs }
    vim.cmd.colorscheme 'nightfox'
  end,
}
