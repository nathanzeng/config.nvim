local M = {}

local function stl_hl(name)
  return string.format('%%#%s#', name)
end

local double_space = '  '

function M.directory()
  if vim.v.virtnum ~= 0 then
    return double_space
  end

  local name = vim.api.nvim_buf_get_lines(0, vim.v.lnum - 1, vim.v.lnum, true)[1]

  local icon, icon_color
  if name:sub(-1) == '/' then
    icon, icon_color = MiniIcons.get('directory', name)
  else
    icon, icon_color = MiniIcons.get('file', name)
  end

  return table.concat({
    stl_hl(icon_color),
    icon,
    double_space,
  })
end

return M
