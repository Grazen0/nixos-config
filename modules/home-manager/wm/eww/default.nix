{pkgs, ...}: {
  programs.eww = {
    enable = false;
    configDir = ./config;
  };

  home.packages = with pkgs; [
    playerctl
  ];
}
