require('nvim-treesitter.configs').setup({
  highlight = {
    enable = true,
    disable = { 'latex' },
  },
  refactor = {
    navigation = {
      enable = true,
      keymaps = {
        goto_definition_lsp_fallback = 'gd',
        list_definitions = 'gD',
        list_definitions_toc = 'gO',
        goto_next_usage = '<A-*>',
        goto_previous_usage = '<A-#>',
      },
    },
  },
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
        ['ai'] = '@conditional.outer',
        ['ii'] = '@conditional.inner',
        ['al'] = '@loop.outer',
        ['il'] = '@loop.inner',
        ['ak'] = '@block.outer',
        ['ik'] = '@block.inner',
        ['is'] = '@statement.inner',
        ['as'] = '@statement.outer',
        ['ad'] = '@comment.outer',
        ['am'] = '@call.outer',
        ['im'] = '@call.inner',
      },
    },
  },
})

vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldmethod = 'expr'
vim.opt.foldlevel = 99
