{ config, pkgs, ... }:
{
  imports = [
    ./caddy.nix
    ./glance.nix
  ];

  services.tailscale = {
    enable = true;
    useRoutingFeatures = "server";
    extraSetFlags = [ "--advertise-exit-node" ];
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

  services.seafile = {
    enable = true;

    seafileSettings.fileserver.host = "127.0.0.1";
    seafileSettings.fileserver.port = 8082;
    ccnetSettings.General.SERVICE_URL = "https://drive.unilife.lat";
    seahubAddress = "127.0.0.1:8083";

    adminEmail = "josedanielgrayson@proton.me";
    initialAdminPassword = "123456";
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
    enable = true;
    settings.Port = 4533;
    # settings.MusicFolder = "/var/lib/navidrome/music";
  };

  services.jellyfin = {
    user = "jdgt";
  };

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
