{
  programs.kitty = {
    enable = true;

    shellIntegration.enableZshIntegration = true;
    themeFile = "kanagawa";

    font = {
      name = "JetBrainsMonoNL Nerd Font";
      size = 10;
    };

    keybindings = {
      "ctrl+tab" = "";
      "ctrl+shift+tab" = "";
    };

    settings = {
      enable_audio_bell = "no";
      tab_bar_style = "separator";
      tab_separator = " | ";
    };
  };
}
