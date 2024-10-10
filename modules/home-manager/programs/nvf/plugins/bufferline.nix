{
  programs.nvf.settings.vim = {
    tabline.nvimBufferline = {
      enable = true;

      setupOpts.options = {
        numbers = "none";
        separator_style = "thick";
        style_preset = "no_italic";
      };

      mappings = {
        cycleNext = "L";
        cyclePrevious = "H";
        closeCurrent = "<leader>bd";
      };
    };
  };
}
