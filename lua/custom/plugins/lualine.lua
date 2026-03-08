-- stylua: ignore
local colors = {
  nord1  = '#3B4252',
  nord3  = '#4C566A',
  nord5  = '#E5E9F0',
  nord6  = '#ECEFF4',
  nord7  = '#8FBCBB',
  nord8  = '#88C0D0',
  nord13 = '#EBCB8B',
}

local normalTheme = {
  a = function()
    if vim.bo.modified then
      return { fg = colors.nord1, bg = colors.nord6, gui = 'bold' }
    else
      return { fg = colors.nord1, bg = colors.nord8, gui = 'bold' }
    end
  end,
  b = { fg = colors.nord7, bg = colors.nord1 },
  c = { fg = colors.nord7, bg = colors.nord3 },
}

local custom_gruvbox = {
  normal = normalTheme,
  insert = normalTheme,
  visual = normalTheme,
  replace = normalTheme,
  command = normalTheme,
  inactive = {
    c = { fg = colors.nord7, bg = colors.nord3 },
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
      },
      sections = {},
      inactive_sections = {},
    }
  end,
}
