{lib, ...}: let
  inherit (lib) mkOption types;
in {
  options.meta = {
    mainUser = mkOption {
      type = types.str;
    };

    mainPrograms = {
      terminal = mkOption {type = types.str;};
      editor = mkOption {type = types.str;};
      browser = mkOption {type = types.str;};
      fileManager = mkOption {type = types.str;};
      fileManagerCli = mkOption {type = types.str;};
      appLauncher = mkOption {type = types.str;};
      dmenu = mkOption {type = types.str;};
    };
  };
}
