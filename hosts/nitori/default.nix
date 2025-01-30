{
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nixos-hardware.nixosModules.common-gpu-intel
    ./hardware-configuration.nix
  ];

  console.font = lib.mkForce "${pkgs.terminus_font}/share/consolefonts/ter-v20b.psf.gz";

  services.postgresql = {
    enable = true;
    enableTCPIP = true;
    # port = 5432;
    authentication = pkgs.lib.mkOverride 10 ''
      #...
      #type database DBuser origin-address auth-method
      local all       all     trust
      # ipv4
      host  all      all     127.0.0.1/32   trust
      # ipv6
      host all       all     ::1/128        trust
    '';
  };

  home-manager.users.jdgt.imports = [./home.nix];

  system.stateVersion = "24.05";
}
