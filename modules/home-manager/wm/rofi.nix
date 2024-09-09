{pkgs, ...}: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;

    font = "JetBrainsMonoNL Nerd Font Propo 12";
    terminal = "${pkgs.kitty}/bin/kitty";
    location = "center";
    theme = "kanagawa";

    plugins = with pkgs; [
      rofi-calc
    ];

    extraConfig = {
      show-icons = true;
      display-drun = "";
      drun-display-format = "{name}";
      hide-scrollbar = true;
      m = -4;
    };
  };
}
