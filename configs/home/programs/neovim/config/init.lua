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

vim.cmd('packadd! nvim.undotree')
vim.cmd('packadd! termdebug')

-- ============================================================================
-- Autocmds
-- ============================================================================

vim.filetype.add({
  extension = {
    v = 'systemverilog',
    vh = 'systemverilog',
    tf = 'terraform',
    uma = 'uma',
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
  'https://github.com/neovim/nvim-lspconfig',
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
  'https://github.com/stevearc/conform.nvim',
  'https://github.com/windwp/nvim-ts-autotag',
  'https://github.com/alexghergh/nvim-tmux-navigation',
  'https://github.com/nmac427/guess-indent.nvim',
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/nvim-pack/nvim-spectre',
  'https://github.com/nvim-mini/mini.completion',
  'https://github.com/nvim-mini/mini.files',
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
  'https://github.com/mfussenegger/nvim-jdtls',
  'https://github.com/chomosuke/typst-preview.nvim',
  'https://github.com/kndndrj/nvim-dbee',
  'https://github.com/MunifTanjim/nui.nvim',
})

require('mini.icons').setup({
  extension = {
    uma = { glyph = '', hl = 'MiniIconsOrange' },
  },
})
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

vim.api.nvim_create_autocmd('User', {
  pattern = 'MiniFilesActionRename',
  callback = function(event)
    require('snacks').rename.on_rename_file(event.data.from, event.data.to)
  end,
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
map('n', '<leader>fd', Snacks.picker.diagnostics_buffer)
map('n', '<leader>fD', Snacks.picker.diagnostics)
map('n', '<leader>fm', Snacks.picker.man)
map('n', 'gd', Snacks.picker.lsp_definitions)
map('n', 'gD', Snacks.picker.lsp_declarations)
map('n', 'grr', Snacks.picker.lsp_references)
map('n', 'gO', Snacks.picker.lsp_symbols)

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

vim.api.nvim_create_autocmd('User', {
  pattern = 'TSUpdate',
  callback = function()
    require('nvim-treesitter.parsers').uma = {
      install_info = {
        path = '~/Code/utec/compi/tracen/tree-sitter-uma',
        generate = true,
      },
    }
  end,
})

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

require('mini.completion').setup()

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'snacks_picker_input',
  command = 'lua vim.b.minicompletion_disable = true',
})

require('mini.files').setup({
  options = {
    permanent_delete = false,
  },
  windows = {
    preview = true,
  },
})
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

require('dbee').setup()

local conform = require('conform')
conform.setup({
  formatters_by_ft = {
    arduino = { 'clang-format' },
    css = { 'prettierd' },
    graphql = { 'prettierd' },
    haskell = { 'ormolu' },
    html = { 'prettierd' },
    javascript = { 'prettierd' },
    javascriptreact = { 'prettierd' },
    json = { 'prettierd' },
    markdown = { 'prettierd' },
    nix = { 'nixfmt' },
    python = { 'isort', 'black' },
    quarto = { 'prettierd' },
    r = { 'styler' },
    rust = { 'rustfmt' },
    sass = { 'prettierd' },
    scss = { 'prettierd' },
    typescript = { 'prettierd' },
    typescriptreact = { 'prettierd' },
    typst = { 'typstyle' },
    yaml = { 'prettierd' },
    terraform = { 'terraform_fmt' },
  },
  format_on_save = function(bufnr)
    -- Disable with a global or buffer-local variable
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end

    return {
      timeout_ms = 2000,
      lsp_format = 'fallback',
    }
  end,
})

vim.api.nvim_create_user_command('FormatEnable', function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, { bang = true })

vim.api.nvim_create_user_command('FormatDisable', function(args)
  if args.bang then
    -- FormatDisable! will disable formatting just for this buffer
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, { bang = true })

-- Save without formatting
vim.api.nvim_create_user_command('Mfw', function()
  local prev = vim.b.disable_autoformat
  vim.b.disable_autoformat = true
  vim.cmd('write')
  vim.b.disable_autoformat = prev
end, {})

-- Format command
vim.api.nvim_create_user_command('Format', function(args)
  local range = nil

  if args.count ~= -1 then
    local end_line =
        vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ['end'] = { args.line2, end_line:len() },
    }
  end

  conform.format({
    async = true,
    lsp_format = 'fallback',
    range = range,
  })
end, { range = true })

-- ============================================================================
-- LSP
-- ============================================================================

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

vim.diagnostic.config({
  virtual_text = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = ' ',
      [vim.diagnostic.severity.WARN] = ' ',
      [vim.diagnostic.severity.HINT] = ' ',
      [vim.diagnostic.severity.INFO] = ' ',
    },
  },
})
vim.lsp.on_type_formatting.enable()

local default_capabilities = {
  textDocument = {
    onTypeFormatting = {
      dynamicRegistration = true,
    },
    foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true,
    },
  },
}

local servers = {
  pyright = {},
  bashls = {},
  clangd = {
    cmd = {
      'clangd',
      '--background-index',
      '--clang-tidy',
      '--completion-style=detailed',
      '--header-insertion=iwyu',
      '--pch-storage=memory',
    },
  },
  cssls = {},
  eslint = {},
  gopls = {},
  html = {},
  jsonls = {},
  lua_ls = {
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

      client.config.settings.Lua =
          vim.tbl_deep_extend('force', client.config.settings.Lua, {
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
    settings = { Lua = {} },
  },
  nil_ls = {},
  rust_analyzer = {
    settings = {
      ['rust-analyzer'] = { check = { command = 'clippy' } },
    },
  },
  sqls = { cmd = { 'sqls', '-config', '~/.config/sqls/config.yml' } },
  statix = {},
  svelte = {},
  tailwindcss = {},
  terraform_lsp = {},
  texlab = {},
  tinymist = {},
  ts_ls = {},
  verible = { cmd = { 'verible-verilog-ls', '--rules_config_search' } },
  yamlls = {},
  zls = {},
  umals = {
    cmd = { 'target/debug/umals', '--stdio' },
    filetypes = { 'uma' },
    root_markers = { '.git' },
  },
}

for server, config in pairs(servers) do
  vim.lsp.enable(server)

  config.capabilities = vim.tbl_deep_extend('force', default_capabilities,
    config.capabilities or {
    })
  vim.lsp.config(server, config)
end
