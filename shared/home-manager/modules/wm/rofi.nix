{
  config,
  pkgs,
  ...
}: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;

    font = "JetBrainsMonoNL Nerd Font Propo 10";
    terminal = "${pkgs.kitty}/bin/kitty";

    location = "center";

    extraConfig = {
      show-icons = true;
      display-drun = "";
      display-dmenu = "";
      drun-display-format = "{name}";
      hide-scrollbar = true;
      m = -4;
    };

    # TODO: somehow add list-styled theme for things other than app launching
    theme = let
      lit = config.lib.formats.rasi.mkLiteral;
      background = lit "#1f1f28";
      background-alt = lit "#363646";
      background-alt-2 = lit "#16161d";
      foreground = lit "#dcd7ba";
      foreground-alt = lit "#727169";
    in {
      "*" = {
        background-color = lit "transparent";
        text-color = foreground;
      };

      window = {
        background-color = background;
        padding = lit "20px";
        border-radius = lit "10px";
      };

      inputbar = {
        children = map lit ["prompt" "entry"];
        background-color = background-alt-2;

        border-radius = lit "8px";

        padding = lit "8px 16px";
        spacing = lit "8px";
      };

      listview = {
        lines = 4;
        columns = 6;
        fixed-height = true;

        border = lit "none";
        margin = lit "12px 0 0";
      };

      element = {
        padding = lit "8px 16px";
        margin = lit "2px";
        border-radius = lit "8px";
        orientation = lit "vertical";
      };

      "element.selected" = {
        background-color = background-alt;
      };

      element-text = {
        horizontal-align = lit "0.5";
        text-color = lit "inherit";
        margin = lit "0.2em 0";
      };

      element-icon = {
        size = lit "2.5em";
        padding = lit "0 4px 0 0";
      };

      entry = {
        placeholder = "Search...";
        placeholder-color = foreground-alt;
        text-color = foreground;
      };
    };
  };
}
