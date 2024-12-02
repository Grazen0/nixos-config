{pkgs, ...}:
pkgs.writeShellApplication {
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
}
