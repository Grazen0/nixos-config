vim.g.mapleader = ' '
vim.g.maplocalleader = ','

local function keyset(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent or true

  vim.keymap.set(mode, lhs, rhs, opts)
end

-- gh/gl instead of ^/$
keyset('n', 'gh', '^')
keyset('n', 'gl', '$')

-- https://www.reddit.com/r/neovim/comments/1jdvvei/my_list_of_useful_keybinds_i_dont_see_mentioned/
-- Text object to select entire buffer.
-- So you can do `yie` / `die` / `vie` to yank / delete /select the entire buffer
vim.keymap.set('o', 'ie', ':<C-u>normal! mzggVG<CR>`z')
vim.keymap.set('x', 'ie', ':<C-u>normal! ggVG<CR>')

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

-- n/N always move forwards/backwards, respectively
keyset('n', 'n', 'v:searchforward ? "n" : "N"', { expr = true })
keyset('n', 'N', 'v:searchforward ? "N" : "n"', { expr = true })

-- Floating diagnostic window
keyset('n', '<leader>d', vim.diagnostic.open_float)

-- Spell quick fix
keyset('i', '<C-l>', '<C-g>u<Esc>[s1z=`]a<C-g>u')

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
