return {
  'mfussenegger/nvim-dap',
  version = '*',
  keys = {
    {
      '<leader>ds',
      function()
        require('dap').continue()
      end,
      desc = 'Start/Continue',
    },
    {
      '<leader>di',
      function()
        require('dap').step_into()
      end,
      desc = 'Step Into',
    },
    {
      '<right>',
      function()
        require('dap').step_over()
      end,
      desc = 'Step Over',
    },
    {
      '<leader>do',
      function()
        require('dap').step_out()
      end,
      desc = 'Step Out',
    },
    {
      '<leader>db',
      function()
        require('dap').toggle_breakpoint()
      end,
      desc = 'Toggle Breakpoint',
    },
    {
      '<leader>dB',
      function()
        require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ')
      end,
      desc = 'Set Breakpoint',
    },
    -- TODO: we should figure out if we can do this in our ui
    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    -- {
    --   '<F7>',
    --   function()
    --     require('dapui').toggle()
    --   end,
    --   desc = 'Debug: See last session result.',
    -- },
  },
  config = function()
    local dap = require 'dap'

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
