{
  inputs,
  pkgs,
  ...
}: {
  programs.nvf.settings.vim = {
    extraPlugins.kanagawa = {
      package = pkgs.vimPlugins.kanagawa-nvim;

      setup = ''
        require('kanagawa').setup({
          colors = {
            theme = {
              all = {
                ui = {
                  bg_gutter = "none"
                }
              }
            }
          },
          overrides = function(colors)
            local theme = colors.theme;
            return {
              -- Dark completion background
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

    # No idea why it has to be 2 times, but it doesn't work properly otherwise
    luaConfigRC.kanagawa = ''
      vim.cmd('colorscheme kanagawa-wave')
      vim.cmd('colorscheme kanagawa-wave')
    '';
  };
}
