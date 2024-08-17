{config, ...}: {
  home.file = let
    programs = [
      "vesktop"
      "whatsapp-for-linux"
    ];
  in
    {
      wallpapers = {
        source = ../files/wallpapers;
        recursive = true;
        target = "${config.xdg.userDirs.pictures}/Wallpapers";
      };
    }
    // builtins.listToAttrs (builtins.map (program: {
        name = program;
        value = {
          source = ../files/config/${program};
          recursive = true;
          target = "${config.xdg.configHome}/${program}";
        };
      })
      programs);
}
