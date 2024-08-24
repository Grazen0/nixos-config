{pkgs, ...}: {
  programs.kitty = {
    enable = true;

    shellIntegration.enableZshIntegration = true;
    theme = "Kanagawa";

    font = {
      name = "JetBrainsMonoNL Nerd Font";
      size = 10;
    };

    keybindings = {
      "ctrl+tab" = "";
      "ctrl+shift+tab" = "";
    };

    settings = {
      background_opacity = "0.9";
      enable_audio_bell = "no";
      tab_bar_style = "separator";
      tab_separator = " | ";
    };
  };
}
