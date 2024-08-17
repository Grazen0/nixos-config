{pkgs, ...}: {
  home.packages = let
    media-query = pkgs.writeShellScriptBin "media-query" ''
      #!/usr/bin/env bash

      class=""
      text=""

      if playerctl status &> /dev/null; then
        text=" $(playerctl metadata title)"
        tooltip=$(playerctl status)

        if [ "$tooltip" != "Playing" ]; then
          class="inactive"
        fi
      else
        tooltip="No media playing"
        class="inactive"
      fi

      echo "{\"text\": \"$text\", \"tooltip\": \"$tooltip\", \"class\": \"$class\"}"
    '';
  in [
    media-query
  ];
}
