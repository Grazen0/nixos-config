require('telescope').setup({
  defaults = {
    sorting_strategy = 'descending',

    file_ignore_patterns = {
      '^.git/',
      '^.mypy_cache/',
      '^__pycache__/',
      '^output/',
      '^data/',
      'dist/',
      'build/',
      'target/',
      'result/',

      '%.o',
      '%.a',
      '%.out',
      '%.ipynb',
      '%.class',
      '%.pdf',
      '%.mkv',
      '%.mp4',
      '%.png',
      '%.jpg',
      '%.jpeg',
      '%.webp',
      '%.gif',
    },

    mappings = {
      n = {
        ['<S-d>'] = 'delete_buffer',
      },
    },
  },
})

local builtin = require('telescope.builtin')
local keyset = vim.keymap.set
keyset('n', '<leader>ff', builtin.find_files)
keyset('n', '<leader>fg', builtin.live_grep)
keyset('n', '<leader>fb', builtin.buffers)
keyset('n', '<leader>fh', builtin.help_tags)
keyset('n', '<leader>fr', builtin.lsp_references)
keyset('n', '<leader>fi', builtin.lsp_implementations)
keyset('n', '<leader>fd', builtin.lsp_definitions)
