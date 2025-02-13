{pkgs, ...}:
pkgs.writeShellApplication {
  name = "player-art";
  runtimeInputs = with pkgs; [mpc playerctl ffmpeg chafa];
  text = ''
    if [[ $# -ne 1 ]]; then
      echo "Usage: player-art [FALLBACK]"
      exit 1
    fi

    SIZE="960"
    VF="scale=$SIZE:$SIZE:force_original_aspect_ratio=increase,crop=$SIZE:$SIZE"
    IMG_FILE=$(mktemp "/tmp/XXXXXXXXXXXXXXXX.png")

    fallback="$1"

    function cleanup() {
      tput cnorm
      rm -f "$IMG_FILE"
    }

    # https://stackoverflow.com/questions/6250698/how-to-decode-url-encoded-string-in-shell
    function urldecode() {
      echo -e "$(sed 's/+/ /g;s/%\(..\)/\\x\1/g;')"
    }

    function update_image() {
      # Attempt 1: mpris:artUrl via playerctl
      if art_url=$(playerctl --player mopidy metadata mpris:artUrl 2>/dev/null); then
        ffmpeg -nostdin -loglevel 0 -y -i "$art_url" -vf "$VF" "$IMG_FILE"
        return
      fi

      # Attempt 2: Extract image from music file
      file_url=$(mpc --format %file% current 2>/dev/null | urldecode)
      file="''${file_url/#file:\/\//}"

      if [[ -z "$file" ]]; then
        return 1
      fi

      if ffmpeg -nostdin -loglevel 0 -y -i "$file" -an -vf "$VF" "$IMG_FILE"; then
        return
      fi

      # Attempt 3: Find image on the music file's directory
      dir=$(dirname "$file")
      src_file=$(find "$dir" -maxdepth 1 -regex ".*\.\(jpe?g\|png\|gif\|bmp\)" -print -quit)

      if [[ -z "$src_file" ]]; then
        return 1
      fi

      ffmpeg -nostdin -loglevel 0 -y -i "$src_file" -vf "$VF" "$IMG_FILE"
    }

    function display_image() {
      clear
      printf "\n"
      chafa --format sixel --align center,center --margin-bottom 3 "$IMG_FILE"
      tput civis
    }

    function term_size() {
      # stty size doesn't work for some reason
      echo "$(tput lines) $(tput cols)"
    }

    previous_size=$(term_size)

    function resize_check_loop() {
      # Re-display image whenever the terminal is resized
      while true; do
        current_size=$(term_size)

        if [[ "$current_size" != "$previous_size" ]]; then
          display_image
          previous_size="$current_size"
        fi

        sleep 0.5
      done
    }

    function on_playerctl_update() {
      if ! update_image; then
        ffmpeg -nostdin -loglevel 8 -y -i "$fallback" -vf "$VF" "$IMG_FILE"
      fi

      display_image
    }

    stty -echo
    trap cleanup EXIT

    resize_check_loop &

    # If nothing is on, playerctl won't output anything initially
    if ! playerctl --player mopidy metadata &>/dev/null; then
      on_playerctl_update
    fi

    playerctl --player mopidy --follow metadata title | while read -r; do
      on_playerctl_update
    done
  '';
}
