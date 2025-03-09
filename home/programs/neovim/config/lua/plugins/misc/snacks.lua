return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  keys = {
    {
      '<leader>lg',
      function()
        require('snacks').lazygit()
      end,
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
      hl = 'SignColumn',
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
    rename = { enabled = true },
  },
}
