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
      win = { border = vim.o.winborder },
      preset = 'helix',
    },
  },
  {
    'iamcco/markdown-preview.nvim',
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
  {
    'j-hui/fidget.nvim',
    enabled = false,
    event = 'VeryLazy',
    opts = {
      notification = {
        override_vim_notify = true,
      },
    },
  },
  {
    'jghauser/mkdir.nvim',
    enabled = false,
    event = 'BufWritePre',
  },
  {
    'kndndrj/nvim-dbee',
    dependencies = { 'MunifTanjim/nui.nvim' },
    cmd = 'Dbee',
    opts = {},
  },
  {
    'mpas/marp-nvim',
    cmd = { 'MarpStart', 'MarpStatus', 'MarpToggle' },
    opts = {},
  },
  {
    'RaafatTurki/hex.nvim',
    event = 'VeryLazy',
    opts = {},
  },
}
