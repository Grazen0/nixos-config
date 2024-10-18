{
  programs.nvf.settings.vim.
      maps = let
    mkSilent = action: {
      inherit action;
      silent = true;
    };

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
  in {
    normal = {
      # neo-tree
      "<leader>e" = mkSilent "<cmd>Neotree<CR>";

      # nvim-navbuddy
      "<leader>n" = mkSilent "<cmd>Navbuddy<CR>";

      # Better redo
      "<S-u>" = mkSilent "<C-r>";

      # Window navigation
      "<C-h>" = mkSilent "<C-w>h";
      "<C-j>" = mkSilent "<C-w>j";
      "<C-k>" = mkSilent "<C-w>k";
      "<C-l>" = mkSilent "<C-w>l";

      # Window positioning
      "<A-h>" = mkSilent "<C-w>H";
      "<A-j>" = mkSilent "<C-w>J";
      "<A-k>" = mkSilent "<C-w>K";
      "<A-l>" = mkSilent "<C-w>L";

      # Window resizing
      "<lt>" = mkSilent "<C-w><lt>";
      ">" = mkSilent "<C-w>>";
      "-" = mkSilent "<C-w>-";
      "+" = mkSilent "<C-w>+";

      # nvim-spectre
      "<leader>S" = mkLuaAction "require('spectre').toggle";
      "<leader>sw" = mkLuaFunction "require('spectre').open_visual({ select_word = true })";
      "<leader>sp" = mkLuaFunction "require('spectre').open_file_search({ select_word = true })";

      # Soft line wrap movement
      "j" = (mkSilent "v:count == 0 ? 'gj' : 'j'") // {expr = true;};
      "k" = (mkSilent "v:count == 0 ? 'gk' : 'k'") // {expr = true;};

      "<leader>rn" = {
        action = ''
          function()
            return ':IncRename ' .. vim.fn.expand('<cword>');
          end
        '';
        lua = true;
        silent = true;
        expr = true;
      };
    };

    insert = {
      # Spell quick fix
      "<C-l>" = mkSilent "<C-g>u<Esc>[s1z=`]a<C-g>u";
    };

    visual = {
      # Spectre search
      "<leader>sw" = mkSilent "<Esc><cmd>lua require('spectre').open_visual()<CR>";
    };
  };
}
