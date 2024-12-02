{pkgs, ...}:
pkgs.writeShellApplication {
  name = "volume-update";
  runtimeInputs = with pkgs; [pamixer];
  text = ''
    volume=$(pamixer --get-volume)
    mute=$(pamixer --get-mute)
    wob_sock=$(systemctl --user list-sockets | grep wob | awk '{print $1;}')

    if [[ "$mute" == "true" ]]; then
      echo "$volume muted" > "$wob_sock"
    else
      echo "$volume" > "$wob_sock"
    fi

  '';
}
