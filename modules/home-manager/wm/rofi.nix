{
  config,
  pkgs,
  ...
}: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;

    font = "JetBrainsMonoNL Nerd Font Propo 12";
    terminal = "${pkgs.kitty}/bin/kitty";
    location = "center";

    extraConfig = {
      display-drun = "";
      drun-display-format = "{name}";
      hide-scrollbar = true;
      m = -4;
    };

    theme = let
      lit = config.lib.formats.rasi.mkLiteral;

      colors = {
        background = lit "#1f1f28";
        backgroundAlt = lit "#16161d";
        border = lit "#c0a36e";
        dimmed = lit "#727169";
        highlight = lit "#363646";

        foreground = lit "#dcd7ba";
        foregroundAlt = lit "#c8c093";
      };
    in {
      "*" = {
        background-color = lit "transparent";
        text-color = colors.foreground;
        margin = 0;
        padding = 0;
        spacing = 0;
        border = lit "none";
      };

      window = {
        background-color = colors.background;
        border = lit "3px";
        border-color = colors.border;
      };

      inputbar = {
        background-color = colors.backgroundAlt;
        children = map lit ["prompt" "entry"];
        padding = lit "8px 16px";
        spacing = lit "8px";
        border = lit "0 0 3px 0";
        border-color = colors.border;
      };

      prompt = {
        text-color = colors.foregroundAlt;
      };

      entry = {
        placeholder = "Search...";
        placeholder-color = colors.dimmed;
      };

      listview = {
        columns = 1;
        lines = 10;
        fixed-height = true;
      };

      element = {
        padding = lit "6px 16px";
        spacing = 10;
      };

      element-icon = {
        size = lit "1.25em";
      };

      element-text = {
        vertical-align = lit "0.5";
      };

      "element.selected" = {
        background-color = colors.highlight;
      };
    };
  };
}
