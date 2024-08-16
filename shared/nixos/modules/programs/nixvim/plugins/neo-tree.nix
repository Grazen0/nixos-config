{
  programs.nixvim.plugins.neo-tree = {
    enable = true;

    window = {
      width = 30;

      mappings = {
        # Open directory or preview file with tab
        "<Tab>".__raw = ''
          function(state)
            local node = state.tree:get_node()
            if require("neo-tree.utils").is_expandable(node) then
              state.commands["toggle_node"](state)
            else
              state.commands.open(state)
              vim.cmd("Neotree reveal")
            end
          end
        '';

        # Navigation with HJKL
        h.__raw = ''
          function(state)
            local node = state.tree:get_node();
            if node.type == "directory" and node:is_expanded() then
              require("neo-tree.sources.filesystem").toggle_directory(state, node);
            else
              require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id());
            end
          end
        '';
        l.__raw = ''
          function(state)
            local node = state.tree:get_node()
            if node.type == "directory" then
              if not node:is_expanded() then
                require("neo-tree.sources.filesystem").toggle_directory(state, node);
              elseif node:has_children() then
                require("neo-tree.ui.renderer").focus_node(state, node:get_child_ids()[1]);
              end
            else
              state.commands.open(state);
            end
          end
        '';

        # Trash instead of delete
        d.__raw = ''
          function(state)
          	local inputs = require("neo-tree.ui.inputs");
          	local node = state.tree:get_node();
          	local msg = "Delete " .. node.name .. "?";

          	inputs.confirm(msg, function(confirmed)
          	  if not confirmed then
                return;
              end

          		vim.fn.system({ "trash", vim.fn.fnameescape(node.path) });
          		require("neo-tree.sources.manager").refresh(state.name);
           	end);
          end
        '';

        # Switch between filesystem, buffers and git_status
        e.__raw = ''
          function()
            vim.api.nvim_exec('Neotree focus filesystem left', true);
          end
        '';
        b.__raw = ''
          function()
            vim.api.nvim_exec('Neotree focus buffers left', true)
          end
        '';
        g.__raw = ''
          function()
            vim.api.nvim_exec('Neotree focus git_status left', true)
          end
        '';

        # Open file with system viewer
        o.__raw = ''
          function(state)
            local node = state.tree:get_node();
            local path = node:get_id();
            vim.fn.jobstart({ "xdg-open", path }, { detach = true });
          end
        '';
      };
    };

    filesystem = {
      followCurrentFile.enabled = true;
      hijackNetrwBehavior = "open_current";
      filteredItems = {
        showHiddenCount = false;
        hideDotfiles = false;
        hideGitignored = false;
      };
    };

    eventHandlers = {
      neo_tree_buffer_enter = ''
        function()
          vim.opt_local.relativenumber = true;

          -- Hide cursor
          local hl = vim.api.nvim_get_hl_by_name('Cursor', true)
          hl.blend = 100
          vim.api.nvim_set_hl(0, 'Cursor', hl)
          vim.opt.guicursor:append('a:Cursor/lCursor')
        end
      '';

      neo_tree_buffer_leave = ''
        function()
          -- Show cursor
          local hl = vim.api.nvim_get_hl_by_name('Cursor', true)
          hl.blend = 0
          vim.api.nvim_set_hl(0, 'Cursor', hl)
          vim.opt.guicursor:remove('a:Cursor/lCursor')
        end
      '';
    };
  };
}
