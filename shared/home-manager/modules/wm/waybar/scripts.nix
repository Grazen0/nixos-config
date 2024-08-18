{pkgs, ...}: {
  home.packages = let
    media-query = pkgs.writeShellScriptBin "media-query" ''
      #!/usr/bin/env bash

      class=""
      text=""
      tooltip=""

      # TODO: check this out n fix
      if playerctl status > /dev/null; then
        text=" $(playerctl metadata title)"
        tooltip=$(playerctl status)

        if [ "$tooltip" != "Playing" ]; then
          class="paused"
        fi
      else
        class="inactive"
      fi

      echo "{\"text\": \"$text\", \"tooltip\": \"$tooltip\", \"class\": \"$class\"}"
    '';
  in [
    media-query
  ];
}
