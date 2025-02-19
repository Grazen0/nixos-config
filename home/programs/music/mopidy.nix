{
  config,
  pkgs,
  ...
}: {
  services.mopidy = {
    enable = true;

    extraConfigFiles = [
      config.sops.templates."mopidy-secrets.conf".path
    ];

    extensionPackages = with pkgs; [
      mopidy-mpd
      mopidy-spotify
      mopidy-mpris
    ];

    settings = {
      audio = {
        output = "tee name=t ! queue ! autoaudiosink t. ! queue ! audio/x-raw,rate=44100,channels=2,format=S16LE ! udpsink host=localhost port=5555";
        buffer_time = 100000;
      };

      file = {
        enabled = true;
        excluded_file_extensions = [
          ".html"
          ".zip"
          ".jpg"
          ".jpeg"
          ".png"
        ];
        follow_symlinks = false;
        media_dirs = "${config.xdg.userDirs.music}|Music";
      };

      mpd = {
        enabled = true;
        hostname = "127.0.0.1";
        port = 6600;
      };

      spotify.enabled = true;
    };
  };

  sops.templates."mopidy-secrets.conf".content = let
    inherit (config.sops) placeholder;
  in
    # toml
    ''
      [spotify]
      client_id = ${placeholder."mopidy_spotify/client_id"}
      client_secret = ${placeholder."mopidy_spotify/client_secret"}
    '';
}
