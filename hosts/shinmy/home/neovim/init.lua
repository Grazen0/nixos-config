vim.loader.enable()


-- ============================================================================
-- Options
-- ============================================================================

vim.opt.breakindent = true
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.fillchars:append({ fold = ' ' })
vim.opt.foldenable = true
vim.opt.foldlevel = 99
vim.opt.foldtext = ''
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.laststatus = 3
vim.opt.linebreak = true
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 1
vim.opt.shiftwidth = 4
vim.opt.signcolumn = 'yes'
vim.opt.smartcase = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.tabstop = 4
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.updatetime = 300
vim.opt.virtualedit = 'all'
vim.opt.winborder = 'single'


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

map('n', '<esc>', '<cmd>nohlsearch<cr>')
map('t', '<esc>', '<c-\\><c-n>')
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

vim.cmd('packadd! nvim.undotree')

-- Highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Auto-start treesitter
vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    local buf, filetype = args.buf, args.match

    local language = vim.treesitter.language.get_lang(filetype)
    if not language then return end

    if not vim.treesitter.language.add(language) then return end
    vim.treesitter.start(buf, language)

    vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.wo.foldmethod = 'expr'
  end,
})


-- ============================================================================
-- Plugins
-- ============================================================================


vim.pack.add({
  'https://github.com/folke/snacks.nvim',
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
  'https://github.com/alexghergh/nvim-tmux-navigation',
  'https://github.com/nmac427/guess-indent.nvim',
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-pack/nvim-spectre',
  'https://github.com/nvim-mini/mini.files',
  'https://github.com/nvim-mini/mini.surround',
  'https://github.com/nvim-mini/mini.ai',
  'https://github.com/nvim-mini/mini.icons',
  'https://github.com/nvim-mini/mini.pairs',
  'https://github.com/nvim-mini/mini.sessions',
  'https://github.com/rebelot/kanagawa.nvim',
  'https://github.com/RRethy/vim-illuminate',
  'https://github.com/lewis6991/gitsigns.nvim',
})

require('mini.icons').setup()
MiniIcons.mock_nvim_web_devicons()

require('kanagawa').setup({
  colors = { theme = { all = { ui = { bg_gutter = 'none' } } } },
  overrides = function(colors)
    local theme = colors.theme
    local c = require('kanagawa.lib.color')

    local blend = function(color, ratio)
      return {
        fg = color,
        bg = c(color):blend(theme.ui.bg, ratio or 0.95):to_hex(),
      }
    end

    return {
      -- Custom window separator line
      WinSeparator = { link = 'FloatBorder' },

      -- Dark completion background
      Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },
      PmenuKind = { bg = theme.ui.bg_p1 },
      PmenuExtra = { fg = theme.syn.comment, bg = theme.ui.bg_p1 },
      PmenuSel = { fg = 'none', bg = theme.ui.bg_p2 },
      PmenuKindSel = { fg = 'none', bg = theme.ui.bg_p2 },
      PmenuExtraSel = { fg = 'none', bg = theme.ui.bg_p2 },
      PmenuSbar = { bg = theme.ui.bg_m1 },
      PmenuThumb = { bg = theme.ui.bg_p2 },

      -- Transparent widgets and floating windows
      NormalFloat = { bg = 'none' },
      FloatBorder = { bg = 'none' },
      FloatTitle = { bg = 'none' },

      -- Tint background of diagnostic messages with their foreground color
      DiagnosticVirtualTextHint = blend(theme.diag.hint),
      DiagnosticVirtualTextInfo = blend(theme.diag.info),
      DiagnosticVirtualTextWarn = blend(theme.diag.warning),
      DiagnosticVirtualTextError = blend(theme.diag.error),
    }
  end,
})
vim.cmd.colorscheme('kanagawa')

local snacks = require('snacks')

snacks.setup({
  bigfile = { enabled = true },
  quickfile = { enabled = true },
  indent = {
    enabled = true,
    scope = { hl = 'SignColumn' },
    animate = { enabled = false },
  },
  picker = { enabled = true },
  rename = { enabled = true },
  bufdelete = { enabled = true },
})

map('n', '<leader>e',
  function() MiniFiles.open(vim.api.nvim_buf_get_name(0)) end)
map('n', '<leader>q', function() Snacks.bufdelete() end)
map('n', '<leader>C', Snacks.bufdelete.other)
map('n', '<F1>', Snacks.picker.help)
map('n', '<leader><leader>', Snacks.picker.buffers)
map('n', '<leader>ff',
  function() Snacks.picker.files({ hidden = true }) end)
map('n', '<leader>fg', Snacks.picker.grep)

local parsers = {
  'bash',
  'comment',
  'diff',
  'json',
  'lua',
  'luadoc',
  'markdown',
  'markdown_inline',
  'nix',
  'vim',
  'vimdoc',
  'yaml',
}
require('nvim-treesitter').install(parsers)

require('guess-indent').setup()
require('spectre').setup()

require('nvim-tmux-navigation').setup({
  disable_when_zoomed = true, -- defaults to false
  keybindings = {
    left = '<C-h>',
    down = '<C-j>',
    up = '<C-k>',
    right = '<C-l>',
    last_active = '<C-\\>',
    next = '<C-Space>',
  },
})

require('mini.files').setup({
  options = { permanent_delete = false },
  windows = { preview = true },
})
require('mini.ai').setup()
require('mini.surround').setup()
require('mini.pairs').setup()
require('mini.sessions').setup()

vim.cmd.colorscheme('kanagawa')

require('illuminate').configure()
require('gitsigns').setup()
