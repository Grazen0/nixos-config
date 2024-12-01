{
  config,
  pkgs,
  lib,
  ...
}: {
  console = {
    font = lib.mkDefault "${pkgs.terminus_font}/share/consolefonts/ter-v16b.psf.gz";
    keyMap = lib.mkDefault "us";

    colors = with config.theme.colors.hex; [
      black
      red
      green
      yellow
      blue
      magenta
      cyan
      white
      brightBlack
      brightRed
      brightGreen
      brightYellow
      brightBlue
      brightMagenta
      brightCyan
      brightWhite
    ];
  };
}
