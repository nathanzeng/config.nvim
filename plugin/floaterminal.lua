local state = { floating = { buf = -1, win = -1 } }

-- Pass in width height and buf
local function create_floating_window(opts)
  opts = opts or {}

  -- Get current editor dimensions
  local ui = vim.api.nvim_list_uis()[1]
  local total_width = ui.width
  local total_height = ui.height

  -- Calculate width and height (default 60%)
  local width = opts.width or math.floor(total_width * 0.6)
  local height = opts.height or math.floor(total_height * 0.6)

  -- Calculate top-left corner to center the window
  local row = math.floor((total_height - height) * 0.3)
  local col = math.floor((total_width - width) / 2)

  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true)
  end

  -- Floating window options
  local win_opts = {
    style = 'minimal',
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    border = 'bold',
  }

  -- Open the window
  local win = vim.api.nvim_open_win(buf, true, win_opts)

  return { buf = buf, win = win }
end

local toggleTerminal = function()
  if not vim.api.nvim_win_is_valid(state.floating.win) then
    state.floating = create_floating_window { buf = state.floating.buf }
    if vim.bo[state.floating.buf].buftype ~= 'terminal' then
      vim.cmd.terminal()
    end
  else
    vim.api.nvim_win_hide(state.floating.win)
  end
end

vim.api.nvim_create_user_command('Floaterminal', toggleTerminal, {})
vim.keymap.set({ 'n', 't' }, '<C-t>', toggleTerminal)

-- Autocommand to enter insert mode in terminals
vim.api.nvim_create_autocmd({ 'BufEnter', 'TermOpen' }, {
  group = vim.api.nvim_create_augroup('floaterminal', { clear = true }),
  desc = 'Automatically enter Insert mode in terminals',
  pattern = '*',
  callback = function()
    if vim.bo.buftype == 'terminal' then
      vim.cmd 'startinsert'
    end
  end,
})
