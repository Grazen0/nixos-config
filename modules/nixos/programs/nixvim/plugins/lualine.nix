{
  programs.nixvim.plugins.lualine = {
    enable = true;

    settings.options = {
      componentSeparators = {
        left = "";
        right = "";
      };

      sectionSeparators = {
        left = "";
        right = "";
      };
    };
  };
}
