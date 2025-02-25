local header = {
  [[                                                                       ]],
  [[                                                                     ]],
  [[       ████ ██████           █████      ██                     ]],
  [[      ███████████             █████                             ]],
  [[      █████████ ███████████████████ ███   ███████████   ]],
  [[     █████████  ███    █████████████ █████ ██████████████   ]],
  [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
  [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
  [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
  [[                                                                       ]],
  [[                                                                       ]],
  [[                                                                       ]],
  [[                                                                       ]],
}

return {
  {
    'tpope/vim-obsession',
    event = 'VeryLazy',
  },
  {
    'nvimdev/dashboard-nvim',
    event = 'VimEnter',
    opts = {
      theme = 'doom',
      hide = {
        statusline = false,
      },
      config = {
        header = header,
        week_header = {
          enable = false,
        },
        center = {
          {
            icon = '  ',
            desc = 'New file                    ',
            key = 'e',
            key_format = '%s',
            action = 'enew',
          },
          {
            icon = '  ',
            desc = 'Find a file',
            key = 'f',
            key_format = '%s',
            action = 'FzfLua files',
          },
          {
            icon = '  ',
            desc = 'Find a word',
            key = 'g',
            key_format = '%s',
            action = 'FzfLua live_grep_native',
          },
          {
            icon = '  ',
            desc = 'Recent files',
            key = 'h',
            key_format = '%s',
            action = 'FzfLua oldfiles',
          },
          {
            icon = '  ',
            desc = 'Quit',
            key = 'q',
            key_format = '%s',
            action = 'qa!',
          },
        },
        vertical_center = true,
      },
    },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    keys = {
      {
        '<leader>?',
        function()
          require('which-key').show({ global = false })
        end,
        desc = 'Buffer Local Keymaps (which-key)',
      },
    },
    opts = {
      delay = 1000,
      win = { border = 'solid' },
    },
  },
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown', 'quarto' },
    init = function()
      vim.g.mkdp_filetypes = { 'markdown', 'quarto' }
    end,
  },
  {
    'Saecki/crates.nvim',
    config = true,
    ft = { 'rust', 'toml' },
  },
  {
    'jbyuki/instant.nvim',
    enabled = false,
    init = function()
      vim.g.instant_username = 'Grazen'
    end,
  },
  {
    'azratul/live-share.nvim',
    enabled = false,
    dependencies = { 'jbyuki/instant.nvim' },
  },
  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = { 'BufReadPre', 'BufNewFile' },
    config = true,
  },
  {
    'lervag/vimtex',
    ft = { 'tex', 'plaintex' },
    init = function()
      vim.g.vimtex_view_method = 'zathura'
      vim.g.vimtex_compiler_latexmk = {
        out_dir = 'dist',
      }
    end,
  },
}
