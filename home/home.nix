{config, ...}: {
  home = {
    username = "jdgt";
    homeDirectory = "/home/${config.home.username}";
  };

  nixpkgs.config = import ./nixpkgs-config.nix;

  programs = {
    home-manager.enable = true;
    git.enable = true;
  };

  xdg.configFile."nixpkgs/config.nix".source = ./nixpkgs-config.nix;
}
