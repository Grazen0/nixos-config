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
