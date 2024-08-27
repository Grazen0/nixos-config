{username, ...}: {
  home = {
    inherit username;
    homeDirectory = "/home/${username}";
  };

  nixpkg.config.allowUnfree = true;

  # Reload system units on switch
  systemd.user.startServices = "sd-switch";

  home.stateVersion = "24.05";
}
