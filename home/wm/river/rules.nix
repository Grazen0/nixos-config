{lib', ...}: {
  wayland.windowManager.river.settings.rule-add = let
    inherit (lib'.river) tagNumStr;
  in {
    "ssd" = "";

    "-app-id" = {
      "'thunar'" = ["float"];
      "'*blueman-manager*'" = ["float"];
      "'*blueman-adapters*'" = ["float"];
      "'org.pulseaudio.pavucontrol'" = ["float"];
      "'swayimg'" = ["float"];
      "'org.gnome.FileRoller'" = ["float"];
      "'nvidia-settings'" = ["float"];
      "'gcr-prompter'" = ["float"];
      "'nm-connection-editor'" = ["float"];
      "'wdisplays'" = ["float"];
      "'fceux'" = ["float"];

      "'kitty-float'" = ["float" "dimensions 800 450"];

      "'equibop'" = ["tags ${tagNumStr 7}"];
      "'spotify'" = ["tags ${tagNumStr 9}"];
    };

    "-title" = {
      "'Open File*'" = ["float"];
      "'Select a File*'" = ["float"];
      "'Choose wallpaper*'" = ["float"];
      "'Open Folder*'" = ["float"];
      "'Open folder*'" = ["float"];
      "'Save As*'" = ["float"];
      "'Library*'" = ["float"];
      "'File Upload*'" = ["float"];
      "'Choose one'" = ["float"]; # R.nvim help selection popup
      "'Steam Settings'" = ["float"]; # Steam settings
      "'MainPicker'" = ["float"]; # Window picker
    };
  };
}
