{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.services.caddy;
in
{
  networking.firewall.allowedTCPPorts = lib.optionals cfg.enable [
    80
    443
    8084
  ];

  sops.templates."Caddyfile" = {
    owner = "caddy";
    content =
      let
        inherit (config.services)
          filebrowser
          glance
          immich
          navidrome
          radicale
          vaultwarden
          ;
      in
      ''
        {
          acme_dns cloudflare ${config.sops.placeholder."caddy/cloudflare_api_token"}
        }

        start.unilife.lat {
          reverse_proxy 127.0.0.1:${toString glance.settings.server.port}
        }

        files.unilife.lat {
          reverse_proxy 127.0.0.1:${toString filebrowser.settings.port}
        }

        photos.unilife.lat {
          reverse_proxy 127.0.0.1:${toString immich.port}
        }

        drive.unilife.lat {
          reverse_proxy 127.0.0.1:8083
        }

        minio.unilife.lat {
          reverse_proxy 127.0.0.1:9001
        }

        jellyfin.unilife.lat {
          reverse_proxy 127.0.0.1:8096
        }

        navidrome.unilife.lat {
          reverse_proxy 127.0.0.1:${toString navidrome.settings.Port}
        }

        bitwarden.unilife.lat {
          reverse_proxy 127.0.0.1:${toString vaultwarden.config.ROCKET_PORT}
        }

        dav.unilife.lat {
          reverse_proxy ${builtins.elemAt radicale.settings.server.hosts 0}
        }

        calendar.unilife.lat {
          reverse_proxy 127.0.0.1:8084
        }
      '';
  };

  services.caddy = {
    enable = true;
    package = pkgs.caddy.withPlugins {
      plugins = [ "github.com/caddy-dns/cloudflare@v0.2.1" ];
      hash = "sha256-j+xUy8OAjEo+bdMOkQ1kVqDnEkzKGTBIbMDVL7YDwDY=";
    };

    configFile = config.sops.templates."Caddyfile".path;
  };

}
