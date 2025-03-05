return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'theHamsta/nvim-dap-virtual-text',
      'stevearc/overseer.nvim',
    },
    cmd = {
      'DapContinue',
      'DapToggleBreakpoint',
      'DapNew',
    },
    keys = {
      { '<F5>', '<cmd>DapContinue<CR>' },
      { '<F10>', '<cmd>DapStepOver<CR>' },
      { '<F11>', '<cmd>DapStepInto<CR>' },
      { '<S-F11>', '<cmd>DapStepOut<CR>' },
      {
        '<C-S-F5>',
        function()
          require('dap').restart()
        end,
        desc = 'Restart nvim-dap session',
      },
      { '<S-F5>', '<cmd>DapDisconnect<CR>' },
      { '<leader>b', '<cmd>DapToggleBreakpoint<CR>' },
    },
    opts = function()
      local codelldb_config = {
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
        stopOnEntry = false,
        args = {},
        runInTerminal = false,
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
          c = { codelldb_config },
          cpp = { codelldb_config },
        },
      }
    end,
    config = function(_, opts)
      vim.fn.sign_define('DapBreakpoint', { text = '󰠭' })
      vim.fn.sign_define('DapBreakpointCondition', { text = '' })
      vim.fn.sign_define('DapBreakpointRejected', { text = '󰒲' })
      vim.fn.sign_define('DapLogPoint', { text = '' })

      local dap = require('dap')
      dap.adapters = opts.adapters
      dap.configurations = opts.configurations
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
        function()
          require('dapui').eval()
        end,
        desc = 'Evaluate expression',
      },
    },
    opts = {},
    config = function(_, opts)
      local dapui = require('dapui')
      dapui.setup(opts)

      vim.api.nvim_create_user_command('DapUiOpen', function()
        dapui.open()
      end, { desc = 'Open dap-ui' })

      vim.api.nvim_create_user_command('DapUiClose', function()
        dapui.close()
      end, { desc = 'Close dap-ui' })

      vim.api.nvim_create_user_command('DapUiToggle', function()
        dapui.toggle()
      end, { desc = 'Toggle dap-ui' })

      local dap = require('dap')

      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end,
  },
  {
    'theHamsta/nvim-dap-virtual-text',
    lazy = true,
    opts = {},
  },
  {
    'stevearc/overseer.nvim',
    lazy = true,
    main = 'overseer',
    opts = {},
  },
}
