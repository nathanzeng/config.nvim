-- stylua: ignore
local colors = {
  black        = '#282828',
  white        = '#ebdbb2',
  red          = '#fb4934',
  green        = '#b8bb26',
  blue         = '#83a598',
  yellow       = '#fe8019',
  gray         = '#a89984',
  darkgray     = '#3c3836',
  lightgray    = '#504945',
  inactivegray = '#7c6f64',
  bForeground = '#c9ba9b',
}

local normalTheme = {
  a = { bg = colors.gray, fg = colors.black, gui = 'bold' },
  b = { bg = colors.lightgray, fg = colors.bForeground },
  c = { bg = colors.darkgray, fg = colors.gray },
}

local custom_gruvbox = {
  normal = normalTheme,
  insert = normalTheme,
  visual = normalTheme,
  replace = normalTheme,
  command = normalTheme,
  inactive = {
    a = { bg = colors.darkgray, fg = colors.gray, gui = 'bold' },
    b = { bg = colors.darkgray, fg = colors.gray },
    c = { bg = colors.darkgray, fg = colors.gray },
  },
}

return {
  'nvim-lualine/lualine.nvim',
  config = function()
    require('lualine').setup {
      options = { theme = custom_gruvbox },
      sections = {
        lualine_a = {
          { 'filetype', separator = '', icon_only = true, colored = false, padding = { left = 1, right = 0 } },
          { 'filename', path = 0, padding = { left = 0, right = 1 } },
        },
        lualine_c = {
          {
            'filename',
            newfile_status = true, -- Display new file status (new file means no write after created)
            -- 0: Just the filename
            -- 1: Relative path
            -- 2: Absolute path
            -- 3: Absolute path, with tilde as the home directory
            -- 4: Filename and parent dir, with tilde as the home directory
            path = 3,
            color = function()
              if vim.bo.modified then
                return { bg = colors.lightgray, fg = colors.white }
              else
                return { bg = colors.darkgray, fg = colors.gray }
              end
            end,
          },
        },
        lualine_x = { 'progress' },
        lualine_y = { 'location' },
        lualine_z = { 'mode' },
      },
    }
  end,
}
