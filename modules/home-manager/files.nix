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
      wallpapers = {
        source = ../../files/wallpapers;
        recursive = true;
        target = "${config.xdg.userDirs.pictures}/Wallpapers";
      };
    }
    // lib.genAttrs programs (program: {
      source = ../../files/config/${program};
      recursive = true;
      target = "${config.xdg.configHome}/${program}";
    });
}
