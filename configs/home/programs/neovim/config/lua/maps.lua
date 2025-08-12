vim.g.mapleader = ' '
vim.g.maplocalleader = ','

local map = vim.keymap.set

map('n', '<esc>', '<cmd>nohlsearch<cr>')

-- gh/gl instead of ^/$
map({ 'n', 'v' }, 'gh', '^')
map({ 'n', 'v' }, 'gl', '$')

-- Better redo
map('n', 'U', '<c-r>')

-- Window navigation
map('n', '<c-h>', '<c-w>h')
map('n', '<c-j>', '<c-w>j')
map('n', '<c-k>', '<c-w>k')
map('n', '<c-l>', '<c-w>l')

-- Window positioning
map('n', '<a-h>', '<c-w>H')
map('n', '<a-j>', '<c-w>J')
map('n', '<a-k>', '<c-w>K')
map('n', '<a-l>', '<c-w>L')

-- Window resizing
map('n', '<a-,>', '<c-w><lt>')
map('n', '<a-.>', '<c-w>>')
map('n', '<a-->', '<c-w>-')
map('n', '<a-=>', '<c-w>+')

-- Soft line wrap movement
map({ 'n', 'v' }, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })
map({ 'n', 'v' }, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })

-- Floating diagnostic window
map('n', '<leader>d', vim.diagnostic.open_float)

-- Spell quick fix
map('i', '<c-l>', '<c-g>u<esc>[s1z=`]a<c-g>u')
