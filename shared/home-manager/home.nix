{
  config,
  username,
  ...
}: {
  imports = [./modules];

  home = {
    inherit username;
    homeDirectory = "/home/${username}";

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
