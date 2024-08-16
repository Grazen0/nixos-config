{
  programs.nixvim.plugins.neo-tree = {
    enable = true;

    window = {
      width = 30;

      mappings = {
        "<Tab>".__raw = ''
          function()
            -- TODO: preview if current node is file, else (if directory) open
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
