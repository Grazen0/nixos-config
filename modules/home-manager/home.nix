{username, ...}: {
  home = {
    inherit username;
    homeDirectory = "/home/${username}";
  };

  programs = {
    home-manager.enable = true;
    git.enable = true;
  };

  # Reload system units on switch
  systemd.user.startServices = "sd-switch";

  home.stateVersion = "24.05";
}
