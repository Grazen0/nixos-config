{pkgs, ...}: {
  media-query = pkgs.writeShellApplication {
    name = "media-query";
    runtimeInputs = with pkgs; [playerctl];
    text = ''
      class=""
      text=""
      tooltip=""

      if playerctl -p spotify status > /dev/null; then
        text=" $(playerctl -p spotify metadata title)"
        tooltip=$(playerctl -p spotify status)

        if [ "$tooltip" != "Playing" ]; then
          class="paused"
        fi
      else
        class="inactive"
      fi

      echo "{\"text\": \"$text\", \"tooltip\": \"$tooltip\", \"class\": \"$class\"}"
    '';
  };

  dunst-state = pkgs.writeShellApplication {
    name = "dunst-state";
    runtimeInputs = with pkgs; [dunst];
    text = ''
      #!/usr/bin/env bash
      icon=""
      class=""

      if [[ "$(dunstctl is-paused)" == "false" ]]; then
        icon=""
        class="enabled"
      else
        icon=""
        class="paused"
      fi

      echo "{\"text\": \"$icon\", \"class\": \"$class\"}"
    '';
  };
}
