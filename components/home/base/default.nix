{ config, ... }:
{
  home.homeDirectory = "/home/${config.home.username}";

  programs.git.enable = true;
}
