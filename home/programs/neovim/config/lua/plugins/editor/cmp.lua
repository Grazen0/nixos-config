return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'quangnguyen30192/cmp-nvim-ultisnips',
  },
  opts = function()
    local cmp = require('cmp')

    return {
      preselect = cmp.PreselectMode.None,
      snippet = {
        expand = function(args)
          vim.fn['UltiSnips#Anon'](args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
        ['<C-p>'] = cmp.mapping.select_prev_item({
          behavior = cmp.SelectBehavior.Select,
        }),
        ['<C-n>'] = cmp.mapping.select_next_item({
          behavior = cmp.SelectBehavior.Select,
        }),
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'ultisnips' },
        { name = 'path' },
        { name = 'cmp_r' },
      }, {
        {
          name = 'buffer',
          option = {
            get_bufnrs = vim.api.nvim_list_bufs,
          },
        },
      }),
      formatting = {
        format = require('lspkind').cmp_format({
          mode = 'symbol',
          maxwidth = {
            menu = 50,
            abbr = 50,
          },
          ellipsis_char = '...',
          show_labelDetails = true,
        }),
      },
    }
  end,
  config = function(_, opts)
    local cmp = require('cmp')
    cmp.setup(opts)

    cmp.setup.cmdline({ '/', '?' }, {
      completion = { autocomplete = false },
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' },
      },
    })

    cmp.setup.cmdline(':', {
      completion = { autocomplete = false },
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'async_path' },
      }, {
        { name = 'cmdline' },
      }),
      matching = { disallow_symbol_nonprefix_matching = false },
    })
  end,
}
