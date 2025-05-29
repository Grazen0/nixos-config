return {

  {
    'nvim-neotest/neotest',
    dependencies = {
      'nvim-neotest/nvim-nio',
      'nvim-lua/plenary.nvim',
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
        '<leader>ta',
        function()
          require('neotest').run.attach()
        end,
        desc = 'Attach to nearest test',
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
