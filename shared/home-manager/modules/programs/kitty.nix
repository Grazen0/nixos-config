{pkgs, ...}: {
  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrainsMonoNL Nerd Font";
      size = 10;
    };
    theme = "Kanagawa";
    shellIntegration.enableZshIntegration = true;
    settings = {
      background_opacity = "0.9";
      enable_audio_bell = "no";
      tab_bar_style = "separator";
      tab_separator = " | ";
    };
  };
}
