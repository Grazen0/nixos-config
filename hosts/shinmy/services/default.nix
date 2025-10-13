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

  services.zerotierone.enable = true;

  services.cloudflared = {
    enable = true;
    tunnels."dd024d94-7349-4dd3-889f-7c22987e8097" = {
      credentialsFile = config.sops.secrets."cloudflared/tunnel_credentials".path;
      default = "http_status:404";
    };
  };

  services.immich = {
    enable = true;
    port = 2283;
    host = "127.0.0.1";
  };

  services.vaultwarden = {
    enable = true;
    config = {
      ROCKET_ADDRESS = "127.0.0.1";
      ROCKET_PORT = 8222;
      DOMAIN = "https://bitwarden.unilife.lat";
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

  services.minecraft-server = {
    package = pkgs.papermcServers.papermc-1_21_5;
    eula = true;
    openFirewall = true;
    declarative = true;

    serverProperties = {
      difficulty = "normal";
      max-players = 5;
      motd = "Eso tilin";
      online-mode = false;

      enable-rcon = true;
      "rcon.password" = "123456";
    };

    jvmOpts = "-Xms4G -Xmx4G";
  };

}
