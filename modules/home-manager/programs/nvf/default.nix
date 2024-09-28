{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nvf.homeManagerModules.default
  ];

  programs.nvf = {
    enable = true;

    defaultEditor = true;
    enableManpages = true;

    settings.vim = {
      extraPackages = with pkgs; [ripgrep fd];

      extraLuaFiles = [
        ./lua/autocmds.lua
      ];

      viAlias = true;
      vimAlias = true;

      withPython3 = true;
      withNodeJs = true;

      leaderKey = " ";

      options = {
        cursorline = true;
        spelllang = "en_us,es_es";
      };

      cursorlineOpt = "both";
      syntaxHighlighting = true;
      updateTime = 200;
      tabWidth = 4;
      mouseSupport = "a";
      undoFile.enable = true;
      autoIndent = true;
      searchCase = "smart";
      showSignColumn = true;
      lineNumberMode = "number";
      useSystemClipboard = true;
      colourTerm = true;
      splitRight = true;

      maps = let
        mkSilent = action: {
          inherit action;
          silent = true;
        };
      in {
        normal = {
          # neo-tree
          "<leader>e" = mkSilent "<cmd>Neotree<CR>";

          # Clear highlights with escape
          "<Esc>" = mkSilent "<cmd>noh<CR>";

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

      treesitter = {
        enable = true;
        fold = true;
      };

      lsp = {
        enable = true;
        lspkind.enable = true;
        formatOnSave = true;
      };

      statusline.lualine.enable = true;

      autopairs.enable = true;

      notes.todo-comments.enable = true;

      filetree.neo-tree = {
        enable = true;
        setupOpts = {
          enable_cursor_hijack = true;
          auto_clean_after_session_restore = true;
          window.width = 30;
        };
      };

      languages = {
        enableLSP = true;
        enableFormat = true;
        enableTreesitter = true;

        bash.enable = true;

        nix.enable = true;
        lua.enable = true;
        markdown.enable = true;

        rust.enable = true;
        clang.enable = true;

        python.enable = true;

        ts.enable = true;
        html.enable = true;
        css.enable = true;
        svelte.enable = true;
        tailwind.enable = true;
      };

      visuals = {
        enable = true;
        nvimWebDevicons.enable = true;
        indentBlankline.enable = true;
      };

      autocomplete = {
        enable = true;
        type = "nvim-cmp";
      };

      git = {
        enable = true;
        gitsigns.enable = true;
        gitsigns.codeActions.enable = false;
      };

      telescope.enable = true;

      utility = {
        surround.enable = true;
      };

      comments.comment-nvim.enable = true;

      presence.neocord.enable = true;

      extraPlugins = with pkgs.vimPlugins; {
        kanagawa = {
          package = kanagawa-nvim;
          setup = ''
            require('kanagawa').setup({
              overrides = function(colors)
                local theme = colors.theme;
                return {
                  -- Completion window background
                  Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 },  -- add `blend = vim.o.pumblend` to enable transparency
                  PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
                  PmenuSbar = { bg = theme.ui.bg_m1 },
                  PmenuThumb = { bg = theme.ui.bg_p2 },

                  -- Solid telescope style
                  TelescopeTitle = { fg = theme.ui.special, bold = true },
                  TelescopePromptNormal = { bg = theme.ui.bg_p1 },
                  TelescopePromptBorder = { fg = theme.ui.bg_p1, bg = theme.ui.bg_p1 },
                  TelescopeResultsNormal = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m1 },
                  TelescopeResultsBorder = { fg = theme.ui.bg_m1, bg = theme.ui.bg_m1 },
                  TelescopePreviewNormal = { bg = theme.ui.bg_dim },
                  TelescopePreviewBorder = { bg = theme.ui.bg_dim, fg = theme.ui.bg_dim },
                };
              end
            });
          '';
        };

        vimtex = {
          package = vimtex;
        };

        ultisnips = {
          package = ultisnips;
        };

        inc-rename = {
          package = inc-rename-nvim;
          setup = "require('inc_rename').setup()";
        };
      };

      luaConfigRC = {
        kanagawa = "vim.cmd('colorscheme kanagawa-wave')";
      };
    };
  };
}
