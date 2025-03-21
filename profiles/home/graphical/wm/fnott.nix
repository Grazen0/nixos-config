{
  config,
  pkgs,
  inputs,
  ...
}: {
  services.fnott = {
    enable = true;
    package = pkgs.fnott.overrideAttrs {src = inputs.fnott;};

    settings = let
      inherit (config) theme;

      colors = theme.colors.hex;
      fuzzel = "${config.programs.fuzzel.package}/bin/fuzzel";
    in {
      main = {
        selection-helper = "${fuzzel} --dmenu0";

        anchor = "bottom-right";
        min-width = 400;
        max-width = 600;
        max-height = 180;
        edge-margin-horizontal = 20;
        edge-margin-vertical = 20;
        progress-bar-height = 12;
        border-size = 4;
        padding-vertical = 16;

        default-timeout = 5;
        idle-timeout = 240;
        max-timeout = 300;

        background = "${colors.background}ff";
        progress-bar-color = "${colors.foreground}ff";

        body-font = "${theme.font.propo}:size=10";
        body-color = "${colors.foreground}ff";

        summary-font = "CommitMono Nerd Font Propo:size=10";
        summary-color = "${colors.foreground}ff";

        title-font = "${theme.font.propo}:size=8";
        title-color = "${colors.brightBlack}ff";
        title-format = "%a%A";
      };

      normal.border-color = "${colors.blue}ff";
      low.border-color = "${colors.brightBlack}ff";
      critical.border-color = "${colors.red}ff";
    };
  };
}
