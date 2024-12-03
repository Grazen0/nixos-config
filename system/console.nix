{
  config,
  pkgs,
  ...
}: {
  console = {
    font = "${pkgs.terminus_font}/share/consolefonts/ter-v16b.psf.gz";
    keyMap = "us";

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
