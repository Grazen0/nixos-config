{
  config,
  pkgs,
  ...
}: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;

    font = "JetBrainsMonoNL Nerd Font 12";
    terminal = "${pkgs.kitty}/bin/kitty";

    extraConfig = {
      show-icons = true;
      display-drun = "";
      drun-display-format = "{name}";
      hide-scrollbar = true;
      m = -4;
    };

    theme = let
      lit = config.lib.formats.rasi.mkLiteral;

      background = lit "#1f1f28";
      foreground = lit "#dcd7ba";
      accent = lit "#7fb4ca";
      disabled = lit "#727169";
      alert = lit "#e82424";
    in {
      "*" = {
        background-color = lit "transparent";
      };

      window = {
        location = lit "center";
        width = lit "480px";

        border = lit "2px";
        border-radius = lit "24px";
        border-color = accent;

        background-color = background;
        padding = lit "20px";
      };

      inputbar = {
        children = map lit ["entry"];
        background-color = background;

        border = lit "2px";
        border-color = accent;
        border-radius = lit "16px";

        padding = lit "8px 16px";
        spacing = lit "8px";
      };

      "entry, element-text, element-icon" = {
        vertical-align = lit "0.5";
      };

      listview = {
        lines = 6;
        columns = 1;
        fixed-height = true;
        scrollbar = false;

        border = lit "none";
        margin = lit "12px 0 0";
        spacing = lit "15px";
      };

      element = {
        padding = lit "8px 16px";
        border-radius = lit "16px";
        border = lit "1px";
        border-color = accent;
      };

      "element.normal.normal, element.alternate.normal" = {
        background-color = lit "transparent";
        text-color = foreground;
      };

      "element.selected.normal" = {
        background-color = accent;
        text-color = background;
      };

      element-text = {
        text-color = lit "inherit";
      };

      element-icon = {
        size = lit "1.5em";
      };

      entry = {
        placeholder = "Search...";
        placeholder-color = disabled;
        text-color = foreground;
      };

      message = {
        margin = lit "15px 0";
        border-radius = lit "16px";
        border = lit "none";
      };

      textbox = {
        text-color = alert;
      };
    };
  };
}
