{pkgs, ...}: {
  programs.nvf.settings.vim = {
    extraPlugins.multicursor = {
      package = pkgs.multicursor-nvim;
      setup = "require('multicursor-nvim').setup()";
    };

    # Customize how cursors look.
    luaConfigRC.multicursor = ''
      local hl = vim.api.nvim_set_hl
      hl(0, "MultiCursorCursor", { link = "Cursor" })
      hl(0, "MultiCursorVisual", { link = "Visual" })
      hl(0, "MultiCursorSign", { link = "SignColumn"})
      hl(0, "MultiCursorDisabledCursor", { link = "Visual" })
      hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
      hl(0, "MultiCursorDisabledSign", { link = "SignColumn"})
    '';

    maps = let
      mkLuaAction = action: {
        inherit action;
        silent = true;
        lua = true;
      };

      mkLuaFunction = code:
        mkLuaAction ''
          function()
            ${code}
          end
        '';

      normalAndVisual = {
        # Add or skip cursor above/below the main cursor.
        "<Up>" = mkLuaFunction "require('multicursor-nvim').lineAddCursor(-1)";
        "<Down>" = mkLuaFunction "require('multicursor-nvim').lineAddCursor(1)";
        "<leader><Up>" = mkLuaFunction "require('multicursor-nvim').lineSkipCursor(-1)";
        "<leader><Down>" = mkLuaFunction "require('multicursor-nvim').lineSkipCursor(1)";

        # Add or skip adding a new cursor by matching word/selection
        # "<leader>n" = mkLuaFunction "require('multicursor-nvim').matchAddCursor(1)";
        # "<leader>s" = mkLuaFunction "require('multicursor-nvim').matchSkipCursor(1)";
        # "<leader>N" = mkLuaFunction "require('multicursor-nvim').matchAddCursor(-1)";
        # "<leader>S" = mkLuaFunction "require('multicursor-nvim').matchSkipCursor(-1)";

        # Add all matches in the document
        "<leader>A" = mkLuaAction "require('multicursor-nvim').matchAllAddCursors";

        # Rotate the main cursor.
        "<Left>" = mkLuaAction "require('multicursor-nvim').nextCursor";
        "<Right>" = mkLuaAction "require('multicursor-nvim').prevCursor";

        # Delete the main cursor.
        "<leader>x" = mkLuaAction "require('multicursor-nvim').deleteCursor";

        # Easy way to add and remove cursors using the main cursor.
        "<C-q>" = mkLuaAction "require('multicursor-nvim').toggleCursor";

        # Clone every cursor and disable the originals.
        "<leader><C-q>" = mkLuaAction "require('multicursor-nvim').duplicateCursors";

        # bring back cursors if you accidentally clear them
        "<leader>gv" = mkLuaAction "require('multicursor-nvim').restoreCursors";

        # Align cursor columns.
        "<leader>a" = mkLuaAction "require('multicursor-nvim').alignCursors";

        # Append/insert for each line of visual selections.
        "I" = mkLuaAction "require('multicursor-nvim').insertVisual";
        # "A" = mkLuaAction "require('multicursor-nvim').appendVisual"; # Has a weird bug

        # match new cursors within visual selections by regex.
        "M" = mkLuaAction "require('multicursor-nvim').matchCursors";

        # Jumplist support
        "<C-i>" = mkLuaAction "require('multicursor-nvim').jumpForward";
        "<C-o>" = mkLuaAction "require('multicursor-nvim').jumpBackward";
      };
    in {
      normal =
        normalAndVisual
        // {
          "<Esc>" = mkLuaFunction ''
            local mc = require('multicursor-nvim')
            if not mc.cursorsEnabled() then
                mc.enableCursors()
            elseif mc.hasCursors() then
                mc.clearCursors()
            else
                vim.cmd('nohlsearch')
            end
          '';

          # Add and remove cursors with control + left click.
          "<C-LeftMouse>" = mkLuaAction "require('multicursor-nvim').handleMouse";

          # bring back cursors if you accidentally clear them
          "<leader>gv" = mkLuaAction "require('multicursor-nvim').restoreCursors";
        };

      visual =
        normalAndVisual
        // {
          # Align cursor columns.
          "<leader>a" = mkLuaAction "require('multicursor-nvim').alignCursors";

          # Split visual selections by regex.
          # "S" = mkLuaAction "require('multicursor-nvim').splitCursors";

          # Append/insert for each line of visual selections:
          "I" = mkLuaAction "require('multicursor-nvim').insertVisual";
          "A" = mkLuaAction "require('multicursor-nvim').appendVisual";

          # match new cursors within visual selections by regex.
          "M" = mkLuaAction "require('multicursor-nvim').matchCursors";

          # Rotate visual selection contents.
          # "<leader>t" = mkLuaFunction "require('multicursor-nvim').transposeCursors(1)";
          # "<leader>T" = mkLuaFunction "require('multicursor-nvim').transposeCursors(-1)";
        };
    };
  };
}
