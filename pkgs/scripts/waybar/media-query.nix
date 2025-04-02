{
  writeShellApplication,
  playerctl,
  ...
}:
writeShellApplication {
  name = "media-query";
  runtimeInputs = [playerctl];
  text = ''
    playerctl="playerctl -p mopidy"
    class=""
    text=""
    tooltip=""

    if $playerctl status > /dev/null; then
      text=" $($playerctl metadata title)"
      tooltip=$($playerctl status)

      if [ "$tooltip" != "Playing" ]; then
        class="paused"
      fi
    else
      class="inactive"
    fi

    echo "{\"text\": \"$text\", \"tooltip\": \"$tooltip\", \"class\": \"$class\"}"
  '';
}
