return {
  {
    'iurimateus/luasnip-latex-snippets.nvim',
    dependencies = { 'L3MON4D3/luasnip' },
    ft = { 'plaintex', 'tex' },
    opts = {},
  },
  {
    'L3MON4D3/luasnip',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      enable_autosnippets = true,
    },
    config = function(_, opts)
      require('luasnip').setup(opts)
      require('luasnip.loaders.from_lua').load({
        paths = { vim.fn.stdpath('config') .. '/lua/snippets' },
      })
    end,
  },
}
