{ pkgs, ... }:
{
  programs.bat = {
    config.theme = "kanagawa";

    themes = {
      kanagawa = {
        src = pkgs.vimPlugins.kanagawa-nvim;
        file = "extras/tmTheme/kanagawa.tmTheme";
      };
    };
  };
}
