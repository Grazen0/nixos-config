local create_autocmd = vim.api.nvim_create_autocmd
local create_augroup = vim.api.nvim_create_augroup

-- Restore cursor position on buffer enter
create_autocmd('BufReadPost', {
  command = 'silent! normal g`"zv',
})

-- Highlight yanked text
create_augroup('YankHighlight', { clear = true })
create_autocmd('TextYankPost', {
  group = 'YankHighlight',
  callback = function()
    vim.highlight.on_yank({ higroup = 'Search', timeout = 500 })
  end,
})

-- Open help windows in vertical split
create_autocmd('FileType', {
  pattern = 'help',
  command = 'wincmd L',
})

-- Use relative numbers only on focused buffer
create_autocmd({ 'WinEnter', 'FocusGained' }, {
  pattern = '*',
  callback = function()
    if vim.api.nvim_win_get_option(0, 'number') then
      vim.opt_local.relativenumber = true
    end
  end,
})
create_autocmd({ 'WinLeave', 'FocusLost' }, {
  pattern = '*',
  callback = function()
    if vim.api.nvim_win_get_option(0, 'number') then
      vim.opt_local.relativenumber = false
    end
  end,
})

-- Workaround for a rust-analyzer bug
create_autocmd('FileType', {
  pattern = 'rust',
  callback = function()
    for _, method in ipairs({
      'textDocument/diagnostic',
      'workspace/diagnostic',
    }) do
      local default_diagnostic_handler = vim.lsp.handlers[method]
      vim.lsp.handlers[method] = function(err, result, context, config)
        if err ~= nil and err.code == -32802 then
          return
        end
        return default_diagnostic_handler(err, result, context, config)
      end
    end
  end,
})

-- Tab width 2 for some filetypes
create_autocmd('FileType', {
  pattern = {
    'nix',
    'haskell',
    'yuck',
    'html',
    'css',
    'scss',
    'json',
    'jsonc',
    'javascript',
    'javascriptreact',
    'typescript',
    'typescriptreact',
    'lua',
    'svelte',
  },
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
  end,
})

-- Disable formatter for LaTeX files
create_autocmd('FileType', {
  pattern = { 'tex', 'plaintex' },
  callback = function()
    vim.b.disable_autoformat = true
  end,
})

-- Conceal level for markdown and LaTeX files
create_autocmd('FileType', {
  pattern = { 'markdown', 'tex', 'plaintex' },
  callback = function()
    vim.opt_local.conceallevel = 2
  end,
})
