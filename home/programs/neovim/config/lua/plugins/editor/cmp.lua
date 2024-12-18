local cmp = require('blink.cmp')

cmp.setup({
  keymap = {
    preset = 'enter',
    ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
    ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
  },
  snippets = {
    expand = function(args)
      vim.fn['UltiSnips#Anon'](args)
    end,
  },
  completion = {
    trigger = {
      -- Do not show menu automatically when inside a snippet
      show_in_snippet = false,
    },
    list = {
      selection = 'auto_insert',
    },
    menu = {
      border = 'rounded',
      winhighlight = '',
      max_height = 20,
    },
    documentation = {
      auto_show = true,
      window = {
        border = 'rounded',
      },
    },
    signature = {
      enabled = true,
      window = {
        border = 'rounded',
      },
    },
  },
  sources = {
    default = { 'lsp', 'path', 'buffer' },
  },
})

-- cmp.setup({
--   preselect = cmp.PreselectMode.None,
--   mapping = cmp.mapping.preset.insert({
--     ['<C-b>'] = cmp.mapping.scroll_docs(-4),
--     ['<C-f>'] = cmp.mapping.scroll_docs(4),
--     ['<C-Space>'] = cmp.mapping.complete(),
--     ['<C-e>'] = cmp.mapping.abort(),
--     ['<CR>'] = cmp.mapping.confirm({ select = false }),
--     ['<Tab>'] = with_fallback(cmp.select_next_item),
--     ['<S-Tab>'] = with_fallback(cmp.select_prev_item),
--   }),
--   sources = cmp.config.sources({
--     { name = 'nvim_lsp' },
--     { name = 'ultisnips' },
--     { name = 'async_path' },
--   }, {
--     {
--       name = 'buffer',
--       option = {
--         get_bufnrs = vim.api.nvim_list_bufs,
--       },
--     },
--   }),
--   window = {
--     completion = cmp.config.window.bordered({
--       winhighlight = 'Nomal:Pmenu,CursorLine:PmenuSel,Search:None',
--     }),
--   },
-- })
--
-- cmp.setup.cmdline({ '/', '?' }, {
--   completion = { autocomplete = false },
--   mapping = cmp.mapping.preset.cmdline(),
--   sources = {
--     { name = 'buffer' },
--   },
-- })
--
-- cmp.setup.cmdline(':', {
--   completion = { autocomplete = false },
--   mapping = cmp.mapping.preset.cmdline(),
--   sources = cmp.config.sources({
--     { name = 'async_path' },
--   }, {
--     { name = 'cmdline' },
--   }),
--   matching = { disallow_symbol_nonprefix_matching = false },
-- })
