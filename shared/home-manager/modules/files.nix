{config, ...}: {
  home.file = {
    wallpapers = {
      source = ../files/wallpapers;
      recursive = true;
      target = "${config.xdg.userDirs.pictures}/Wallpapers";
    };

    vesktop = {
      source = ../files/config/vesktop;
      recursive = true;
      target = "${config.xdg.configHome}/vesktop";
    };

    whatsapp-for-linux = {
      source = ../files/config/whatsapp-for-linux;
      recursive = true;
      target = "${config.xdg.configHome}/whatsapp-for-linux";
    };
  };
}
