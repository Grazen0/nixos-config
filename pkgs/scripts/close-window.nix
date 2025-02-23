{
  writeShellApplication,
  hyprland,
  ...
}:
writeShellApplication {
  name = "close-window";
  runtimeInputs = [hyprland];
  text = ''
    info=$(hyprctl activewindow)

    if ! (echo "$info" | grep -q "zoom" && echo "$info" | grep -q "as_toolbar\|video_window"); then
      hyprctl dispatch killactive
    fi
  '';
}
