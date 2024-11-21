require('neo-tree').setup({
  auto_clean_after_session_restore = true,
  popup_border_style = 'solid',
  close_if_last_window = true,
  hijack_netrw_behavior = 'open_current',

  window = {
    position = 'left',
    width = 30,

    mappings = {
      -- Telescope-like split aliases
      ['<C-v>'] = 'open_vsplit',
      ['<C-x>'] = 'open_split',

      -- Navigation with HJKL
      h = function(state)
        local node = state.tree:get_node()
        if node.type == 'directory' and node:is_expanded() then
          require('neo-tree.sources.filesystem').toggle_directory(state, node)
        else
          require('neo-tree.ui.renderer').focus_node(
            state,
            node:get_parent_id()
          )
        end
      end,
      l = function(state)
        local node = state.tree:get_node()
        if node.type == 'directory' then
          if not node:is_expanded() then
            require('neo-tree.sources.filesystem').toggle_directory(state, node)
          elseif node:has_children() then
            require('neo-tree.ui.renderer').focus_node(
              state,
              node:get_child_ids()[1]
            )
          end
        else
          state.commands.open(state)
        end
      end,

      -- Trash instead of delete
      d = function(state)
        local inputs = require('neo-tree.ui.inputs')
        local node = state.tree:get_node()
        local msg = 'Delete ' .. node.name .. '?'

        inputs.confirm(msg, function(confirmed)
          if not confirmed then
            return
          end

          vim.fn.system({ 'trash', vim.fn.fnameescape(node.path) })
          require('neo-tree.sources.manager').refresh(state.name)
        end)
      end,

      -- Open file with system viewer
      o = function(state)
        local node = state.tree:get_node()
        local path = node:get_id()
        vim.fn.jobstart({ 'xdg-open', path }, { detach = true })
      end,
    },
  },

  filesystem = {
    follow_current_file = { enabled = true },
    use_libuv_file_watcher = true,

    filtered_items = {
      show_hidden_count = false,
      hide_dotfiles = false,
      hide_gitignored = false,
      hide_by_name = {
        '.git',
        '__pycache__',
        '.DS_Store',
        'thumbs.db',
      },
    },
  },

  event_handlers = {
    {
      event = 'file_opened',
      handler = function()
        vim.cmd('Neotree close')
      end,
    },
    {
      event = 'neo_tree_buffer_enter',
      handler = function()
        vim.cmd('highlight! Cursor blend=100')
      end,
    },
    {
      event = 'neo_tree_buffer_leave',
      handler = function()
        vim.cmd('highlight! Cursor blend=0')
      end,
    },
  },
})

-- Needed so that the cursor gets hidden
vim.cmd('set guicursor+=a:Cursor/lCursor')

vim.keymap.set('n', '<leader>e', '<cmd>Neotree<CR>')
