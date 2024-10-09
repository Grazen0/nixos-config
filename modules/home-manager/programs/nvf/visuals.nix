{
  programs.nvf.settings.vim = {
    visuals = {
      enable = true;
      indentBlankline.enable = true;
      highlight-undo.enable = true;
      nvimWebDevicons.enable = true;

      fidget-nvim.enable = true;
    };

    ui = {
      illuminate.enable = true;
      colorizer = {
        enable = true;
        setupOpts.filetypes."*" = {};
      };

      breadcrumbs = {
        enable = true;
        navbuddy.enable = true;
        lualine.winbar.enable = false;
      };

      borders = {
        enable = false;
        globalStyle = "none";
      };
    };
  };
}
