{ writeShellApplication, fuzzel, ... }:
writeShellApplication {
  name = "fuzzel-power-menu";
  runtimeInputs = [ fuzzel ];

  # Credit: https://github.com/thnikk/fuzzel-scripts/blob/master/fuzzel-powermenu.sh
  text = ''
    SELECTION="$(printf "󰌾 Lock\n󰒲 Suspend\n󰋊 Hibernate\n Log out\n Reboot\n Shut down" | fuzzel -d -l 6)"

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
      *"Shut down")
        systemctl poweroff;;
    esac
  '';
}
