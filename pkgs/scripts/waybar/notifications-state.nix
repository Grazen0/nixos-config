{ writeShellApplication, dunst, ... }:
writeShellApplication {
  name = "notifications-state";
  runtimeInputs = [ dunst ];
  text = ''
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
}
