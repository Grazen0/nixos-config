{
  config,
  lib,
  ...
}: {
  home.file = let
    programs = [
      "ZapZap"
      "matlab"
      "nixpkgs"
      "peaclock"
      "vesktop"
    ];
  in
    {
      wallpaper = {
        source = ../../files/wallpaper.png;
        target = "${config.xdg.userDirs.pictures}/wallpaper.png";
      };
    }
    // lib.genAttrs programs (program: {
      source = ../../files/config/${program};
      recursive = true;
      target = "${config.xdg.configHome}/${program}";
    });
}
