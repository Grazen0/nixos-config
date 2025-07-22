{
  config,
  pkgs,
  ...
}:
{
  programs.rofi =
    let
      inherit (config) theme;
    in
    {
      enable = true;
      package = pkgs.rofi-wayland;

      font = "${theme.font.propo} 12";
      terminal = config.meta.mainPrograms.terminal;
      location = "center";
      modes = [
        "drun"
        "calc"
        "emoji"
      ];

      plugins = with pkgs; [
        rofi-calc
        rofi-emoji-wayland
      ];

      extraConfig = {
        display-drun = "";
        drun-display-format = "{name}";
        hide-scrollbar = true;
        m = -4;
      };

      theme =
        let
          lit = config.lib.formats.rasi.mkLiteral;
        in
        with config.scheme.withHashtag;
        {
          "*" = {
            background-color = lit "transparent";
            margin = 0;
            padding = 0;
            spacing = 0;
            border = lit "none";
            text-color = lit "inherit";
          };

          window = {
            text-color = lit base05;
            background-color = lit base01;
            border = lit "3px";
            border-color = lit blue;
          };

          mainbox = {
            children = map lit [
              "inputbar"
              "message"
              "listview"
            ];
          };

          inputbar = {
            background-color = lit base01;
            children = map lit [
              "prompt"
              "entry"
            ];
            padding = lit "8px 16px";
            spacing = lit "8px";
            border = lit "0 0 3px 0";
            border-color = lit blue;
          };

          prompt = {
            text-color = lit base05;
          };

          message = {
            padding = lit "6px 16px";
            border = lit "0 0 3px 0";
            border-color = lit blue;
          };

          listview = {
            columns = 1;
            lines = 10;
            fixed-height = true;
          };

          element = {
            padding = lit "10px 24px";
            spacing = 16;
            highlight = lit "none";
          };

          "element.selected" = {
            background-color = lit base00;
          };

          element-icon = {
            size = lit "1.2em";
          };

          element-text = {
            vertical-align = lit "0.5";
          };
        };
    };
}
