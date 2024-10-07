{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.foot = {
    enable = true;
    server.enable = false;

    settings = let
      kanagawa = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/rebelot/kanagawa.nvim/refs/heads/master/extras/foot_kanagawa.ini";
        sha256 = "0r8v3scj9zgkv5lxhgyd7wbp1liy8mlj5pczxf5f1ykmish531h5";
      };
    in {
      main = {
        font = lib.mkDefault "${config.theme.font.regular}:size=9.5";
        include = "${kanagawa}"; # TODO: set colors with theme module
      };

      mouse.hide-when-typing = "yes";
      cursor.color = with config.theme.colors.hexNh; "${background} ${white}";

      scrollback.lines = 10000;
    };
  };
}
