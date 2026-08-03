local api = vim.api
local TIMEOUT = 3000
local dir_init_buf = nil
local augroup = api.nvim_create_augroup('dir_nathan')
local default_numberwidth = vim.o.numberwidth
local default_statuscolumn = vim.o.statuscolumn

-- NOTE: this pattern won't work for `:e some/arbitrary/path`
local function set_init_buf()
  if vim.bo.filetype ~= 'directory' then
    dir_init_buf = api.nvim_get_current_buf()
  end
end

local function return_to_init_buf()
  if dir_init_buf == nil then
    vim.notify('dir oopsie', vim.log.levels.ERROR)
    return
  end
  api.nvim_set_current_buf(dir_init_buf)
end

local function hl_line_like_yank()
  local ns = api.nvim_create_namespace('dir_nathan.yank_line')
  local row = api.nvim_win_get_cursor(0)[1] - 1

  vim.hl.range(0, ns, 'IncSearch', { row, 0 }, { row, -1 }, {
    timeout = 150,
  })
end

vim.keymap.set('n', '_', function()
  set_init_buf()
  vim.cmd.edit('.')
end, { desc = 'Open CWD' })

vim.keymap.set('n', '-', function()
  set_init_buf()
  return '<Plug>(nvim-dir-up)'
end, { expr = true, desc = 'Open parent directory' })

-- Window-local state that depends on currently displayed buffer
api.nvim_create_autocmd('BufEnter', {
  callback = function(args)
    if vim.bo[args.buf].filetype == 'directory' then
      vim.wo.numberwidth = 5
      vim.wo.statuscolumn = "%l %{%v:lua.require'dir_icons'.directory()%}"
    else
      vim.wo.numberwidth = default_numberwidth
      vim.wo.statuscolumn = default_statuscolumn
    end
  end,
})

api.nvim_create_autocmd('FileType', {
  group = augroup,
  pattern = 'directory',
  callback = function(args)
    -- Delete dir buffers after we leave them
    vim.bo.bufhidden = 'wipe'

    -- AI gave this to me to make entries beginning with "." have comment hl
    vim.api.nvim_buf_call(args.buf, function()
      vim.cmd([[syntax match Comment /^\..*$/]])
    end)

    local dir_name = api.nvim_buf_get_name(0)

    -- Close
    vim.keymap.set('n', '<C-c>', function()
      return_to_init_buf()
    end, { desc = 'Close dir buffer', buf = 0 })

    -- Add entry
    vim.keymap.set('n', 'o', function()
      vim.ui.input({ prompt = 'Add: ' }, function(input)
        if input == nil then
          return
        end
        local abs_filename = dir_name .. input

        -- Either touch or mkdir based on presence of /
        if vim.endswith(abs_filename, '/') then
          local obj = vim.system({ 'mkdir', abs_filename }, { text = true }):wait(TIMEOUT)
          if obj.code ~= 0 then
            error('System error: ' .. (obj.stderr or 'nil'))
            return
          end
        else
          local obj = vim.system({ 'touch', abs_filename }, { text = true }):wait(TIMEOUT)
          if obj.code ~= 0 then
            error('System error: ' .. (obj.stderr or 'nil'))
            return
          end
        end

        vim.cmd.normal({ args = { 'R' } })
        -- Brings the cursor to the newly created entry
        vim.fn.search('\\V' .. input)
      end)
    end, { desc = 'Create dir entry', buf = 0 })

    -- Delete entry
    vim.keymap.set('n', 'dd', function()
      local filename = dir_name .. api.nvim_get_current_line()

      local confirm_msg = 'Delete: ' .. filename
      local confirm = vim.fn.confirm(confirm_msg, '&Yes\n&No\n&Cancel')

      if confirm == 1 then
        local obj = vim.system({ 'rm', '-r', filename }, { text = true }):wait(TIMEOUT)
        if obj.code ~= 0 then
          error('System error: ' .. (obj.stderr or 'nil'))
          return
        end
      end

      vim.cmd.normal({ args = { 'R' } })
    end, { desc = 'Delete dir entry', buf = 0 })

    -- Yank entry
    vim.keymap.set('n', 'yy', function()
      local filename = dir_name .. api.nvim_get_current_line()

      hl_line_like_yank()
      vim.fn.setreg('', filename)
      vim.notify('Full path yanked')
    end, { desc = 'Yank dir entry full path', buf = 0 })

    vim.keymap.set('n', '<leader>yy', function()
      local filename = dir_name .. api.nvim_get_current_line()

      hl_line_like_yank()
      vim.fn.setreg('+', filename)
      vim.notify('Full path yanked to clipboard')
    end, { desc = 'Yank dir entry full path to clipboard', buf = 0 })

    -- Move entry
    vim.keymap.set('n', 'm', function()
      local filename = dir_name .. api.nvim_get_current_line()

      vim.ui.input({ prompt = 'Move to: ' }, function(input)
        if input == nil then
          return
        end

        local obj = vim.system({ 'mv', filename, input }, { text = true }):wait(TIMEOUT)
        if obj.code ~= 0 then
          error('System error: ' .. (obj.stderr or 'nil'))
          return
        end

        vim.cmd.normal({ args = { 'R' } })
      end)
    end, { desc = 'Move dir entry under cursor', buf = 0 })

    -- Rename entry
    vim.keymap.set('n', 'r', function()
      local filename = dir_name .. api.nvim_get_current_line()

      vim.ui.input({ prompt = 'Rename: ', default = api.nvim_get_current_line() }, function(input)
        if input == nil then
          return
        end

        local obj = vim.system({ 'mv', filename, dir_name .. input }, { text = true }):wait(TIMEOUT)
        if obj.code ~= 0 then
          error('System error: ' .. (obj.stderr or 'nil'))
          return
        end

        vim.cmd.normal({ args = { 'R' } })
        -- Brings the cursor to the newly renamed entry
        vim.fn.search('\\V' .. input)
      end)
    end, { desc = 'Rename entry under cursor', buf = 0 })

    -- Copy entry
    vim.keymap.set('n', 'c', function()
      local filename = dir_name .. api.nvim_get_current_line()

      vim.ui.input({ prompt = 'Copy to: ' }, function(input)
        if input == nil then
          return
        end

        local obj = vim.system({ 'cp', '-R', filename, input }, { text = true }):wait(TIMEOUT)
        if obj.code ~= 0 then
          error('System error: ' .. (obj.stderr or 'nil'))
          return
        end

        vim.cmd.normal({ args = { 'R' } })
      end)
    end, { desc = 'Copy dir entry under cursor', buf = 0 })

    -- Open entry in vsplit
    vim.keymap.set('n', '<C-v>', function()
      vim.cmd.vsplit()
      vim.cmd([[execute "normal \<CR>"]])
      vim.cmd.wincmd('p')
      return_to_init_buf()
      vim.cmd.wincmd('p')
    end, { desc = 'Open dir entry in vertical split', buf = 0 })

    -- Telescope stuff
    vim.keymap.set('n', '<leader>ff', function()
      require('telescope.builtin').find_files({
        cwd = dir_name,
      })
    end, { desc = 'Telescope find files (scoped to dir)', buf = 0 })

    vim.keymap.set('n', '<leader>fg', function()
      require('telescope.builtin').live_grep({
        cwd = dir_name,
      })
    end, { desc = 'Telescope find grep (scoped to dir)', buf = 0 })
  end,
})
