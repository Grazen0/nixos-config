return {
  {
    'echasnovski/mini.ai',
    event = 'VeryLazy',
    dependencies = { 'echasnovski/mini.extra' },
    opts = function()
      return {
        custom_textobjects = {
          e = require('mini.extra').gen_ai_spec.buffer(),
        },
      }
    end,
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
