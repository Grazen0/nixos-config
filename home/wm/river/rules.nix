{lib', ...}: {
  wayland.windowManager.river.settings.rule-add = let
    inherit (lib'.river) tagNumStr;
  in {
    "ssd" = "";

    "-app-id" = {
      "'thunar'" = ["float"];
      "'*blueman-adapters*'" = ["float"];
      "'org.pulseaudio.pavucontrol'" = ["float"];
      "'org.gnome.FileRoller'" = ["float"];
      "'nvidia-settings'" = ["float"];
      "'gcr-prompter'" = ["float"];
      "'nm-connection-editor'" = ["float"];
      "'wdisplays'" = ["float"];
      "'fceux'" = ["float"];
      "'Matplotlib'" = ["float"];
      "'R_x11'" = ["float"];
      "'zoom'"."-title"."'zoom'" = ["float"];

      "'kitty-float'" = ["float" "dimensions 800 450"];
      "'foot-float'" = ["float" "dimensions 800 450"];

      "'*blueman-manager*'" = ["float" "dimensions 480 320"];
      "'swayimg'" = ["float" "dimensions 1200 800"];

      "'equibop'" = ["tags ${tagNumStr 7}"];
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
      "'Friends List'" = ["float"]; # Steam friends list
      "'MainPicker'" = ["float"]; # Window picker
    };
  };
}
