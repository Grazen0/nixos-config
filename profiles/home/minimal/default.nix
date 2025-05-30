{ config, ... }:
{
  imports = [ ./git.nix ];

  home = {
    username = config.meta.mainUser;
    homeDirectory = "/home/${config.home.username}";
  };

  meta.mainPrograms = {
    editor = "nvim";
    fileManagerCli = "yazi";
  };

  programs = {
    fd.enable = true;
    ripgrep.enable = true;
  };

  xdg.configFile."nixpkgs/config.nix".source = ./nixpkgs-config.nix;
}
