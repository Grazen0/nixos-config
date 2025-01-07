{config, ...}: {
  programs.kitty = {
    enable = true;

    themeFile = "kanagawa";

    font = {
      name = config.theme.font.regular;
      size = 9.5;
    };

    settings = {
      enable_audio_bell = "no";
      tab_bar_style = "separator";
      tab_separator = " | ";
    };
  };
}
