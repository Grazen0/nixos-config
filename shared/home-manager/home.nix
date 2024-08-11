{config, ...}: {
  imports = [./modules];

  home = {
    username = "jdgt";
    homeDirectory = "/home/jdgt";

    file.wallpapers = {
      enable = true;
      source = ./wallpapers;
      recursive = true;
      target = "${config.xdg.userDirs.pictures}/Wallpapers";
    };

    stateVersion = "24.05";
  };

  nixpkgs.config.allowUnfree = true;

  # Reload system units on switch
  systemd.user.startServices = "sd-switch";
}
