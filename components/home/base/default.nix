{ config, ... }:
{
  home.homeDirectory = "/home/${config.home.username}";

  xdg.configFile."nixpkgs/config.nix".source = ./nixpkgs-config.nix;

  programs.git.enable = true;
}
