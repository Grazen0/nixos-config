{
  pkgs,
  lib,
  ...
}: {
  console = {
    earlySetup = true;

    font = lib.mkDefault "${pkgs.terminus_font}/share/consolefonts/ter-v16b.psf.gz";
    keyMap = lib.mkDefault "us";

    colors = [
      "16161d"
      "c34043"
      "76946a"
      "c0a36e"
      "7e9cd8"
      "957fb8"
      "6a9589"
      "c8c093"
      "727169"
      "e82424"
      "98bb6c"
      "e6c384"
      "7fb4ca"
      "938aa9"
      "7aa89f"
      "dcd7ba"
    ];
  };
}
