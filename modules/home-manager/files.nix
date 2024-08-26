{config, ...}: {
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

      rofi-themes = {
        source = ../../files/rofi-themes;
        recursive = true;
        target = "${config.xdg.dataHome}/rofi/themes";
      };
    }
    // builtins.listToAttrs (builtins.map (program: {
        name = program;
        value = {
          source = ../../files/config/${program};
          recursive = true;
          target = "${config.xdg.configHome}/${program}";
        };
      })
      programs);
}
