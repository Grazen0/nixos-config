{config, ...}: {
  imports = [./modules];

  programs.home-manager.enable = true;

  home = {
    username = "jdgt";
    homeDirectory = "/home/jdgt";

    sessionPath = [
      "$HOME/.local/bin"
    ];

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
