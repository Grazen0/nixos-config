{pkgs, ...}: {
  programs.eww = {
    enable = true;
    configDir = ./config;
  };

  home.packages = with pkgs; [
    playerctl
  ];
}
