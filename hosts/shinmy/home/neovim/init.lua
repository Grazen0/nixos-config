vim.loader.enable()

vim.pack.add({
  'https://github.com/rebelot/kanagawa.nvim',
  'https://github.com/nvim-lualine/lualine.nvim',
  'https://github.com/nvim-treesitter/nvim-treesitter',
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/stevearc/oil.nvim',
  'https://github.com/kylechui/nvim-surround',
  'https://github.com/echasnovski/mini.icons',
  'https://github.com/echasnovski/mini.pairs',
  'https://github.com/echasnovski/mini.ai',
  'https://github.com/echasnovski/mini.sessions',
  'https://github.com/mbbill/undotree',
  'https://github.com/christoomey/vim-tmux-navigator',
  { src = 'https://github.com/saghen/blink.cmp', version = 'v1.6.0' },
  'https://github.com/j-hui/fidget.nvim',
  'https://github.com/NMAC427/guess-indent.nvim',
  'https://github.com/lewis6991/gitsigns.nvim',
  'https://github.com/folke/snacks.nvim',
})


-- ============================================================================
-- Options
-- ============================================================================

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.signcolumn = 'yes'
vim.opt.scrolloff = 1
vim.opt.cursorline = true
vim.opt.wrap = false

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true

vim.opt.foldenable = true
vim.opt.foldlevel = 99
vim.opt.foldtext = ''
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.fillchars:append({ fold = ' ' })

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.autoread = true
vim.opt.updatetime = 300
vim.opt.winborder = 'rounded'
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false


-- ============================================================================
-- Mappings
-- ============================================================================

vim.g.mapleader = ' '
vim.g.maplocalleader = ','

local map = vim.keymap.set

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

map({ 'n', 'v', 'x' }, '<leader>y', '"+y')
map({ 'n', 'v', 'x' }, '<leader>d', '"+d')
map({ 'n', 'v', 'x' }, '<leader>p', '"+p')
map('n', '<esc>', '<cmd>nohlsearch<cr>')
map('n', '<leader>s', '<cmd>e #<cr>')
map('n', '<leader>d', vim.diagnostic.open_float)

-- Helix-like bindings
map({ 'n', 'v', 'x' }, 'U', '<c-r>')
map({ 'n', 'v', 'x' }, 'gh', '^')
map({ 'n', 'v', 'x' }, 'gl', '$')
map({ 'n', 'v', 'x' }, 'gH', 'g^')
map({ 'n', 'v', 'x' }, 'gL', 'g$')

map('n', '<leader>q', function() require('snacks').bufdelete() end)
map('n', '<leader>C', require('snacks').bufdelete.other)
map('n', '<leader>e', function()
  require('snacks').explorer({
    auto_close = true,
    hidden = true,
  })
end)

map('n', '<leader><leader>', require('snacks').picker.buffers)
map('n', '<leader>ff',
  function() require('snacks').picker.files({ hidden = true }) end)
map('n', '<leader>fg', require('snacks').picker.grep)
map('n', '<leader>fd', require('snacks').picker.diagnostics_buffer)
map('n', '<leader>fD', require('snacks').picker.diagnostics)
map('n', 'gO', require('snacks').picker.lsp_symbols)
map('n', '<f1>', require('snacks').picker.help)

map('n', '-', '<cmd>Oil<cr>')
map('n', '<leader>u', '<cmd>UndotreeShow<cr>')


-- ============================================================================
-- Misc. autocmds
-- ============================================================================

-- Highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank({ higroup = 'Search', timeout = 500 })
  end,
})


-- ============================================================================
-- Plugins
-- ============================================================================

require('mini.icons').setup()
require('mini.icons').mock_nvim_web_devicons()

require('kanagawa').setup({
  colors = {
    theme = {
      all = {
        ui = {
          bg_gutter = 'none',
        },
      },
    },
  },
  overrides = function(colors)
    local theme = colors.theme
    local makeDiagnosticColor = function(color)
      local c = require('kanagawa.lib.color')
      return { fg = color, bg = c(color):blend(theme.ui.bg, 0.95):to_hex() }
    end

    return {
      WinSeparator = { link = 'FloatBorder' },

      Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg },
      PmenuExtra = { fg = theme.syn.comment, bg = theme.ui.bg },
      PmenuSel = { fg = 'none', bg = theme.ui.bg_p2 },
      PmenuSbar = { bg = theme.ui.bg_m1 },
      PmenuThumb = { bg = theme.ui.bg_p2 },

      NormalFloat = { bg = 'none' },
      FloatBorder = { bg = 'none' },
      FloatTitle = { bg = 'none' },

      DiagnosticVirtualTextHint = makeDiagnosticColor(theme.diag.hint),
      DiagnosticVirtualTextInfo = makeDiagnosticColor(theme.diag.info),
      DiagnosticVirtualTextWarn = makeDiagnosticColor(theme.diag.warning),
      DiagnosticVirtualTextError = makeDiagnosticColor(theme.diag.error),

      BlinkCmpMenuBorder = { link = 'FloatBorder' },
    }
  end,
})
vim.cmd.colorscheme('kanagawa')

require('lualine').setup({
  options = {
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    globalstatus = true,
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = {
      { 'filetype', icon_only = true },
      {
        'filename',
        path = 1,
        symbols = { modified = ' ', readonly = ' ' },
      },
    },
    lualine_c = {},
    lualine_x = {
      'diagnostics',
      'lsp_status',
    },
    lualine_y = {
      { 'searchcount', maxcount = 999, timeout = 120 },
      { 'branch', icon = '' },
    },
    lualine_z = { 'progress', 'location', 'fileformat' },
  },

})

require('nvim-surround').setup()

require('mini.pairs').setup()
require('mini.ai').setup()
require('mini.sessions').setup()

require('snacks').setup({
  indent = {
    enabled = true,
    scope = { hl = 'SignColumn' },
    animate = { enabled = false },
  },
  picker = {
    enable = true,
    win = {
      list = {
        keys = {
          -- Mostly for file explorer
          ['w'] = { { 'pick_win', 'jump' }, mode = { 'n', 'i' } },
        },
      },
    },
  },
  explorer = { enable = true },
  bufdelete = { enable = true },
})

--- @diagnostic disable: missing-fields
require('nvim-treesitter.configs').setup({
  auto_install = true,
  highlight = { enable = true },
})

require('oil').setup({
  watch_for_changes = true,
  view_options = { show_hidden = true },
  win_options = {
    signcolumn = vim.o.signcolumn,
  },
})

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

require('fidget').setup({ notification = { override_vim_notify = true } })
require('guess-indent').setup()
require('gitsigns').setup()


-- ============================================================================
-- LSP
-- ============================================================================

-- Format on save
vim.api.nvim_create_autocmd('BufWritePre', {
  callback = function()
    vim.lsp.buf.format()
  end,
})

-- Folding
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    if client and client:supports_method('textDocument/foldingRange') then
      local win = vim.api.nvim_get_current_win()
      vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
    end
  end,
})

vim.lsp.enable({ 'lua_ls', 'nil_ls' })

vim.lsp.config('lua_ls', {
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if
          path ~= vim.fn.stdpath('config')
          and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
      then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force',
      client.config.settings.Lua, {
        runtime = {
          version = 'LuaJIT',
          path = { 'lua/?.lua', 'lua/?/init.lua' },
        },
        workspace = {
          checkThirdParty = false,
          library = { vim.env.VIMRUNTIME },
        },
      })
  end,
  settings = {
    Lua = {},
  },
})

vim.diagnostic.config({ virtual_text = true })
