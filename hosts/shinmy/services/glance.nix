{ config, lib, ... }:
let
  cfg = config.services.glance;
in
{
  systemd.services = lib.mkIf cfg.enable {
    glance.serviceConfig.SupplementaryGroups = [ "podman" ];
  };

  sops.templates."glance_env".content = ''
    IMMICH_API_KEY=${config.sops.placeholder."glance/immich_api_key"}
  '';

  services.glance = {
    enable = true;

    environmentFile = config.sops.templates."glance_env".path;

    settings = {
      server = {
        port = 5678;
        host = "127.0.0.1";
        proxied = true;
      };

      # Kanagawa
      theme = {
        background-color = "240 13 14";
        primary-color = "51 33 68";
        negative-color = "358 100 68";
        contrast-multiplier = 1.2;
      };

      branding.hide-footer = true;

      pages = [
        {
          name = "Home";
          center-vertically = true;

          columns = [
            {
              size = "small";
              widgets = [
                { type = "calendar"; }
                {
                  type = "rss";
                  title = "RSS";
                  feeds = [
                    {
                      url = "https://grazen0.github.io/blog/feed.xml";
                      title = "Grazen's Blog";
                    }
                    {
                      url = "https://isaacfreund.com/blog/feed.xml";
                      title = "Isaac Freund's Blog";
                    }
                    {
                      url = "https://notashelf.dev/rss.xml";
                      title = "NotAShelf's Blog";
                    }
                    {
                      url = "https://mccue.dev/feed.xml";
                      title = "mccue.dev";
                    }
                    {
                      url = "https://www.worthe-it.co.za/rss.xml";
                      title = "Justin Wernick's Blog";
                    }
                    {
                      url = "https://danielchasehooper.com/feed.xml";
                      title = "Daniel Hooper";
                    }
                  ];
                }
              ];
            }
            {
              size = "full";
              widgets = [
                {
                  type = "search";
                  search-engine = "duckduckgo";
                }
                {
                  type = "group";
                  widgets = [
                    {
                      type = "reddit";
                      subreddit = "NixOS";
                      show-thumbnails = true;
                    }
                    {
                      type = "reddit";
                      subreddit = "neovim";
                      show-thumbnails = true;
                    }
                    {
                      type = "reddit";
                      subreddit = "unixporn";
                      show-thumbnails = true;
                    }
                    {
                      type = "reddit";
                      subreddit = "undertale";
                      show-thumbnails = true;
                    }
                  ];
                }
                {
                  type = "hacker-news";
                  limit = 15;
                  collapse-after = 5;
                }
              ];
            }
            {
              size = "small";
              widgets = [
                {
                  type = "clock";
                  hour-format = "12h";
                }
                {
                  type = "videos";
                  style = "vertical-list";
                  channels = [
                    "UCYO_jab_esuFRV4b17AJtAw" # 3Blue1Brown
                    "UCm8EsftbfNzSiRHzc7I59KQ" # Kevin Fang
                    "UCsBjURrPoezykLs9EqgamOA" # Fireship
                    "UCFVteOob_YXJHPaGTqlDV2Q" # CodeHead
                    "UCGKEMK3s-ZPbjVOIuAV8clQ" # Core Dumped
                    "UCZaFfDBBCqmYdfp6DJl0cRw" # Akatsuki Records
                    "UC04nROIJrY22Gl2aFqKcdqQ" # Sylvan Franklin
                  ];
                }
              ];
            }
          ];
        }
        {
          name = "Homelab";
          columns = [
            {
              size = "small";
              widgets = [
                {
                  type = "server-stats";
                  servers = [ { type = "local"; } ];
                }
                {
                  type = "custom-api";
                  title = "Immich stats";
                  cache = "15m";
                  url = "https://photos.grazen.xyz/api/server/statistics";
                  headers = {
                    x-api-key = "\${IMMICH_API_KEY}";
                    Accept = "application/json";
                  };
                  template =
                    # html
                    ''
                      <div class="flex justify-between text-center">
                        <div style="display: flex; flex-direction: column; justify-items: center;">
                            <img
                              class="flat-icon cached finished-transition"
                              style="opacity: 0.6;"
                              src="https://cdn.jsdelivr.net/npm/@mdi/svg@latest/svg/image.svg"
                              alt=""
                              loading="lazy"
                            />
                          <div class="color-highlight size-h3">{{ .JSON.Int "photos" | formatNumber }}</div>
                          <div class="size-h6">PHOTOS</div>
                        </div>
                        <div style="display: flex; flex-direction: column; justify-items: center;">
                          <img
                            class="flat-icon cached finished-transition"
                            style="opacity: 0.6;"
                            src="https://cdn.jsdelivr.net/npm/@mdi/svg@latest/svg/video.svg"
                            alt=""
                            loading="lazy"
                          />
                          <div class="color-highlight size-h3">{{ .JSON.Int "videos" | formatNumber }}</div>
                          <div class="size-h6">VIDEOS</div>
                        </div>
                        <div style="display: flex; flex-direction: column; justify-items: center;">
                          <img
                            class="flat-icon cached finished-transition"
                            style="opacity: 0.6;"
                            src="https://cdn.jsdelivr.net/npm/@mdi/svg@latest/svg/floppy.svg"
                            alt=""
                            loading="lazy"
                          />
                          <div class="color-highlight size-h3">{{ div (.JSON.Int "usage" | toFloat) 1073741824 | toInt | formatNumber }}GB</div>
                          <div class="size-h6">USAGE</div>
                        </div>
                      </div>
                    '';
                }
              ];
            }
            {
              size = "full";
              widgets = [
                {
                  type = "monitor";
                  cache = "1m";
                  title = "Services";
                  sites = [
                    {
                      title = "Vaultwarden";
                      url = "https://bitwarden.grazen.xyz";
                      icon = "di:vaultwarden";
                    }
                    {
                      title = "Immich";
                      url = "https://photos.grazen.xyz";
                      icon = "di:immich";
                    }
                    {
                      title = "Seafile";
                      url = "https://drive.grazen.xyz";
                      icon = "di:seafile";
                    }
                    {
                      title = "Filebrowser";
                      url = "https://files.grazen.xyz";
                      icon = "di:filebrowser";
                    }
                    {
                      title = "Radicale";
                      url = "https://dav.unilife.lat";
                      icon = "di:radicale";
                    }
                  ];
                }
                {
                  type = "docker-containers";
                  sock-path = "/var/run/podman/podman.sock";
                }
              ];
            }
          ];
        }
      ];
    };
  };
}
