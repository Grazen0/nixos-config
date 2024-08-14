{config, ...}: {
  home.file = {
    wallpapers = {
      enable = true;
      source = ../files/wallpapers;
      recursive = true;
      target = "${config.xdg.userDirs.pictures}/Wallpapers";
    };

    vesktop = {
      enable = true;
      source = ../files/vesktop;
      recursive = true;
      target = "${config.xdg.configHome}/vesktop";
    };
  };
}
