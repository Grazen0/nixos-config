{
  config,
  lib,
  pkgs,
  ...
}: {
  programs.ncmpcpp = rec {
    enable = true;
    package = pkgs.ncmpcpp.override {visualizerSupport = true;};

    mpdMusicDir = config.xdg.userDirs.music;

    bindings = let
      inherit (lib) replicate;
    in [
      {
        key = "q";
        command = "dummy";
      }
      {
        key = "ctrl-q";
        command = "quit";
      }
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

    settings = {
      mpd_host = "localhost";
      mpd_port = 6600;

      visualizer_data_source = "localhost:5555";
      visualizer_in_stereo = true;
      visualizer_type = "spectrum";
      visualizer_look = "●▮";
      progressbar_look = "▃▃▃";
      volume_change_step = 5;

      data_fetching_delay = false;
      connected_message_on_startup = false;
    };

    extraSettings = {
      minimal =
        settings
        // {
          progressbar_look = "\"   \"";
          statusbar_visibility = false;
          display_volume_level = false;
        };

      visualizer =
        settings
        // {
          user_interface = "alternative";
        };
    };
  };
}
