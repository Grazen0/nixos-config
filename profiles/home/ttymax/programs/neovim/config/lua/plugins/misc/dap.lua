return {
  {
    'mfussenegger/nvim-dap',
    dependencies = { 'rcarriga/nvim-dap-ui' },
    cmd = { 'DapContinue', 'DapToggleBreakpoint', 'DapNew' },
    keys = {
      { '<F5>', '<cmd>DapContinue<CR>' },
      { '<F10>', '<cmd>DapStepOver<CR>' },
      { '<F11>', '<cmd>DapStepInto<CR>' },
      { '<S-F11>', '<cmd>DapStepOut<CR>' },
      {
        '<C-S-F5>',
        function() require('dap').restart() end,
        desc = 'Restart nvim-dap session',
      },
      {
        '<S-F5>',
        function()
          require('dap').disconnect()
          require('dapui').close()
        end,
        desc = 'Terminate nvim-dap session',
      },
      { '<leader>b', '<cmd>DapToggleBreakpoint<CR>' },
      {
        '<leader>B',
        function()
          local condition = vim.fn.input('Breakpoint condition: ')
          require('dap').set_breakpoint(condition)
        end,
      },
    },
    opts = function()
      local configs = {
        codelldb = {
          name = 'Launch lldb (custom file)',
          type = 'codelldb',
          request = 'launch',
          program = function()
            return vim.fn.input(
              'Path to executable: ',
              vim.fn.getcwd() .. '/',
              'file'
            )
          end,
          cwd = '${workspaceFolder}',
        },
      }

      return {
        adapters = {
          codelldb = {
            type = 'server',
            port = '${port}',
            executable = {
              command = require('nix').codelldb_path,
              args = { '--port', '${port}' },
            },
          },
        },
        configurations = {
          c = { configs.codelldb },
        },
      }
    end,
    config = function(_, opts)
      vim.fn.sign_define('DapBreakpoint', { text = '󰠭', texthl = 'Error' })
      vim.fn.sign_define(
        'DapBreakpointCondition',
        { text = '󰠭', texthl = 'Conditional' }
      )
      vim.fn.sign_define('DapBreakpointRejected', { text = '󰒲' })
      vim.fn.sign_define('DapLogPoint', { text = '' })

      local dap = require('dap')

      for name, adapter in pairs(opts.adapters) do
        dap.adapters[name] = adapter
      end

      for name, config in pairs(opts.configurations) do
        dap.configurations[name] = config
      end
    end,
  },
  {
    'rcarriga/nvim-dap-ui',
    lazy = true,
    dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
    cmd = { 'DapUiOpen', 'DapUiClose', 'DapUiToggle' },
    keys = {
      {
        '<leader>k',
        function() require('dapui').eval() end,
        desc = 'Evaluate expression',
      },
    },
    opts = {},
    config = function(_, opts)
      local dapui = require('dapui')
      dapui.setup(opts)

      vim.api.nvim_create_user_command(
        'DapUiOpen',
        function() dapui.open() end,
        { desc = 'Open dap-ui' }
      )
      vim.api.nvim_create_user_command(
        'DapUiClose',
        function() dapui.close() end,
        { desc = 'Close dap-ui' }
      )
      vim.api.nvim_create_user_command(
        'DapUiToggle',
        function() dapui.toggle() end,
        { desc = 'Toggle dap-ui' }
      )
      vim.api.nvim_create_autocmd('VimLeavePre', {
        pattern = '*',
        callback = function() dapui.close() end,
      })

      local dap = require('dap')
      local listeners = dap.listeners

      listeners.before.attach.dapui_config = function() dapui.open() end
      listeners.before.launch.dapui_config = function() dapui.open() end
      listeners.before.event_terminated.dapui_config = function() dapui.close() end
      listeners.before.event_exited.dapui_config = function() dapui.close() end
    end,
  },
}
