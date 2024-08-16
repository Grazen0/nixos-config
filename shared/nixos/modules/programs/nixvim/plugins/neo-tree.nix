{
  programs.nixvim.plugins.neo-tree = {
    enable = true;

    # FIX: when quitting nvim from neo-tree, the last open window doesn't get saved

    window = {
      width = 30;

      mappings = {
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
        hideByName = [
          ".git"
          "__pycache__"
          ".DS_Store"
          "thumbs.db"
        ];
      };
    };

    eventHandlers.neo_tree_buffer_enter = ''
      function()
        vim.opt_local.relativenumber = true;
      end
    '';
  };
}
