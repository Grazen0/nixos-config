local function setup_linter(lint)
  lint.linters_by_ft = {
    systemverilog = { 'verilator' },
    verilog = { 'verilator' },
  }

  local verilator = lint.linters.verilator

  verilator.args = {
    '-Wall',
    '--lint-only',
    '-DIVERILOG',
    '-f',
    vim.fs.find('verilator.f', { upward = true, stop = vim.env.HOME })[1],
  }


  lint.linters.verilator = verilator
end

return {
  'mfussenegger/nvim-lint',
  event = {
    'BufReadPre',
    'BufNewFile',
    'BufWritePost',
    'TextChanged',
    'InsertLeave',
  },
  config = function()
    local lint = require('lint')

    setup_linter(lint)

    vim.api.nvim_create_autocmd(
      {
        'BufEnter',
        'BufWritePost',
        'TextChanged',
        'InsertLeave',
      }, {
        group = vim.api.nvim_create_augroup('nvim_lint', { clear = true }),
        callback = function()
          vim.defer_fn(function()
            lint.try_lint()
          end, 1)
        end,
      })
  end
  ,
}
