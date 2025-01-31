{
  config,
  osConfig,
  ...
}: {
  mainPrograms = let
    inherit (config) programs;
  in {
    terminal = "${programs.kitty.package}/bin/kitty";
    editor = "nvim";
    browser = "zen";
    fileManager = "thunar";
    fileManagerCli = "${programs.yazi.package}/bin/yazi";
    appLauncher = "${programs.fuzzel.package}/bin/fuzzel --launch-prefix='${osConfig.programs.uwsm.package}/bin/uwsm app -- '";
    dmenu = "${programs.fuzzel.package}/bin/fuzzel --dmenu";
  };
}
