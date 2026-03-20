return {
  {
    'echasnovski/mini.ai',
    event = 'VeryLazy',
    opts = {},
  },
  {

    'echasnovski/mini.icons',
    lazy = false,
    setup = function(_, opts)
      local MiniIcons = require('mini.icons')
      MiniIcons.setup(opts)
      MiniIcons.mock_nvim_web_devicons()
    end,
  },
  {
    'echasnovski/mini.pairs',
    event = 'VeryLazy',
    opts = {},
  },
  {
    'echasnovski/mini.sessions',
    opts = {},
  },
}
