{pkgs, ...}: {
  programs.eww = {
    enable = true;
    autostart.widgets = ["desktop-time" "desktop-fortune"];
  };

  home.packages = with pkgs; [
    fortune
  ];

  xdg.nixConfigFile.eww = {
    source = ./config;
  };
}
