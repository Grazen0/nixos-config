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
}
