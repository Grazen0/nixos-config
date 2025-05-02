local o = vim.opt

-- Just in case
o.encoding = 'utf-8'
o.compatible = false
o.termguicolors = true
-- Numbering and stuff
o.number = true
o.relativenumber = true
o.signcolumn = 'yes'
o.scrolloff = 10
o.cursorline = true
o.cursorlineopt = 'both'

-- Wrapping
o.breakindent = true
o.linebreak = true

-- Searching
o.ignorecase = true
o.smartcase = true
o.hlsearch = true

-- Spacing
o.shiftwidth = 4
o.tabstop = 4
o.expandtab = true

-- Misc (?)
o.showmode = false
o.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
o.autoread = true
o.mouse = 'a' -- No shame
o.splitright = true
o.undofile = true
o.updatetime = 300
o.spelllang = { 'es', 'en_us' }
o.confirm = true
o.winborder = 'single'

vim.g.tex_flavor = 'latex'
