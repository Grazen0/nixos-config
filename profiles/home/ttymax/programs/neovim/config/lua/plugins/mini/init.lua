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
    'echasnovski/mini.pairs',
    event = 'VeryLazy',
    opts = {},
  },
  {
    'echasnovski/mini.hipatterns',
    event = 'VeryLazy',
    dependencies = { 'echasnovski/mini.extra' },
    opts = function()
      return {
        highlighters = {
          hex_color = require('mini.hipatterns').gen_highlighter.hex_color(),
        },

      }
    end,
  },
  {
    'echasnovski/mini.sessions',
    opts = {},
  },
}
