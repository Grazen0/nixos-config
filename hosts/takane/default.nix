{lib, ...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  console.keyMap = lib.mkForce "la-latin1";

  home-manager.users.jdgt.imports = [./home.nix];

  system.stateVersion = "24.05";
}
