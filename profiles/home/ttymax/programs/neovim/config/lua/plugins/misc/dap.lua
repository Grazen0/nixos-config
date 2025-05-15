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
      local dap = require('dap')

      local function find_package_main(dir)
        local root = vim.fs.root(0, 'package.json')

        if root == nil then
          return dap.ABORT
        end

        local main = vim.fn.system('jq -rc .main ' .. root .. '/package.json')

        if main ~= 'null' then
          return dir .. '/' .. require('lib').trim(main)
        end

        return dap.ABORT
      end

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
        ['pwa-node'] = {
          type = 'pwa-node',
          request = 'launch',
          name = 'Launch js-debug (current file)',
          program = '${file}',
          cwd = '${workspaceFolder}',
        },
        ['pwa-node-main'] = {
          type = 'pwa-node',
          request = 'launch',
          name = 'Launch js-debug (main project file)',
          program = function()
            return find_package_main(vim.fn.expand('%:p:h'))
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
          ['pwa-node'] = {
            type = 'server',
            host = '::1',
            port = '${port}',
            executable = {
              command = 'js-debug',
              args = { '${port}' },
            },
          },
        },
        configurations = {
          c = { configs.codelldb },
          javascript = { configs['pwa-node'], configs['pwa-node-main'] },
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

      vim.api.nvim_create_autocmd('VimLeavePre', {
        pattern = '*',
        callback = function()
          dapui.close()
        end,
      })

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
    opts = {
      virt_text_pos = 'eol',
    },
  },
  {
    'stevearc/overseer.nvim',
    lazy = true,
    main = 'overseer',
    opts = {},
  },
  {
    'mfussenegger/nvim-dap-python',
    enabled = false,
    ft = 'python',
    dependencies = { 'mfussenegger/nvim-dap' },
    config = function()
      require('dap-python').setup(vim.g.python3_host_prog)
    end,
  },
}
