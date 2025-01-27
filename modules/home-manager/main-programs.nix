{lib, ...}: {
  options.mainPrograms = {
    terminal = lib.mkOption {type = lib.types.str;};
    browser = lib.mkOption {type = lib.types.str;};
    fileManager = lib.mkOption {type = lib.types.str;};
    fileManagerCli = lib.mkOption {type = lib.types.str;};
    appLauncher = lib.mkOption {type = lib.types.str;};
    dmenu = lib.mkOption {type = lib.types.str;};
  };
}
