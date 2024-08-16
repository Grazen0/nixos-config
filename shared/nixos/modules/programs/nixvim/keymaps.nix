{lib, ...}: {
  programs.nixvim = {
    globals.mapleader = " ";

    keymaps = let
      normal =
        lib.mapAttrsToList
        (key: action: {
          mode = "n";
          inherit action key;
          options.silent = true;
        })
        {
          # Disable any existing <Space> mappings
          "<Space>" = "<Nop>";

          # Clear highlights with escape
          "<Esc>" = "<cmd>noh<CR>";

          # Window navigation
          "<C-h>" = "<C-w>h";
          "<C-j>" = "<C-w>j";
          "<C-k>" = "<C-w>k";
          "<C-l>" = "<C-w>l";

          # Window positioning
          "<A-h>" = "<C-w>H";
          "<A-j>" = "<C-w>J";
          "<A-k>" = "<C-w>K";
          "<A-l>" = "<C-w>L";

          # Window resizing
          "<lt>" = "<C-w><lt>";
          ">" = "<C-w>>";
          "-" = "<C-w>-";
          "+" = "<C-w>+";

          # Tab navigation
          "<C-[>" = "<cmd>tabnext<CR>";
          "<C-]>" = "<cmd>tabprevious<CR>";

          # neo-tree
          "<leader>e" = "<cmd>Neotree<CR>";

          # multicursors.nvim
          "<leader>m" = "<cmd>MCunderCursor<CR>";
        };
      normal-expr =
        lib.mapAttrsToList
        (key: action: {
          mode = "n";
          inherit action key;
          options = {
            silent = true;
            expr = true;
          };
        })
        {
          # Soft line wrap movement
          "j" = "v:count == 0 ? 'gj' : 'j'";
          "k" = "v:count == 0 ? 'gk' : 'k'";

          # inc-rename.nvim
          "<leader>rn".__raw = ''
            function()
              return ":IncRename " .. vim.fn.expand("<cword>")
            end
          '';
        };
      insert =
        lib.mapAttrsToList
        (key: action: {
          mode = "i";
          inherit action key;
          options.silent = true;
        })
        {
          "<C-l>" = "<C-g>u<Esc>[s1z=`]a<C-g>u";
        };
    in (normal ++ normal-expr ++ insert);
  };
}
