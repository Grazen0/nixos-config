{
  programs.eww = {
    enable = true;
    autostart.widgets = ["desktop-time" "desktop-fortune"];
  };

  xdg.nixConfigFile.eww.source = ./config;
}
