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
  bForeground  = '#c9ba9b',
}

local function get_colors_respect_modified(modifiedColors, normalColors)
  if vim.bo.modified then
    return modifiedColors
  else
    return normalColors
  end
end

local normalTheme = {
  a = { bg = colors.gray, fg = colors.black, gui = 'bold' },
  b = function()
    return get_colors_respect_modified(
      { bg = colors.lightgray, fg = colors.white },
      { bg = colors.lightgray, fg = colors.bForeground }
    )
  end,
  c = function()
    return get_colors_respect_modified(
      { bg = colors.lightgray, fg = colors.white },
      { bg = colors.darkgray, fg = colors.gray }
    )
  end,
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
      options = {
        theme = custom_gruvbox,
        section_separators = { left = '', right = '' },
        component_separators = { left = '│', right = '│' },
        -- TODO: would be nice if I could do this for the diffed files in the diffview too
        disabled_filetypes = { winbar = { 'trouble', 'DiffviewFiles' } },
      },
      winbar = {
        lualine_a = {
          { 'filetype', separator = '', icon_only = true, colored = false, padding = { left = 1, right = 0 } },
          { 'filename', path = 0, file_status = false, padding = { left = 0, right = 1 } },
        },
        lualine_b = { 'diagnostics', 'diff', 'branch' },
        lualine_c = {
          {
            'filename',
            newfile_status = true, -- Display new file status (new file means no write after created)
            file_status = false,
            path = 1,
          },
        },
        lualine_x = { 'progress' },
        lualine_y = { 'location' },
        lualine_z = { 'mode' },
      },
      inactive_winbar = {
        lualine_c = { { 'filename', path = 1 } },
        lualine_x = { 'location' },
      },
      sections = {},
      inactive_sections = {},
    }
  end,
}
