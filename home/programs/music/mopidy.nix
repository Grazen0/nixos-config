{
  config,
  lib,
  pkgs,
  ...
}: {
  services.mopidy = {
    enable = true;

    extensionPackages = with pkgs; [
      mopidy-mpd
      mopidy-spotify
      mopidy-mpris
    ];
  };

  xdg.configFile."mopidy/mopidy.conf".enable = lib.mkForce false;

  systemd.user.services = {
    mopidy.Unit.After = ["mopidy-config.service"];

    mopidy-config = {
      Unit = {
        Description = "Mopidy config setup";
        After = ["sops-nix.service"];
      };

      Install.WantedBy = ["default.target"];

      Service.ExecStart = let
        configFile = let
          inherit (config.sops) secrets;
        in
          # toml
          ''
            [audio]
            output = tee name=my_fifo ! queue ! autoaudiosink t. ! queue ! audio/x-raw,rate=44100,channels=2,format=S16LE ! udpsink host=localhost port=5555

            [file]
            enabled = true
            excluded_file_extensions =
              .html
              .zip
              .jpg
              .jpeg
              .png
            follow_symlinks = false
            media_dirs =
              ${config.xdg.userDirs.music}|Music

            [mpd]
            enabled = true
            hostname = 127.0.0.1
            port = 6600

            [spotify]
            enabled = true
            client_id = $(cat '${secrets."mopidy_spotify/client_id".path}')
            client_secret = $(cat '${secrets."mopidy_spotify/client_secret".path}')
          '';

        pkg = pkgs.writeShellApplication {
          name = "mopidy-config";
          text = ''
            mkdir -p '${config.xdg.configHome}/mopidy'
            cat <<EOF > '${config.xdg.configHome}/mopidy/mopidy.conf'
            ${configFile}
            EOF
          '';
        };
      in
        lib.getExe pkg;
    };
  };
}
