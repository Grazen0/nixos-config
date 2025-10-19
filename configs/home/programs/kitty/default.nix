{ config, ... }:
{
  programs.kitty = {
    enable = true;
    themeFile = "kanagawa";

    font = {
      name = config.theme.font.regular;
      size = 12;
    };

    settings = {
      enable_audio_bell = "no";
      tab_bar_style = "separator";
      tab_separator = " | ";
    };

    keybindings = {
      "ctrl+shift+enter" = "";
      "ctrl+shift+n" = "";
      "ctrl+shift+w" = "";
      "ctrl+shift+]" = "";
      "ctrl+shift+[" = "";
      "ctrl+shift+f" = "";
      "ctrl+shift+b" = "";
      "ctrl+shift+`" = "";
      "ctrl+shift+r" = "";
      "ctrl+shift+1" = "";
      "ctrl+shift+2" = "";
      "ctrl+shift+3" = "";
      "ctrl+shift+4" = "";
      "ctrl+shift+5" = "";
      "ctrl+shift+7" = "";
      "ctrl+shift+8" = "";
      "ctrl+shift+9" = "";
      "ctrl+shift+0" = "";

      "ctrl+shift+right" = "";
      "ctrl+tab" = "";
      "ctrl+shift+left" = "";
      "ctrl+shift+tab" = "";
      "ctrl+shift+t" = "";
      "ctrl+shift+q" = "";
      "ctrl+shift+." = "";
      "ctrl+shift+," = "";
    };
  };
}
