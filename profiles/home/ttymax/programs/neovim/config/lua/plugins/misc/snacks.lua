return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  keys = {
    {
      '<leader>e',
      function()
        require('snacks').explorer({ auto_close = true, hidden = true })
      end,
      desc = 'Open explorer',
    },
    {
      '<leader>q',
      function()
        require('snacks').bufdelete()
      end,
      desc = 'Delete buffer',
    },
    {
      '<leader>C',
      function()
        require('snacks').bufdelete.other()
      end,
      desc = 'Delete other buffers',
    },
    {
      '<F1>',
      function()
        require('snacks').picker.help()
      end,
      desc = 'Find help tags',
    },
    {
      '<leader><leader>',
      function()
        require('snacks').picker.buffers()
      end,
      desc = 'Find buffers',
    },
    {
      '<leader>ff',
      function()
        require('snacks').picker.files({ hidden = true })
      end,
      desc = 'Find files',
    },
    {
      '<leader>fg',
      function()
        require('snacks').picker.grep()
      end,
      desc = 'Find with grep',
    },
    {
      '<leader>fd',
      function()
        require('snacks').picker.diagnostics_buffer()
      end,
      desc = 'Find buffer diagnostics',
    },
    {
      '<leader>fD',
      function()
        require('snacks').picker.diagnostics()
      end,
      desc = 'Find diagnostics',
    },
    {
      '<leader>ft',
      function()
        require('snacks').picker.pick({ source = 'todo_comments' })
      end,
      desc = 'Find todo comments',
    },
    {
      '<leader>fm',
      function()
        require('snacks').picker.man()
      end,
      desc = 'Find man pages',
    },
    {
      'gd',
      function()
        require('snacks').picker.lsp_definitions()
      end,
      desc = 'Goto Definition',
    },
    {
      'gD',
      function()
        require('snacks').picker.lsp_declarations()
      end,
      desc = 'Goto Declaration',
    },
    {
      'grr',
      function()
        require('snacks').picker.lsp_references()
      end,
      desc = 'References',
    },
    {
      'gI',
      function()
        require('snacks').picker.lsp_implementations()
      end,
      desc = 'Goto Implementation',
    },
    {
      'gO',
      function()
        require('snacks').picker.lsp_symbols()
      end,
      desc = 'Open Document symbols',
    },
    {
      'gW',
      function()
        require('snacks').picker.lsp_workspace_symbols()
      end,
      desc = 'Open Workspace symbols',
    },
    {
      'grt',
      function()
        require('snacks').picker.lsp_type_definitions()
      end,
      desc = 'Goto Type Definition',
    },
  },
  opts = {
    bigfile = { enabled = true },
    quickfile = { enabled = true },
    indent = {
      enabled = true,
      scope = { hl = 'SignColumn' },
      animate = { enabled = false },
    },
    input = {
      enabled = true,
      icon = '',
      win = {
        border = vim.o.winborder,
        relative = 'cursor',
        title_pos = 'left',
        width = 40,
        row = -3,
        col = -1,
      },
    },
    picker = {
      enable = true,
      win = {
        list = {
          keys = {
            -- Mostly for file explorer
            ['w'] = { { 'pick_win', 'jump' }, mode = { 'n', 'i' } },
          },
        },
      },
      layouts = {
        default = {
          layout = {
            box = 'horizontal',
            width = 0.8,
            min_width = 120,
            height = 0.8,
            {
              box = 'vertical',
              border = vim.o.winborder,
              title = '{title} {live} {flags}',
              { win = 'input', height = 1, border = 'bottom' },
              { win = 'list', border = 'none' },
            },
            {
              win = 'preview',
              title = '{preview}',
              border = vim.o.winborder,
              width = 0.5,
            },
          },
        },
        sidebar = {
          preview = 'main',
          layout = {
            backdrop = false,
            width = 40,
            min_width = 40,
            height = 0,
            position = 'left',
            border = 'none',
            box = 'vertical',
            {
              win = 'input',
              height = 1,
              border = vim.o.winborder,
              title = '{title} {live} {flags}',
              title_pos = 'center',
            },
            { win = 'list', border = 'none' },
            {
              win = 'preview',
              title = '{preview}',
              height = 0.4,
              border = 'top',
            },
          },
        },
        select = {
          preview = false,
          layout = {
            backdrop = false,
            width = 0.5,
            min_width = 80,
            height = 0.4,
            min_height = 3,
            box = 'vertical',
            border = vim.o.winborder,
            title = '{title}',
            title_pos = 'center',
            { win = 'input', height = 1, border = 'bottom' },
            { win = 'list', border = 'none' },
            {
              win = 'preview',
              title = '{preview}',
              height = 0.4,
              border = 'top',
            },
          },
        },
      },
    },
    explorer = { enable = true },
    rename = { enabled = true },
    bufdelete = { enabled = true },
  },
}
