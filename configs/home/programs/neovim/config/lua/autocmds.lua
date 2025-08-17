-- Highlight yanked text
vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  group = 'YankHighlight',
  callback = function()
    vim.highlight.on_yank({ higroup = 'Search', timeout = 500 })
  end,
})

-- Continue list bullets for some filetypes
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'markdown', 'quarto', 'typst' },
  callback = function()
    vim.opt_local.comments = { 'b:*', 'b:-', 'b:+', 'n:>' }
    vim.opt_local.formatoptions:append('r')
  end,
})

-- Text wrapping for prose
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'markdown', 'tex', 'plaintex', 'typst' },
  callback = function()
    vim.opt_local.textwidth = 80
    vim.opt_local.formatoptions:append('t')
  end,
})
