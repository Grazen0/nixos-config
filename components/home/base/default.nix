{ config, ... }:
{
  home = {
    username = config.meta.mainUser;
    homeDirectory = "/home/${config.home.username}";
  };

  programs.git.enable = true;
}
