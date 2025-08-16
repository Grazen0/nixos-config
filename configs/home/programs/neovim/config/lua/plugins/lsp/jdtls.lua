return {
  'mfussenegger/nvim-jdtls',
  ft = { 'java', 'groovy' },
  opts = function()
    return {
      cmd = {
        'jdtls',
        '--jvm-arg=-javaagent:' .. require('nix').lombok_path,
      },
      root_dir = vim.fs.dirname(
        vim.fs.find({ 'gradlew', '.git', 'mvnw' }, { upward = true })[1]
      ),
      init_options = {
        bundles = {
          vim.fn.glob(require('nix').java_debug_path, true),
        },
      },
    }
  end,
  config = function(_, opts)
    local jdtls = require('jdtls')

    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'java', 'kotlin', 'groovy' },
      callback = function()
        jdtls.start_or_attach(opts)
      end,
    })

    vim.api.nvim_create_user_command('JdtOrganizeImports', function()
      jdtls.organize_imports()
    end, {})
  end,
}
