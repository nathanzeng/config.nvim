return {
  'EdenEast/nightfox.nvim',
  priority = 1000, -- Make sure to load this before all the other start plugins.
  config = function()
    local palettes = {
      -- Everything defined under `all` will be applied to every style, can alternatively apply to specific themes
      all = {
        -- Each palette defines these colors:
        --   black, red, green, yellow, blue, magenta, cyan, white, orange, pink
        --
        -- These colors have 3 shades: base, bright, and dim
        --
        -- Defining just a color defines it's base color

        -- Use a more colorblind friendly blue and magenta/purple
        blue = '#0072B2',
        magenta = '#6F6AE1',
      },
    }

    local specs = {
      all = {
        syntax = {
          -- Specs allow you to define a value using either a color or template. If the string does
          -- start with `#` the string will be used as the path of the palette table. Defining just
          -- a color uses the base version of that color.
          --NOTE: playing around to try to make the vue files look good
          keyword = 'yellow',
          number = 'magenta',
          const = 'magenta',
        },
      },
    }

    require('nightfox').setup { palettes = palettes, specs = specs }
    vim.cmd.colorscheme 'nightfox'
  end,
}
