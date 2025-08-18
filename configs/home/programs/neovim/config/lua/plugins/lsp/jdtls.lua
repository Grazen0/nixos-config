return {
  'mfussenegger/nvim-jdtls',
  event = 'VeryLazy',
  opts = {
    cmd = { 'jdtls', '--jvm-arg=-javaagent:' .. require('nix').lombok_path },
    root_dir = vim.fs.root(0, { 'gradlew', '.git', 'mvnw' }),
  },
  config = function(_, opts)
    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'java' },
      callback = function()
        require('jdtls').start_or_attach(opts)
      end,
    })
  end,
}
