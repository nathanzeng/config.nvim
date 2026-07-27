local api = vim.api
local TIMEOUT = 3000

vim.keymap.set('n', '_', '<CMD>e .<CR>', { desc = 'Open CWD' })

-- TODO: error handling on every vim.system call
api.nvim_create_autocmd('FileType', {
  group = api.nvim_create_augroup('dir_nathan'),
  pattern = 'directory',
  callback = function()
    vim.bo.bufhidden = 'wipe'
    vim.opt_local.foldcolumn = '0'
    vim.opt_local.statuscolumn = "%l %{%v:lua.require'dir_icons'.directory()%}"

    local dir_name = api.nvim_buf_get_name(0)

    -- Close
    vim.keymap.set('n', '<C-c>', function()
      MiniBufremove.delete()
    end, { desc = 'Close dir buffer', buf = 0 })

    -- Add entry
    vim.keymap.set('n', 'o', function()
      vim.ui.input({ prompt = 'Filename: ' }, function(input)
        if input == nil then
          return
        end
        local abs_filename = dir_name .. input

        -- Either touch or mkdir based on presence of /
        if vim.endswith(abs_filename, '/') then
          vim.system({ 'mkdir', abs_filename }):wait(TIMEOUT)
        else
          vim.system({ 'touch', abs_filename }):wait(TIMEOUT)
        end

        vim.cmd.normal({ args = { 'R' } })
        -- Brings the cursor to the newly created entry
        vim.fn.search('\\V' .. input)
      end)
    end, { desc = 'Create dir entry', buf = 0 })

    -- Delete entry
    vim.keymap.set('n', 'dd', function()
      local filename = dir_name .. api.nvim_get_current_line()

      local confirm_msg = 'Delete ' .. filename
      local confirm = vim.fn.confirm(confirm_msg, '&Yes\n&No\n&Cancel')

      if confirm == 1 then
        vim.system({ 'rm', '-r', filename }):wait(TIMEOUT)
      end

      vim.cmd.normal({ args = { 'R' } })
    end, { desc = 'Delete dir entry', buf = 0 })

    -- TODO: would be nice if these yank maps highlighted like normal
    -- Yank entry
    vim.keymap.set('n', 'yy', function()
      local filename = dir_name .. api.nvim_get_current_line()

      vim.fn.setreg('', filename)
      vim.notify('Full path yanked')
    end, { desc = 'Yank dir entry full path', buf = 0 })

    vim.keymap.set('n', '<leader>yy', function()
      local filename = dir_name .. api.nvim_get_current_line()

      vim.fn.setreg('+', filename)
      vim.notify('Full path yanked to clipboard')
    end, { desc = 'Yank dir entry full path to clipboard', buf = 0 })

    -- Move entry
    vim.keymap.set('n', 'm', function()
      local filename = dir_name .. api.nvim_get_current_line()

      vim.ui.input({ prompt = 'Destination: ' }, function(input)
        if input == nil then
          return
        end

        vim.system({ 'mv', filename, input }):wait(TIMEOUT)
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

        vim.system({ 'mv', filename, dir_name .. input }):wait(TIMEOUT)
        vim.cmd.normal({ args = { 'R' } })
        -- Brings the cursor to the newly renamed entry
        vim.fn.search('\\V' .. input)
      end)
    end, { desc = 'Rename entry under cursor', buf = 0 })

    -- Copy entry
    vim.keymap.set('n', 'c', function()
      local filename = dir_name .. api.nvim_get_current_line()

      vim.ui.input({ prompt = 'Destination: ' }, function(input)
        if input == nil then
          return
        end

        vim.system({ 'cp', filename, input, '-r' }):wait(TIMEOUT)
        vim.cmd.normal({ args = { 'R' } })
      end)
    end, { desc = 'Copy dir entry under cursor', buf = 0 })

    -- Open entry in vsplit
    vim.keymap.set('n', '<C-v>', function()
      vim.cmd.vsplit()
      vim.cmd([[execute "normal \<CR>"]])
      vim.cmd.wincmd('p')
      MiniBufremove.delete()
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
