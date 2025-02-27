return {
  {
    'tpope/vim-obsession',
    event = 'VeryLazy',
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
    ft = { 'rust', 'toml' },
    opts = {},
  },
  {
    'azratul/live-share.nvim',
    cmd = { 'LiveShareJoin', 'LiveShareServer' },
    dependencies = {
      {
        'jbyuki/instant.nvim',
        init = function()
          vim.g.instant_username = 'Grazen'
        end,
      },
    },
    opts = {},
  },
  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {},
  },
  {
    'lervag/vimtex',
    ft = { 'tex', 'plaintex' },
    init = function()
      vim.g.vimtex_view_method = 'zathura'
      vim.g.vimtex_compiler_latexmk = {
        out_dir = 'build',
      }
    end,
  },
}
