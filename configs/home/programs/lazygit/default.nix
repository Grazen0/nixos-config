{
  programs.lazygit = {
    settings = {
      os.editPreset = "nvim-remote";
      gui = {
        border = "single";
        nerdFontsVersion = "3";
      };
      git = {
        overrideGpg = true;
      };
    };
  };
}
