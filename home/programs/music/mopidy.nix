{
  config,
  pkgs,
  ...
}: {
  services.mopidy = {
    enable = true;

    extensionPackages = let
      mopidyPackagesOverride = pkgs.mopidyPackages.overrideScope (prev: final: {
        extraPkgs = ps:
          with ps; [
            yt-dlp
          ];
      });
    in
      with mopidyPackagesOverride; [
        mopidy-mpd
        mopidy-spotify
        mopidy-mpris
        mopidy-youtube
      ];

    settings = {
      file = {
        enabled = true;
        media_dirs = [
          "${config.xdg.userDirs.music}|Music"
        ];
        follow_symlinks = true;
        excluded_file_extensions = [
          ".html"
          ".zip"
          ".jpg"
          ".jpeg"
          ".png"
        ];
      };

      mpd = {
        enabled = true;
        hostname = "127.0.0.1";
        port = 6600;
      };

      audio = {
        output = "tee name=t ! queue ! autoaudiosink t. ! queue ! audio/x-raw,rate=44100,channels=2,format=S16LE ! udpsink host=localhost port=5555";
      };

      spotify = {
        client_id = "9980691d-3a5d-4ead-80c5-42496642b043";
        client_secret = "mdHRi5EHgmIQ3qZsGOHNlzldnYmDsJVkYwfYAPV_iZw=";
      };

      youtube = {
        youtube_dl_package = "yt_dlp";
        allow_cache = true;
        autoplay_enabled = true;
      };
    };
  };
}
