{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.ncmpcpp = {
    enable = true;
    package = pkgs.ncmpcpp.override {visualizerSupport = true;};

    mpdMusicDir = config.xdg.userDirs.music;

    bindings = let
      inherit (lib) replicate;
    in [
      {
        key = "j";
        command = "scroll_down";
      }
      {
        key = "k";
        command = "scroll_up";
      }
      {
        key = "J";
        command = replicate 4 "scroll_down";
      }
      {
        key = "K";
        command = replicate 4 "scroll_up";
      }
      {
        key = "h";
        command = ["previous_column" "jump_to_parent_directory"];
      }
      {
        key = "l";
        command = ["next_column" "enter_directory" "toggle_output" "run_action" "play_item"];
      }
      {
        key = "d";
        command = ["delete_playlist_items" "delete_browser_items" "delete_stored_playlist"];
      }
      {
        key = "right";
        command = "volume_up";
      }
      {
        key = "left";
        command = "volume_down";
      }
    ];

    settings = let
      mopidySettings = config.services.mopidy.settings;
    in {
      mpd_host = mopidySettings.mpd.hostname;
      mpd_port = mopidySettings.mpd.port;
      mpd_music_dir = config.xdg.userDirs.music;

      visualizer_data_source = "localhost:5555";
      visualizer_output_name = "t";
      visualizer_in_stereo = "yes";
      visualizer_type = "spectrum";
      visualizer_look = "●▮";
    };
  };
}
