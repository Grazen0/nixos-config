return {
  {
    'nvim-neotest/neotest',
    enabled = false,
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
      'antoinemadec/FixCursorHold.nvim',
      'nvim-treesitter/nvim-treesitter',
      'rcarriga/nvim-dap-ui',
      'theHamsta/nvim-dap-virtual-text',
    },
    keys = {
      {
        '<leader>tt',
        function()
          require('neotest').run.run()
        end,
        desc = 'Run nearest test',
      },
      {
        '<leader>tT',
        function()
          require('neotest').run.run(vim.fn.expand('%'))
        end,
        desc = 'Run all tests in file',
      },
      {
        '<leader>tS',
        function()
          require('neotest').run.run({ suite = true })
        end,
        desc = 'Run all tests',
      },
      {
        '<leader>ta',
        function()
          require('neotest').run.attach()
        end,
        desc = 'Attach to nearest test',
      },
      {
        '<leader>td',
        function()
          require('neotest').run.run({ strategy = 'dap' })
        end,
        desc = 'Debug nearest test',
      },
      {
        '<leader>ts',
        function()
          require('neotest').run.stop()
        end,
        desc = 'Stop nearest test',
      },
      {
        '<leader>tso',
        function()
          require('neotest').summary.open()
        end,
        desc = 'Open test summary window',
      },
      {
        '<leader>tsc',
        function()
          require('neotest').summary.close()
        end,
        desc = 'Close test summary window',
      },
      {
        '<leader>tO',
        function()
          require('neotest').output.open({ enter = true })
        end,
        desc = 'Open test result output',
      },
      {
        '<leader>too',
        function()
          require('neotest').output_panel.open()
        end,
        desc = 'Open output panel',
      },
      {
        '<leader>toc',
        function()
          require('neotest').output_panel.close()
        end,
        desc = 'Open output panel',
      },
      {
        '<leader>tww',
        function()
          require('neotest').watch.watch()
        end,
        desc = 'Start watching tests',
      },
      {
        '<leader>tws',
        function()
          require('neotest').watch.stop()
        end,
        desc = 'Stop watching tests',
      },
    },
    opts = {
      adapters = {
        require('neotest-rust'),
        require('neotest-java')({
          junit_jar = require('nix').junit_path,
        }),
      },
    },
  },
}
