return {
  'stevearc/conform.nvim',
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
      -- styler doesn't modify in-place
      styler = { stdin = true },

      -- mdformat has some weird default behavior
      mdformat = { append_args = { '--number' } },
    },
  },
}
