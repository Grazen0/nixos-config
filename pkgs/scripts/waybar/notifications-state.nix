{
  writeShellApplication,
  fnott,
  ...
}:
writeShellApplication {
  name = "notifications-state";
  runtimeInputs = [fnott];
  text = ''
    icon=""
    class=""

    if [[ "$(fnottctl is-paused || echo "false")" == "false" ]]; then
      icon=""
      class="enabled"
    else
      icon=""
      class="paused"
    fi

    echo "{\"text\": \"$icon\", \"class\": \"$class\"}"
  '';
}
