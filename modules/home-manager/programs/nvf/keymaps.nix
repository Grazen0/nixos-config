{
  programs.nvf.settings.vim.
      maps = let
    mkSilent = action: {
      inherit action;
      silent = true;
    };
  in {
    normal = {
      # neo-tree
      "<leader>e" = mkSilent "<cmd>Neotree<CR>";

      # nvim-navbuddy
      "<leader>n" = mkSilent "<cmd>Navbuddy<CR>";

      # Clear highlights with escape
      "<Esc>" = mkSilent "<cmd>noh<CR>";

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

      # multicursors.nvim
      "<leader>m" = mkSilent "<cmd>MCunderCursor<CR>";

      # nvim-spectre
      "<leader>S" = mkSilent "<cmd>lua require('spectre').toggle()<CR>";
      "<leader>sw" = mkSilent "<cmd>lua require('spectre').open_visual({select_word=true})<CR>";
      "<leader>sp" = mkSilent "<cmd>lua require('spectre').open_file_search({select_word=true})<CR>";

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
      "<leader>sw" = mkSilent "<esc><cmd>lua require('spectre').open_visual()<CR>";
    };
  };
}
