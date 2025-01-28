{lib', ...}: {
  wayland.windowManager.river.settings.rule-add = let
    inherit (lib'.river) tagNumStr;
  in {
    "-app-id" = {
      "'thunar'" = ["ssd" "float"];
      "'*blueman-manager*'" = ["ssd" "float"];
      "'*blueman-adapters*'" = ["ssd" "float"];
      "'org.pulseaudio.pavucontrol'" = ["ssd" "float"];
      "'swayimg'" = ["ssd" "float"];
      "'org.gnome.FileRoller'" = ["ssd" "float"];
      "'nvidia-settings'" = ["ssd" "float"];
      "'gcr-prompter'" = ["ssd" "float"];
      "'nm-connection-editor'" = ["ssd" "float"];
      "'wdisplays'" = ["ssd" "float"];

      "'org.pwmt.zathura'" = ["ssd"];
      "'org.inkscape.Inkscape'" = ["ssd"];
      "'thorium-browser'" = ["ssd"];
      "'zen'" = ["ssd"];

      "'fceux'" = ["float"];

      "'equibop'" = ["ssd" "tags ${tagNumStr 7}"];
      "'spotify'" = ["tags ${tagNumStr 9}"];
    };

    "-title" = {
      "'Open File*'" = ["float"];
      "'Select a File*'" = ["float"];
      "'Choose wallpaper*'" = ["float"];
      "'Open Folder*'" = ["float"];
      "'Save As*'" = ["float"];
      "'Library*'" = ["float"];
      "'File Upload*'" = ["float"];
      "'Choose one'" = ["float"]; # R.nvim help selection popup
      "'Steam Settings'" = ["float"]; # Steam settings
      "'MainPicker'" = ["float"]; # Window picker
    };
  };
}
