{
  lib,
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

    settings.vim = let
      inherit (lib.generators) mkLuaInline;
    in {
      extraPackages = with pkgs; [
        # Telescope
        ripgrep
        fd

        # Vimtex
        texlive.combined.scheme-full

        # Conform
        alejandra
        beautysh
        bibtex-tidy
        black
        isort
        prettierd
        rustfmt
        stylua
      ];

      extraLuaFiles = [
        ./lua/autocmds.lua
        ./lua/user-commands.lua
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
      undoFile.enable = true;
      searchCase = "smart";
      lineNumberMode = "number";
      useSystemClipboard = true;

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

      notes.todo-comments = {
        enable = true;
        mappings.telescope = "<leader>ft";
      };

      filetree.neo-tree = {
        enable = true;

        setupOpts = {
          auto_clean_after_session_restore = true;
          popup_border_style = "solid";
          close_if_last_window = true;
          hijack_netrw_behavior = "open_current";

          window = {
            width = 30;

            mappings = {
              # Telescope-like split aliases
              "<C-v>" = "open_vsplit";
              "<C-x>" = "open_split";

              # Navigation with HJKL
              h = mkLuaInline ''
                function(state)
                  local node = state.tree:get_node();
                  if node.type == "directory" and node:is_expanded() then
                    require("neo-tree.sources.filesystem").toggle_directory(state, node);
                  else
                    require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id());
                  end
                end
              '';
              l = mkLuaInline ''
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
              d = mkLuaInline ''
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
              o = mkLuaInline ''
                function(state)
                  local node = state.tree:get_node();
                  local path = node:get_id();
                  vim.fn.jobstart({ "xdg-open", path }, { detach = true });
                end
              '';
            };
          };

          filesystem = {
            follow_current_file.enabled = true;
            use_libuv_file_watcher = true;

            filtered_items = {
              show_hidden_count = false;
              hide_dotfiles = false;
              hide_gitignored = false;
              hide_by_name = [
                ".git"
                "__pycache__"
                ".DS_Store"
                "thumbs.db"
              ];
            };
          };

          event_handlers = [
            {
              event = "file_opened";
              handler = mkLuaInline "function() vim.cmd('Neotree close') end";
            }
          ];
        };
      };

      languages = {
        enableLSP = true;
        # enableFormat = true;
        enableTreesitter = true;

        bash.enable = true;

        nix.enable = true;
        lua = {
          enable = true;
          lsp.neodev.enable = true;
        };
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

      telescope = {
        enable = true;

        mappings = {
          open = null;
          resume = null;
          lspDefinitions = "<leader>fd";
          lspImplementations = "<leader>fi";
          lspReferences = "<leader>fr";
        };

        setupOpts = {
          defaults = {
            layout_config.horizontal.prompt_position = "bottom";
            sorting_strategy = "descending";

            file_ignore_patterns = [
              "^.git/"
              "^.mypy_cache/"
              "^__pycache__/"
              "^output/"
              "^data/"
              "dist/"
              "build/"
              "target/"
              "result/"

              "%.o"
              "%.a"
              "%.out"
              "%.ipynb"
              "%.class"
              "%.pdf"
              "%.mkv"
              "%.mp4"
              "%.png"
              "%.jpg"
              "%.jpeg"
              "%.webp"
              "%.gif"
            ];

            mappings.n."<S-d>" = mkLuaInline "require('telescope.actions').delete_buffer";
          };
        };
      };

      utility = {
        surround.enable = true;
      };

      comments.comment-nvim.enable = true;

      presence.neocord.enable = true;

      extraPlugins = with pkgs; {
        kanagawa = {
          package = vimPlugins.kanagawa-nvim;
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

        conform = {
          package = vimPlugins.conform-nvim;
          setup = ''
            require('conform').setup({
              formatters_by_ft = {
                html = { "prettierd" };
                javascriptreact = { "prettierd" };
                typescriptreact = { "prettierd" };
                javascript = { "prettierd" };
                typescript = { "prettierd" };
                graphql = { "prettierd" };
                json = { "prettierd" };
                css = { "prettierd" };
                python = { "isort", "black" };
                lua = { "stylua" };
                rust = { "rustfmt" };
                tex = { "bibtex-tidy" };
                plaintex = { "bibtex-tidy" };
                c = { "clang-format" };
                cpp = { "clang-format" };
                yaml = { "prettierd" };
                sh = { "beautysh" };
                bash = { "beautysh" };
                zsh = { "beautysh" };
                nix = { "alejandra" };
              },

              format_on_save = function(bufnr)
                -- Disable with a global or buffer-local variable
                if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                  return;
                end
                return { timeout_ms = 1000, lsp_format = "fallback" };
              end,
            })
          '';
        };

        vimtex = {
          package = vimPlugins.vimtex;
        };

        ultisnips = {
          package = vimPlugins.ultisnips;
        };

        inc-rename = {
          package = vimPlugins.inc-rename-nvim;
          setup = "require('inc_rename').setup()";
        };

        nvim-window-picker = {
          package = vimPlugins.nvim-window-picker;
          setup = "require('window-picker').setup()";
        };

        multicursors = {
          package = vimPlugins.multicursors-nvim;
        };

        mini-starter = {
          package = vimPlugins.mini-starter;
          setup = ''
            require('mini.starter').setup({
              header = [[
                                        Welcome back to

                 ██████   █████                                ███
                ░░██████ ░░███                                ░░░
                 ░███░███ ░███   ██████   ██████  █████ █████ ████  █████████████
                 ░███░░███░███  ███░░███ ███░░███░░███ ░░███ ░░███ ░░███░░███░░███
                 ░███ ░░██████ ░███████ ░███ ░███ ░███  ░███  ░███  ░███ ░███ ░███
                 ░███  ░░█████ ░███░░░  ░███ ░███ ░░███ ███   ░███  ░███ ░███ ░███
                 █████  ░░█████░░██████ ░░██████   ░░█████    █████ █████░███ █████
                ░░░░░    ░░░░░  ░░░░░░   ░░░░░░     ░░░░░    ░░░░░ ░░░░░ ░░░ ░░░░░
              ]],

              footer = ''',

              content_hooks = {
                require('mini.starter').gen_hook.adding_bullet('» '),
                require('mini.starter').gen_hook.aligning('center', 'center'),
              },
            })
          '';
        };

        mini-sessions = {
          package = vimPlugins.mini-sessions;
          setup = ''
            require('mini.sessions').setup({
              hooks = {
                pre = {
                  write = function() vim.cmd('Neotree close'); end
                },
              },
            })
          '';
        };
      };

      luaConfigRC = {
        kanagawa = "vim.cmd('colorscheme kanagawa-wave')";
      };
    };
  };
}
