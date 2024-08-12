{
  config,
  lib,
  pkgs,
  hardware,
  ...
}: {
  imports = [hardware.common-gpu-intel];

  console = {
    font = "${pkgs.terminus_font}/share/consolefonts/ter-v20b.psf.gz";
    keyMap = "us";
  };
}
