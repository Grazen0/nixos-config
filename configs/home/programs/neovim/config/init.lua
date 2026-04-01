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
vim.opt.spell = true
vim.opt.spelllang = { 'es', 'en_us' }
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.tabstop = 4
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.updatetime = 300
vim.opt.virtualedit = 'all'
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

-- Spell quick fix
map('i', '<c-l>', '<c-g>u<esc>[s1z=`]a<c-g>u')

vim.cmd.packadd('nvim.undotree')
vim.cmd.packadd('termdebug')

-- ============================================================================
-- Autocmds
-- ============================================================================

vim.filetype.add({
  extension = {
    v = 'systemverilog',
    vh = 'systemverilog',
    tf = 'terraform',
  },
})

-- Highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.hl.on_yank()
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

vim.api.nvim_create_autocmd('QuickFixCmdPre', {
  command = 'wall',
})

-- Use LSP folding if available
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client:supports_method('textDocument/foldingRange') then
      local win = vim.api.nvim_get_current_win()
      vim.wo[win][0].foldmethod = 'expr'
      vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
    end
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
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})


-- ============================================================================
-- Plugins
-- ============================================================================


vim.pack.add({
  { src = 'https://github.com/saghen/blink.cmp', version = 'v1.10.1' },
  'https://github.com/folke/snacks.nvim',
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
  'https://github.com/windwp/nvim-ts-autotag',
  'https://github.com/alexghergh/nvim-tmux-navigation',
  'https://github.com/nmac427/guess-indent.nvim',
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-pack/nvim-spectre',
  'https://github.com/stevearc/oil.nvim',
  'https://github.com/nvim-mini/mini.surround',
  'https://github.com/nvim-mini/mini.ai',
  'https://github.com/nvim-mini/mini.icons',
  'https://github.com/nvim-mini/mini.pairs',
  'https://github.com/nvim-mini/mini.sessions',
  'https://github.com/chomosuke/typst-preview.nvim',
  'https://github.com/rebelot/kanagawa.nvim',
  'https://github.com/RRethy/vim-illuminate',
  'https://github.com/lewis6991/gitsigns.nvim',
  'https://github.com/j-hui/fidget.nvim',
})

require('mini.icons').setup()
require('mini.icons').mock_nvim_web_devicons()

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
      Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg },
      PmenuExtra = { fg = theme.syn.comment, bg = theme.ui.bg },
      PmenuSel = { fg = 'none', bg = theme.ui.bg_p2 },
      PmenuSbar = { bg = theme.ui.bg_m1 },
      PmenuThumb = { bg = theme.ui.bg_p2 },
      BlinkCmpMenuBorder = { link = 'FloatBorder' },

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

require('blink.cmp').setup({
  keymap = { preset = 'enter' },
  signature = { enabled = true },
  completion = {
    ghost_text = { enabled = true },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 500,
    },
    list = {
      selection = {
        preselect = false,
        auto_insert = false,
      },
    },
    menu = {
      draw = {
        columns = {
          { 'label', 'label_description', gap = 1 },
          { 'kind_icon', 'kind', gap = 1 },
        },
      },
    },
  },
})


local snacks = require('snacks')

snacks.setup({
  bigfile = { enabled = true },
  quickfile = { enabled = true },
  indent = {
    enabled = true,
    scope = { hl = 'SignColumn' },
    animate = { enabled = false },
  },
  input = { enabled = true },
  picker = { enable = true },
  explorer = { enable = true },
  rename = { enabled = true },
  bufdelete = { enabled = true },
})

map('n', '<leader>e',
  function() snacks.explorer({ auto_close = true, hidden = true }) end)
map('n', '<leader>q', function() snacks.bufdelete() end)
map('n', '<leader>C', snacks.bufdelete.other)
map('n', '<F1>', snacks.picker.help)
map('n', '<leader><leader>', snacks.picker.buffers)
map('n', '<leader>ff',
  function() snacks.picker.files({ hidden = true }) end)
map('n', '<leader>fg', snacks.picker.grep)
map('n', '<leader>fd', snacks.picker.diagnostics_buffer)
map('n', '<leader>fD', snacks.picker.diagnostics)
map('n', '<leader>fm', snacks.picker.man)
map('n', 'gd', snacks.picker.lsp_definitions)
map('n', 'gD', snacks.picker.lsp_declarations)
map('n', 'grr', snacks.picker.lsp_references)
map('n', 'gO', snacks.picker.lsp_symbols)

local parsers = {
  'bash',
  'c',
  'cpp',
  'css',
  'diff',
  'go',
  'html',
  'javascript',
  'latex',
  'lua',
  'luadoc',
  'markdown',
  'markdown_inline',
  'query',
  'rust',
  'svelte',
  'systemverilog',
  'typescript',
  'typst',
  'vim',
  'vimdoc',
  'zig',
}

require('nvim-treesitter').install(parsers)

require('nvim-ts-autotag').setup()
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

require('oil').setup({
  delete_to_trash = true,
  watch_for_changes = true,
  view_options = { show_hidden = true },
  keymaps = {
    ['<c-v>'] = { 'actions.select', opts = { vertical = true } },
    ['<c-s>'] = { 'actions.select', opts = { horizontal = true } },
  },
  win_options = {
    signcolumn = vim.o.signcolumn,
  },
})
map('n', '-', '<cmd>Oil<cr>')

require('mini.ai').setup()
require('mini.surround').setup()
require('mini.pairs').setup()
require('mini.sessions').setup()

require('typst-preview').setup()
map('n', '<localleader>tp', '<cmd>TypstPreview<cr>')

vim.cmd.colorscheme('kanagawa')

require('illuminate').configure()
require('gitsigns').setup()
require('fidget').setup({
  notification = {
    override_vim_notify = true,
  },
})

require('lazy').setup({
  performance = {
    reset_packpath = false,
    rtp = { reset = false },
  },
  spec = {
    { import = 'plugins.lsp' },
  },
  ui = { border = vim.o.winborder },
})
