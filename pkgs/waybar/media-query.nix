{pkgs, ...}:
pkgs.writeShellApplication {
  name = "media-query";
  runtimeInputs = with pkgs; [playerctl];
  text = ''
    class=""
    text=""
    tooltip=""

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
}
