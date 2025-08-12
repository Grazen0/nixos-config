local create_autocmd = vim.api.nvim_create_autocmd
local create_augroup = vim.api.nvim_create_augroup

-- Highlight yanked text
create_augroup('YankHighlight', { clear = true })
create_autocmd('TextYankPost', {
  group = 'YankHighlight',
  callback = function()
    vim.highlight.on_yank({ higroup = 'Search', timeout = 500 })
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
  callback = function() vim.opt_local.wrap = false end,
})

-- Proper syntax highlighting for .inc assembly files
create_autocmd({ 'BufNew', 'BufNewFile', 'BufRead' }, {
  pattern = { '*.inc' },
  callback = function() vim.bo.filetype = 'asm' end,
})

-- Continue lists in Markdown
create_autocmd('FileType', {
  pattern = { 'markdown', 'quarto' },
  callback = function()
    vim.opt_local.comments = { 'b:*', 'b:-', 'b:+', 'n:>' }
    vim.opt_local.formatoptions:append('r')
  end,
})
