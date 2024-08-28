{outputs, ...}: {
  imports = [
    outputs.nixosModules
    ./hardware-configuration.nix
  ];

  console.keyMap = "la-latin1";

  programs.steam.enable = false;

  system.stateVersion = "24.05";
}
