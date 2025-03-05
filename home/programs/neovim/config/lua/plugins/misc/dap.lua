return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'rcarriga/nvim-dap-ui',
      'theHamsta/nvim-dap-virtual-text',
      'julianolf/nvim-dap-lldb',
    },
    cmd = {
      'DapContinue',
      'DapStepInto',
      'DapStepOut',
      'DapToggleBreakpoint',
      'DapToggleRepl',
    },
    keys = {
      { '<leader>Dc', '<cmd>DapContinue<CR>' },
      { '<leader>Do', '<cmd>DapStepOver<CR>' },
      { '<leader>Di', '<cmd>DapStepInto<CR>' },
      { '<leader>Du', '<cmd>DapStepOut<CR>' },
      { '<leader>Db', '<cmd>DapToggleBreakpoint<CR>' },
      { '<leader>Dr', '<cmd>DapToggleRepl<CR>' },
      {
        '<leader>Dq',
        function()
          require('dap').terminate()
          require('dapui').close()
          require('nvim-dap-virtual-text').toggle()
        end,
        desc = 'Quit nvim-dap',
      },
    },
    opts = function()
      local codelldb_config = {
        name = 'Launch lldb',
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
        '<A-k>',
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
}
