{pkgs, ...}: {
  programs.eww = {
    enable = true;
    configDir = ./config;
    autostart.widgets = ["desktop-time" "desktop-fortune"];
  };

  home.packages = with pkgs; [
    fortune
  ];
}
