{
  programs.nixvim = {
    autoGroups = {
      float_diagnostic_cursor = {};
      highlight_yank = {};
    };

    autoCmd = [
      {
        # Restore cursor position (no idea how it works)
        event = ["BufReadPost"];
        pattern = "*";
        command = "silent! normal! g`\"zv";
      }
      {
        # Show diagnostic window when cursor is over warning/error
        event = ["CursorHold" "CursorHoldI"];
        group = "float_diagnostic_cursor";
        callback.__raw = ''
          function()
          	vim.diagnostic.open_float(
          		nil,
          		{ focus = false, scope = "cursor" }
          	)
          end
        '';
      }
      {
        # Highlight yanked text
        event = ["TextYankPost"];
        group = "highlight_yank";
        pattern = "*";
        callback.__raw = ''
          function()
            vim.highlight.on_yank({ higroup = "Search", timeout = 500 });
          end
        '';
      }
      # {
      #   # Respawn nvim-tree on session opened
      #   event = ["BufEnter"];
      #   pattern = "NvimTree*";
      #   callback.__raw = ''
      #     function()
      #       local api = require("nvim-tree.api");
      #       local view = require("nvim-tree.view");
      #
      #       if not view.is_visible() then
      #         api.tree.open();
      #       end
      #     end
      #   '';
      # }
    ];
  };
}
