{pkgs, ...}: {
  programs.nixvim = {
    plugins.neo-tree = {
      enable = true;

      autoCleanAfterSessionRestore = true;

      window = {
        width = 30;

        mappings = {
          # Telescope-like split aliases
          "<C-v>" = "open_vsplit";
          "<C-x>" = "open_split";

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
                if not confirmed then return; end

                vim.fn.system({ "trash", vim.fn.fnameescape(node.path) });
                require("neo-tree.sources.manager").refresh(state.name);
              end);
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
          -- Refresh filesystem
          local events = require("neo-tree.events");
          events.fire_event(events.GIT_EVENT);
        end
      '';
    };

    extraPlugins = with pkgs.vimPlugins; [
      nvim-window-picker
    ];
  };
}
