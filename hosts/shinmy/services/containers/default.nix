{
  imports = [
    ./unilife.nix
  ];

  users.users.jdgt.extraGroups = [ "docker" ];

  virtualisation = {
    docker.enable = true;

    containers = {
      enable = true;
      containersConf.settings.compose_providers = [ "podman-compose" ];
    };

    podman = {
      enable = true;
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
