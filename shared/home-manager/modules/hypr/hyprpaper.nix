{
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "~/Pictures/Wallpapers/primary.png"
        "~/Pictures/Wallpapers/secondary.png"
      ];
      wallpaper = [
        "eDP-1,~/Pictures/Wallpapers/primary.png"
        "HDMI-A-1,~/Pictures/Wallpapers/secondary.png"
      ];
    };
  };
}
