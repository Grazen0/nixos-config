{
  imports = [
    ./unilife.nix
  ];

  virtualisation = {
    containers = {
      enable = true;
      containersConf.settings.compose_providers = [ "podman-compose" ];
    };

    podman = {
      enable = true;
      dockerCompat = true;
      autoPrune.enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };
    oci-containers.backend = "podman";
  };

  # Allow podman network hostname aliases
  networking.firewall.interfaces = {
    "podman*".allowedUDPPorts = [ 53 ];
  };
}
