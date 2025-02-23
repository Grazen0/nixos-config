{
  dunst,
  writeShellApplication,
  ...
}:
writeShellApplication {
  name = "dunst-state";
  runtimeInputs = [dunst];
  text = ''
    icon=""
    class=""

    if [[ "$(fnottctl is-paused)" == "false" ]]; then
      icon=""
      class="enabled"
    else
      icon=""
      class="paused"
    fi

    echo "{\"text\": \"$icon\", \"class\": \"$class\"}"
  '';
}
