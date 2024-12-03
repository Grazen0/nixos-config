{config, ...}: {
  home = {
    username = "jdgt";
    homeDirectory = "/home/${config.home.username}";

    file.wallpaper = {
      source = config.theme.wallpaper;
      target = "${config.xdg.userDirs.pictures}/wallpaper.png";
    };
  };

  nixpkgs.config = import ./nixpkgs-config.nix;

  programs = {
    home-manager.enable = true;
    git.enable = true;
  };

  xdg.configFile."nixpkgs/config.nix".source = ./nixpkgs-config.nix;
}
