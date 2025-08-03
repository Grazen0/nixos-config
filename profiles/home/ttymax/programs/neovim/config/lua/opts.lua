local o = vim.opt

-- Just in case
o.encoding = 'utf-8'
o.compatible = false
o.termguicolors = true
-- Numbering and stuff
o.number = true
o.relativenumber = true
o.signcolumn = 'yes'
o.scrolloff = 4
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

-- Fold
-- https://www.reddit.com/r/neovim/comments/1jmqd7t/sorry_ufo_these_7_lines_replaced_you/
vim.o.foldenable = true
vim.o.foldlevel = 99
vim.o.foldtext = ''
vim.opt.foldcolumn = '1'
vim.o.foldmethod = 'expr'
vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.fillchars:append({
  fold = ' ',
  foldopen = '',
  foldclose = '',
  foldsep = ' ',
})

-- Use LSP folding if available
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client:supports_method('textDocument/foldingRange') then
      local win = vim.api.nvim_get_current_win()
      vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
    end
  end,
})
vim.api.nvim_create_autocmd('LspDetach', { command = 'setl foldexpr<' })

-- Misc (?)
o.showmode = false
o.list = true
o.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
o.autoread = true
o.mouse = 'a' -- No shame
o.splitright = true
o.splitbelow = true
o.undofile = true
o.updatetime = 300
o.spell = true
o.spelllang = { 'es', 'en_us' }
o.confirm = true
o.winborder = 'single'

vim.g.tex_flavor = 'latex'
