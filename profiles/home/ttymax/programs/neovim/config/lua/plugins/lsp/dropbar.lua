return {
  'Bekaboo/dropbar.nvim',
  enabled = false,
  event = { 'BufReadPre', 'BufNewFile' },
  keys = {
    {
      '<leader>;',
      function()
        require('dropbar.api').pick()
      end,
      desc = 'Pick symbols in winbar',
    },
    {
      '[;',
      function()
        require('dropbar.api').goto_context_start()
      end,
      { desc = 'Go to start of current context' },
    },
    {
      '];',
      function()
        require('dropbar.api').select_next_context()
      end,
      { desc = 'Select next context' },
    },
  },
  opts = {
    bar = {
      pick = { pivots = 'fjdksla;cmrueiwoqp' },
    },
    menu = {
      win_configs = { border = 'single' },
      keymaps = {
        -- Go up
        ['h'] = function()
          vim.cmd('close')
        end,

        -- Go down
        ['l'] = function()
          local utils = require('dropbar.utils')
          local menu = utils.menu.get_current()
          if not menu then
            return
          end
          local cursor = vim.api.nvim_win_get_cursor(menu.win)
          local component = menu.entries[cursor[1]]:first_clickable(1)
          if component then
            menu:click_on(component, nil, 1, 'l')
          end
        end,

        -- Go to current selection
        ['<CR>'] = function()
          local utils = require('dropbar.utils')
          local menu = utils.menu.get_current()
          if not menu then
            return
          end
          local cursor = vim.api.nvim_win_get_cursor(menu.win)
          local win_width = vim.api.nvim_win_get_width(menu.win)
          local component = menu.entries[cursor[1]]:first_clickable(win_width)
          if component then
            menu:click_on(component, nil, 1, 'l')
          end
        end,
      },
    },
    sources = {
      path = {
        max_depth = 1,
      },
    },
  },
}
