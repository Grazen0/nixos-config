{username, ...}: {
  home = {
    inherit username;
    homeDirectory = "/home/${username}";
  };

  # Reload system units on switch
  systemd.user.startServices = "sd-switch";

  home.stateVersion = "24.05";
}
