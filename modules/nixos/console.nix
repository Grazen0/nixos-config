{
  config,
  pkgs,
  lib,
  ...
}: {
  console = {
    earlySetup = true;

    font = lib.mkDefault "${pkgs.terminus_font}/share/consolefonts/ter-v16b.psf.gz";
    keyMap = lib.mkDefault "us";

    colors = with config.theme.colors.hex-nh; [
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
