{config, ...}: {
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = ["${config.xdg.userDirs.pictures}/wallpaper.png"];
      wallpaper = [",${config.xdg.userDirs.pictures}/wallpaper.png"];
    };
  };
}
