{
  config,
  pkgs,
  theme,
  ...
}: {
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;

    font = "${theme.font.propo} 12";
    terminal = "${pkgs.foot}/bin/foot";
    location = "center";

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

    theme = let
      lit = config.lib.formats.rasi.mkLiteral;
    in
      with theme.colors.hex; {
        "*" = {
          background-color = lit "transparent";
          margin = 0;
          padding = 0;
          spacing = 0;
          border = lit "none";
          text-color = lit "inherit";
        };

        window = {
          text-color = lit brightWhite;
          background-color = lit background;
          border = lit "3px";
          border-color = lit yellow;
        };

        mainbox = {
          children = map lit ["inputbar" "message" "listview"];
        };

        inputbar = {
          background-color = lit black;
          children = map lit ["prompt" "entry"];
          padding = lit "8px 16px";
          spacing = lit "8px";
          border = lit "0 0 3px 0";
          border-color = lit yellow;
        };

        prompt = {
          text-color = lit white;
        };

        entry = {
          placeholder = "Search...";
          placeholder-color = lit brightBlack;
        };

        message = {
          padding = lit "6px 16px";
          border = lit "0 0 3px 0";
          border-color = lit yellow;
        };

        listview = {
          columns = 1;
          lines = 10;
          fixed-height = true;
        };

        element = {
          padding = lit "6px 16px";
          spacing = 10;
          highlight = lit "none";
        };

        "element.selected" = {
          background-color = lit backgroundAlt;
        };

        element-icon = {
          size = lit "1.25em";
        };

        element-text = {
          vertical-align = lit "0.5";
        };
      };
  };
}
