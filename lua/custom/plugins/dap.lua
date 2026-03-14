return {
  'mfussenegger/nvim-dap',
  config = function()
    local dap = require 'dap'

    local map = function(mode, keys, func, desc)
      mode = mode or 'n'
      vim.keymap.set(mode, keys, func, { desc = 'Debug: ' .. desc })
    end

    map('n', '<leader>dc', dap.continue, 'Start/[c]ontinue')
    map('n', '<leader>dt', dap.terminate, '[t]erminate')
    map('n', '<leader>di', dap.step_into, 'Step [i]nto')
    map('n', '<right>', dap.step_over, '-> Step Over')
    map('n', '<leader>do', dap.step_out, 'Step [o]ut')
    map('n', '<leader>db', dap.toggle_breakpoint, 'Toggle [b]reakpoint')
    map('n', '<leader>dB', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, 'Set [B]reakpoint on condition')

    -- TODO: we should figure out if we can do this in our ui
    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    -- map('n', '<F7>', require('dapui').toggle, 'See last session result')

    -- Change breakpoint icons
    -- TODO: I want these to be theme colors instead of hardcodes
    vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
    vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
    local breakpoint_icons = {
      Breakpoint = '',
      BreakpointCondition = '',
      BreakpointRejected = '',
      LogPoint = '',
      Stopped = '',
    }
    for type, icon in pairs(breakpoint_icons) do
      local tp = 'Dap' .. type
      local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
      vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
    end

    -- Configure DAP for PHP
    dap.adapters.php = {
      type = 'executable',
      command = 'node',
      args = { vim.fn.expand '~/workspace/nvim/vscode-php-debug/out/phpDebug.js' },
    }

    dap.configurations.php = {
      {
        type = 'php',
        request = 'launch',
        name = 'Listen for Xdebug',
        port = 9003,
      },
    }
  end,
}
