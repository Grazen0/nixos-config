-- See https://github.com/stevearc/oil.nvim/blob/master/doc/recipes.md#show-cwd-in-the-winbar
function _G.get_oil_winbar()
  local dir = require('oil').get_current_dir()
  if dir then
    return vim.fn.fnamemodify(dir, ':.')
  else
    return vim.api.nvim_buf_get_name(0)
  end
end

local detail = false

return {
  'stevearc/oil.nvim',
  dependencies = { 'echasnovski/mini.icons' },
  lazy = false,
  opts = {
    delete_to_trash = true,
    watch_for_changes = true,
    view_options = {
      show_hidden = true,
    },
    keymaps = {
      ['<c-v>'] = { 'actions.select', opts = { vertical = true } },
      ['<c-s>'] = { 'actions.select', opts = { horizontal = true } },
      -- See https://github.com/stevearc/oil.nvim/blob/master/doc/recipes.md#show-cwd-in-the-winbar
      ['gd'] = {
        desc = 'Toggle file detail view',
        callback = function()
          detail = not detail
          if detail then
            require('oil').set_columns({
              'icon',
              'permissions',
              'size',
              'mtime',
            })
          else
            require('oil').set_columns({ 'icon' })
          end
        end,
      },
    },
    win_options = {
      -- See https://github.com/stevearc/oil.nvim/issues/301#issuecomment-2399987685
      winbar = ' %#@attribute.builtin#%{v:lua.get_oil_winbar()} ',
      signcolumn = vim.o.signcolumn,
    },
  },
  keys = {
    {
      '-',
      mode = 'n',
      '<cmd>Oil<cr>',
      desc = 'Open parent directory',
    },
  },
}
