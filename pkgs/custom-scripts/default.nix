{pkgs, ...}: {
  waybar = pkgs.callPackage ./waybar.nix {};

  handle-monitor-connect = pkgs.writeShellApplication {
    name = "handle-monitor-connect";
    runtimeInputs = with pkgs; [socat hyprland];
    text = ''
      handle() {
        case $1 in monitoradded*)
          hyprctl dispatch moveworkspacetomonitor "6 HDMI-A-1"
          hyprctl dispatch moveworkspacetomonitor "7 HDMI-A-1"
          hyprctl dispatch moveworkspacetomonitor "8 HDMI-A-1"
          hyprctl dispatch moveworkspacetomonitor "9 HDMI-A-1"
          hyprctl dispatch moveworkspacetomonitor "10 HDMI-A-1"
        esac
      }

      socat - "UNIX-CONNECT:''$XDG_RUNTIME_DIR/hypr/''${HYPRLAND_INSTANCE_SIGNATURE}/.socket2.sock" | while read -r line; do handle "$line"; done
    '';
  };

  close-window = pkgs.writeShellApplication {
    name = "close-window";
    runtimeInputs = with pkgs; [hyprland];
    text = ''
      info=$(hyprctl activewindow)

      if ! (echo "$info" | grep -q "zoom" && echo "$info" | grep -q "as_toolbar\|video_window"); then
        hyprctl dispatch killactive
      fi
    '';
  };

  exe2png = pkgs.writeShellApplication {
    name = "exe2png";
    runtimeInputs = with pkgs; [icoutils imagemagick];
    text = ''
      if [[ "$#" -lt 1 ]]; then
        echo "No source file provided"
        exit 1
      fi

      src=$1
      dest=''${2:-''${src%.*}.png}

      wrestool -x -t 14 "$src" | magick ico:- "$dest"
    '';
  };

  volume-update = pkgs.writeShellApplication {
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
  };

  make-writable = pkgs.writeShellApplication {
    name = "make-writable";
    text = ''
      if [[ "$#" -lt 1 ]]; then
        echo "No filename provided"
        exit 1
      fi

      contents=$(cat "$1")
      rm -f "$1"
      cat > "$1" <<< "$contents"
    '';
  };

  # Credit: https://github.com/thnikk/fuzzel-scripts/blob/master/fuzzel-powermenu.sh
  fuzzel-power-menu = pkgs.writeShellApplication {
    name = "fuzzel-power-menu";
    runtimeInputs = with pkgs; [fuzzel];
    text = ''
      SELECTION="$(printf "󰌾 Lock\n󰒲 Suspend\n󰋊 Hibernate\n Log out\n Reboot\n Shutdown" | fuzzel --dmenu -l 6)"

      case $SELECTION in
        *"Lock")
          loginctl lock-session "''${XDG_SESSION_ID-}";;
        *"Suspend")
          systemctl suspend;;
        *"Hibernate")
          systemctl hibernate;;
        *"Log out")
          loginctl terminate-session "''${XDG_SESSION_ID-}";;
        *"Reboot")
          systemctl reboot;;
        *"Shutdown")
          systemctl poweroff;;
      esac
    '';
  };
}
