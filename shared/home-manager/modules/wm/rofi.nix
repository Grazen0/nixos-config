{
  config,
  pkgs,
  ...
}: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;

    font = "JetBrainsMonoNL Nerd Font Propo 10";
    terminal = "${pkgs.kitty}/bin/kitty";
    location = "center";
    theme = "kanagawa";

    extraConfig = {
      show-icons = true;
      display-drun = "";
      display-dmenu = "";
      drun-display-format = "{name}";
      hide-scrollbar = true;
      m = -4;
    };
  };
}
