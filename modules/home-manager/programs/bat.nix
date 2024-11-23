{pkgs, ...}: {
  programs.bat = {
    enable = true;
    config = {
      theme = "kanagawa";
    };
    themes = {
      kanagawa = {
        src = pkgs.vimPlugins.kanagawa-nvim;
        file = "extras/kanagawa.tmTheme";
      };
    };
  };
}
