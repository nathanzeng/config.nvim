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

local normalTheme = {
  a = function()
    if vim.bo.modified then
      return { bg = colors.white, fg = colors.darkgray, gui = 'bold' }
    else
      return { bg = colors.gray, fg = colors.black, gui = 'bold' }
    end
  end,
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
    c = { bg = colors.darkgray, fg = colors.gray },
  },
}

local function linesInFile()
  return vim.api.nvim_buf_line_count(0) .. ' lines'
end

local function hide(min_width)
  return function(str)
    if vim.fn.winwidth(0) < min_width then
      return ''
    end
    return str
  end
end

local function truncateToFirstChar(min_width)
  return function(str)
    if vim.fn.winwidth(0) < min_width then
      return str:sub(1, 1)
    end
    return str
  end
end

return {
  'nvim-lualine/lualine.nvim',
  config = function()
    require('lualine').setup {
      options = {
        theme = custom_gruvbox,
        section_separators = { left = '', right = '' },
        component_separators = { left = '│', right = '│' },
        -- TODO: would be nice if I could do this for the diffed files in the diffview too
        disabled_filetypes = { winbar = { 'qf', 'DiffviewFiles' } },
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
            fmt = hide(101),
          },
        },
        lualine_x = { linesInFile },
        lualine_y = { 'location' },
        lualine_z = { { 'mode', fmt = truncateToFirstChar(101) } },
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
