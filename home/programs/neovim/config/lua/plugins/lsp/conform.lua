local create_user_command = vim.api.nvim_create_user_command

return {
  'stevearc/conform.nvim',
  cmd = 'Format',
  event = 'BufWritePre',
  opts = {
    formatters_by_ft = {
      html = { 'prettierd' },
      javascriptreact = { 'prettierd' },
      typescriptreact = { 'prettierd' },
      javascript = { 'prettierd' },
      typescript = { 'prettierd' },
      graphql = { 'prettierd' },
      json = { 'prettierd' },
      css = { 'prettierd' },
      python = { 'isort', 'black' },
      lua = { 'stylua' },
      rust = { 'rustfmt' },
      c = { 'clang-format' },
      cpp = { 'clang-format' },
      yaml = { 'prettierd' },
      sh = { 'beautysh' },
      bash = { 'beautysh' },
      zsh = { 'beautysh' },
      nix = { 'alejandra' },
      markdown = { 'mdformat' },
      quarto = { 'mdformat' },
      r = { 'styler' },
    },
    format_on_save = function(bufnr)
      -- Disable with a global or buffer-local variable
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end

      return {
        timeout_ms = 2000,
        lsp_format = 'fallback',
      }
    end,
    formatters = {

      -- mdformat has some weird default behavior
      mdformat = { append_args = { '--number' } },
    },
  },

  init = function()
    -- Toggle formatting
    create_user_command('FormatEnable', function()
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false
    end, { bang = true })

    create_user_command('FormatDisable', function(args)
      if args.bang then
        -- FormatDisable! will disable formatting just for this buffer
        vim.b.disable_autoformat = true
      else
        vim.g.disable_autoformat = true
      end
    end, { bang = true })

    -- Save without formatting
    create_user_command('Mfw', function()
      local prev = vim.b.disable_autoformat
      vim.b.disable_autoformat = true
      vim.cmd('write')
      vim.b.disable_autoformat = prev
    end, {})
  end,

  config = function(_, opts)
    local conform = require('conform')
    conform.setup(opts)

    -- Format command
    create_user_command('Format', function(args)
      local range = nil

      if args.count ~= -1 then
        local end_line =
          vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
        range = {
          start = { args.line1, 0 },
          ['end'] = { args.line2, end_line:len() },
        }
      end

      conform.format({
        async = true,
        lsp_format = 'fallback',
        range = range,
      })
    end, { range = true })
  end,
}
