{
  programs.nvf.settings.vim = {
    visuals = {
      enable = true;
      indentBlankline.enable = true;
      highlight-undo.enable = true;
      nvimWebDevicons.enable = true;
    };

    ui = {
      illuminate.enable = true;
      colorizer = {
        enable = true;
        setupOpts.filetypes."*" = {};
      };

      breadcrumbs = {
        enable = true;
        lualine.winbar.enable = false;
        navbuddy.enable = true;
      };

      borders = {
        enable = false;
        globalStyle = "none";
      };
    };
  };
}
