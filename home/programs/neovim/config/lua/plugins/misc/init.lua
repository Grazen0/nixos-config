return {
  'tpope/vim-obsession',
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
    lazy = false,
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
