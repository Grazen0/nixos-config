{pkgs, ...}:
pkgs.writeShellApplication {
  name = "dunst-state";
  runtimeInputs = with pkgs; [dunst];
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
