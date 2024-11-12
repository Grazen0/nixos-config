require('nvim-treesitter.configs').setup({
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
})
