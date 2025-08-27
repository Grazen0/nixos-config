{ config, pkgs, ... }:
{
  networking.firewall.allowedTCPPorts = [
    80
    443
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
          seafile
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
          reverse_proxy ${seafile.seahubAddress}
        }
        drive.unilife.lat/seafhttp* {
          uri strip_prefix seafhttp
          reverse_proxy 127.0.0.1:${toString seafile.seafileSettings.fileserver.port}
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
      '';
  };

  services.caddy = {
    enable = true;
    package = pkgs.caddy.withPlugins {
      plugins = [ "github.com/caddy-dns/cloudflare@v0.2.1" ];
      hash = "sha256-S1JN7brvH2KIu7DaDOH1zij3j8hWLLc0HdnUc+L89uU=";
    };

    configFile = config.sops.templates."Caddyfile".path;
  };

}
