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
    'r',
    'markdown',
    'vimwiki',
    'quarto',
  },
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
  end,
})

-- Disable formatter + enable conceal for LaTeX files
create_autocmd('FileType', {
  pattern = { 'tex', 'plaintex' },
  callback = function()
    vim.b.disable_autoformat = true
    vim.opt_local.conceallevel = 2
  end,
})

-- Disable wrap for Java files
create_autocmd('FileType', {
  pattern = 'java',
  callback = function()
    vim.opt_local.wrap = false
  end,
})

-- Proper syntax highlighting for .inc assembly files
create_autocmd({ 'BufNew', 'BufNewFile', 'BufRead' }, {
  pattern = { '*.inc' },
  callback = function()
    vim.bo.filetype = 'asm'
  end,
})

-- Disable line numbers for terminal buffers
create_autocmd('TermOpen', {
  pattern = '*',
  callback = function()
    vim.opt_local.number = false
    vim.opt_local.relativenumber = false
  end,
})
