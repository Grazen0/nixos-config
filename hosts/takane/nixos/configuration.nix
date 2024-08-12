{
  config,
  lib,
  pkgs,
  ...
}: {
  console = {
    font = "${pkgs.terminus_font}/share/consolefonts/ter-v16b.psf.gz";
    keyMap = "la-latin1";
  };
}
