{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ./containers
    ./caddy.nix
    ./glance.nix
  ];

  services.tailscale = {
    enable = true;
    useRoutingFeatures = "server";
    extraSetFlags = [ "--advertise-exit-node" ];
  };

  services.filebrowser = {
    enable = true;
    user = "root";
    settings.root = "/";
  };

  # services.zerotierone.enable = true;

  services.cloudflared = {
    enable = true;
    tunnels."bed6cacf-c810-4b71-9a62-d6346bd71344" = {
      credentialsFile = config.sops.secrets."cloudflared/tunnel_credentials".path;
      default = "http_status:404";
    };
  };

  services.immich = {
    enable = true;
    port = 2283;
    host = "127.0.0.1";
    machine-learning.enable = false;
  };

  services.vaultwarden = {
    enable = true;
    config = {
      ROCKET_ADDRESS = "127.0.0.1";
      ROCKET_PORT = 8222;
      DOMAIN = "https://bitwarden.grazen.xyz";
      ADMIN_TOKEN = "1234567890";
    };
  };

  services.navidrome = {
    settings.Port = 4533;
    # settings.MusicFolder = "/var/lib/navidrome/music";
  };

  services.jellyfin = {
    user = "jdgt";
  };

  services.radicale = {
    enable = true;
    settings = {
      server.hosts = [ "0.0.0.0:5232" ];
      auth = {
        type = "htpasswd";
        htpasswd_filename = config.sops.secrets."radicale/htpasswd".path;
        htpasswd_encryption = "autodetect";
      };
    };
  };
  networking.firewall.allowedTCPPorts = lib.optionals config.services.radicale.enable [
    5232 # Recommended by the NixOS wiki
  ];

  services.gitea-actions-runner = {
    package = pkgs.forgejo-runner;
    instances.default = {
      enable = true;

      name = "eirin";
      tokenFile = config.sops.secrets."forgejo/token".path;
      url = "https://codeberg.org";

      labels = [
        "ubuntu-latest:docker://ghcr.io/catthehacker/ubuntu:act-latest"
        "ubuntu-22.04:docker://ghcr.io/catthehacker/ubuntu:act-latest"
        "ubuntu-20.04:docker://ghcr.io/catthehacker/ubuntu:act-latest"
      ];
    };
  };
}
