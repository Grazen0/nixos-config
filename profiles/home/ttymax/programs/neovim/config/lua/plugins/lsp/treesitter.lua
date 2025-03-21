return {
  {
    'nvim-treesitter/nvim-treesitter',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      highlight = {
        enable = true,
        disable = { 'latex' }, -- Managed by vimtex
      },
    },
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end,
  },
  {

    'nvim-treesitter/nvim-treesitter-context',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {},
  },
  {
    'nvim-treesitter/nvim-treesitter-refactor',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
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
    config = function(_, opts)
      require('nvim-treesitter.configs').setup({ refactor = opts })
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      select = {
        enable = true,
        lookahead = true,
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
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          [']m'] = '@function.outer',
          [']]'] = '@class.outer',
          [']o'] = '@loop.outer',
          [']s'] = '@local.scope',
          [']z'] = '@fold',
        },
        goto_next_end = {
          [']M'] = '@function.outer',
          [']['] = '@class.outer',
          [']O'] = '@loop.outer',
          [']S'] = '@local.scope',
          [']Z'] = '@fold',
        },
        goto_previous_start = {
          ['[m'] = '@function.outer',
          ['[['] = '@class.outer',
          ['[o'] = '@loop.outer',
          ['[s'] = '@local.scope',
          ['[z'] = '@fold',
        },
        goto_previous_end = {
          ['[M'] = '@function.outer',
          ['[]'] = '@class.outer',
          ['[O'] = '@loop.outer',
          ['[S'] = '@local.scope',
          ['[Z'] = '@fold',
        },
      },
    },
    config = function(_, opts)
      require('nvim-treesitter.configs').setup({ textobjects = opts })
    end,
  },
}
