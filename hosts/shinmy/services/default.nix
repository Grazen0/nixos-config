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
    enable = false;
    user = "root";
    settings.root = "/";
  };

  services.zerotierone.enable = false;

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
    enable = true;
    settings.Port = 4533;
  };

  users.groups.music = { };
  users.users.navidrome.extraGroups = [ "music" ];
  users.users.jdgt.extraGroups = [ "music" ];

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

  services.forgejo-runner = {
    package = pkgs.forgejo-runner;
    instances.default = {
      enable = true;

      secrets.server.connections.default.token_url = config.sops.secrets."forgejo/token".path;

      settings = {
        server.connections.default = {
          url = "https://codeberg.org";
          uuid = "80fea40d-1859-49f1-9aa0-b2a316ffffb1";
        };
        runner.labels = [
          "ubuntu-latest:docker://ghcr.io/catthehacker/ubuntu:act-latest"
          "ubuntu-22.04:docker://ghcr.io/catthehacker/ubuntu:act-latest"
          "ubuntu-20.04:docker://ghcr.io/catthehacker/ubuntu:act-latest"
        ];
      };
    };
  };

  services.nginx = {
    enable = true;

    virtualHosts."_" = {
      listen = [
        {
          addr = "127.0.0.1";
          port = 8009;
        }
      ];
      root = "/srv/www/logic-sim";
    };
  };

  services.armagetronad.servers.yoyu = {
    name = "yoyu";
    enable = true;
    openFirewall = true;
    settings = {
      CYCLE_RUBBER = 6;
      CYCLE_DELAY = 0.05;
      SPEED_FACTOR = 1.5;

      TALK_TO_MASTER = 0;

      SAY = [
        "puto el que lo lea"
        "https://grazen.xyz"
      ];
    };
  };

  services.jenkins = {
    enable = false;
    port = 8089;
    listenAddress = "0.0.0.0";
    withCLI = true;
  };
}
