{config, ...}: {
  home.file = {
    wallpaper = {
      source = ../files/wallpaper.png;
      target = "${config.xdg.userDirs.pictures}/wallpaper.png";
    };
  };
}
