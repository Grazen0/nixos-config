vim.g.mapleader = ' '
vim.g.maplocalleader = ','

local function keyset(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent or true

  vim.keymap.set(mode, lhs, rhs, opts)
end

-- Disable keyword completion (sorry)
keyset('i', '<C-n>', '<Nop>')
keyset('i', '<C-p>', '<Nop>')

-- Exit terminal with <Esc><Esc>
-- keyset('t', '<Esc><Esc>', '<C-\\><C-n>')

local lib_nvim = require('lib.nvim')

-- Buffer delete without deleting window
keyset('n', '<leader>q', function()
  if not vim.bo.modified then
    if #lib_nvim.list_valid_bufs() > 1 then
      vim.cmd('bp|bd#')
    else
      vim.cmd('bd')
    end
  end
end, { desc = 'Close buffer' })

keyset('n', '<leader>Q', function()
  if #lib_nvim.list_valid_bufs() > 1 then
    vim.cmd('bp|bd!#')
  else
    vim.cmd('bd!')
  end
end, { desc = 'Close buffer (force)' })

keyset('n', '<leader>rn', function()
  vim.lsp.bug.rename()
end)

-- Clear highlights with <Esc>
-- Set in multicursor.lua
-- keyset('n', '<Esc>', '<cmd>nohl<CR>')

-- Better redo
keyset('n', 'U', '<C-r>')

-- Window navigation
keyset('n', '<C-h>', '<C-w>h')
keyset('n', '<C-j>', '<C-w>j')
keyset('n', '<C-k>', '<C-w>k')
keyset('n', '<C-l>', '<C-w>l')

-- Window positioning
keyset('n', '<A-h>', '<C-w>H')
keyset('n', '<A-j>', '<C-w>J')
keyset('n', '<A-k>', '<C-w>K')
keyset('n', '<A-l>', '<C-w>L')

-- Window resizing
keyset('n', '<A-,>', '<C-w><lt>')
keyset('n', '<A-.>', '<C-w>>')
keyset('n', '<A-->', '<C-w>-')
keyset('n', '<A-=>', '<C-w>+')

-- Soft line wrap movement
keyset('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })
keyset('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })

-- Floating diagnostic window
keyset('n', '<leader>d', vim.diagnostic.open_float)

-- Spell quick fix
keyset('i', '<C-l>', '<C-g>u<Esc>[s1z=`]a<C-g>u')

-- Code action
keyset('n', 'ga', function()
  vim.lsp.buf.code_action()
end)

-- Filetype-specific binds
local function ft_keyset(ft, mode, lhs, rhs, opts)
  vim.api.nvim_create_autocmd('FileType', {
    pattern = ft,
    callback = function()
      opts = opts or {}
      opts.buffer = true

      keyset(mode, lhs, rhs, opts)
    end,
  })
end

-- Inkscape figures
ft_keyset(
  { 'tex', 'plaintex' },
  'i',
  '<C-f>',
  "<Esc>: silent exec '.!inkscape-figures create \"'.getline('.').'\" \"'.b:vimtex.root.'/figures/\"'<CR><CR>:w<CR>"
)
ft_keyset(
  { 'tex', 'plaintex' },
  'n',
  '<C-f>',
  ": silent exec '!inkscape-figures edit \"'.b:vimtex.root.'/figures/\" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>"
)
