vim.loader.enable()


-- ============================================================================
-- Options
-- ============================================================================

vim.opt.breakindent = true
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.fillchars:append({ fold = ' ' })
vim.opt.foldenable = true
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldlevel = 99
vim.opt.foldmethod = 'expr'
vim.opt.foldtext = ''
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.linebreak = true
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 4
vim.opt.shiftwidth = 4
vim.opt.showmode = false
vim.opt.signcolumn = 'yes'
vim.opt.smartcase = true
vim.opt.softtabstop = 4
vim.opt.spell = true
vim.opt.spelllang = { 'es', 'en_us' }
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.tabstop = 4
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.updatetime = 300
vim.opt.winborder = 'single'
vim.opt.wrap = false


-- ============================================================================
-- Mappings
-- ============================================================================

vim.g.mapleader = ' '
vim.g.maplocalleader = ','

local map = vim.keymap.set

map('n', '<esc>', '<cmd>nohlsearch<cr>')

-- Helix-like bindings
map({ 'n', 'v', 'x' }, 'U', '<c-r>')
map({ 'n', 'v', 'x' }, 'gh', '^')
map({ 'n', 'v', 'x' }, 'gl', '$')
map({ 'n', 'v', 'x' }, 'gH', 'g^')
map({ 'n', 'v', 'x' }, 'gL', 'g$')

map({ 'n', 'v', 'x' }, '<leader>y', '"+y')
map({ 'n', 'v', 'x' }, '<leader>d', '"+d')
map({ 'n', 'v', 'x' }, '<leader>p', '"+p')
map('n', '<esc>', '<cmd>nohlsearch<cr>')
map('n', '<leader>s', '<cmd>e #<cr>')
map('n', '<leader>d', vim.diagnostic.open_float)

-- Window navigation
map('n', '<c-h>', '<c-w>h')
map('n', '<c-j>', '<c-w>j')
map('n', '<c-k>', '<c-w>k')
map('n', '<c-l>', '<c-w>l')
map('n', '<a-h>', '<c-w>H')
map('n', '<a-j>', '<c-w>J')
map('n', '<a-k>', '<c-w>K')
map('n', '<a-l>', '<c-w>L')
map('n', '<a-,>', '<c-w><lt>')
map('n', '<a-.>', '<c-w>>')
map('n', '<a-->', '<c-w>-')
map('n', '<a-=>', '<c-w>+')

-- Floating diagnostic window
map('n', '<leader>d', vim.diagnostic.open_float)

-- Spell quick fix
map('i', '<c-l>', '<c-g>u<esc>[s1z=`]a<c-g>u')


-- ============================================================================
-- Autocmds
-- ============================================================================

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


-- ============================================================================
-- LSP
-- ============================================================================

-- Use LSP folding if available
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client:supports_method('textDocument/foldingRange') then
      local win = vim.api.nvim_get_current_win()
      vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
    end
  end,
})


-- ============================================================================
-- Plugins
-- ============================================================================

require('lazy').setup({
  performance = {
    reset_packpath = false,
    rtp = { reset = false },
  },
  dev = {
    path = require('nix').lazy_dev_path,
    patterns = { '' },
  },
  install = { missing = false },
  change_detection = { enabled = false },
  spec = {
    { import = 'plugins.mini' },
    { import = 'plugins.visuals' },
    { import = 'plugins.editor' },
    { import = 'plugins.lsp' },
    { import = 'plugins.misc' },
  },
  ui = { border = vim.o.winborder },
})
