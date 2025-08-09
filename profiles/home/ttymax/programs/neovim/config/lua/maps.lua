vim.g.mapleader = ' '
vim.g.maplocalleader = ','

local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent or true

  vim.keymap.set(mode, lhs, rhs, opts)
end

map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- gh/gl instead of ^/$
map({ 'n', 'v' }, 'gh', '^')
map({ 'n', 'v' }, 'gl', '$')

-- Better redo
map('n', 'U', '<C-r>')

-- Window navigation
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

-- Window positioning
map('n', '<A-h>', '<C-w>H')
map('n', '<A-j>', '<C-w>J')
map('n', '<A-k>', '<C-w>K')
map('n', '<A-l>', '<C-w>L')

-- Window resizing
map('n', '<A-,>', '<C-w><lt>')
map('n', '<A-.>', '<C-w>>')
map('n', '<A-->', '<C-w>-')
map('n', '<A-=>', '<C-w>+')

-- Soft line wrap movement
map({ 'n', 'v' }, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })
map({ 'n', 'v' }, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })

-- Floating diagnostic window
map('n', '<leader>d', vim.diagnostic.open_float)

-- Spell quick fix
map('i', '<C-l>', '<C-g>u<Esc>[s1z=`]a<C-g>u')
