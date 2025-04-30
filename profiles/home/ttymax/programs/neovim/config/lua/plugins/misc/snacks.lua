return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  keys = {
    {
      '<leader>e',
      function()
        require('snacks').explorer({ auto_close = true })
      end,
      desc = 'Open explorer',
    },
    {
      '<leader>lg',
      function()
        require('snacks').lazygit()
      end,
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
        require('snacks').picker.files()
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
      '<leader>ft',
      function()
        require('snacks').picker.pick({ source = 'todo_comments' })
      end,
      desc = 'Find todo comments',
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
      'gr',
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
  },
  opts = {
    bigfile = { enabled = true },
    quickfile = { enabled = true },
    lazygit = {
      enabled = true,
      win = { border = 'single' },
    },
    dashboard = {
      enabled = true,
      preset = {
        header = [[
                                                                    
      ████ ██████           █████      ██                     
     ███████████             █████                             
     █████████ ███████████████████ ███   ███████████   
    █████████  ███    █████████████ █████ ██████████████   
   █████████ ██████████ █████████ █████ █████ ████ █████   
 ███████████ ███    ███ █████████ █████ █████ ████ █████  
██████  █████████████████████ ████ █████ █████ ████ ██████ 
        ]],
        keys = {
          {
            icon = '  ',
            key = 'e',
            desc = 'New file',
            action = ':ene | startinsert',
          },
          {
            icon = '  ',
            key = 'f',
            desc = 'Find a file',
            action = ':FzfLua files',
          },
          {
            icon = '  ',
            key = 'g',
            desc = 'Find a word',
            action = ':FzfLua live_grep_native',
          },
          {
            icon = '  ',
            key = 'r',
            desc = 'Recent files',
            action = ':FzfLua oldfiles',
          },
          { icon = '  ', key = 'q', desc = 'Quit', action = ':qa!' },
        },
      },
      sections = {
        { section = 'header' },
        { section = 'keys', gap = 1, padding = 1 },
        { section = 'startup', icon = '' },
      },
    },
    indent = {
      enabled = true,
      scope = { hl = 'SignColumn' },
      animate = { enabled = false },
    },
    input = {
      enabled = true,
      icon = '',
      win = {
        border = 'single',
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
              border = 'single',
              title = '{title} {live} {flags}',
              { win = 'input', height = 1, border = 'bottom' },
              { win = 'list', border = 'none' },
            },
            {
              win = 'preview',
              title = '{preview}',
              border = 'single',
              width = 0.5,
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
