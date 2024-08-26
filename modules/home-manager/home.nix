{username, ...}: {
  home = {
    inherit username;
    homeDirectory = "/home/${username}";

    stateVersion = "24.05";
  };

  nixpkgs.config.allowUnfree = true;

  # Reload system units on switch
  systemd.user.startServices = "sd-switch";
}
