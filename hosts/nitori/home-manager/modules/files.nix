{config, ...}: {
  home.file.handle_monitor_connect = {
    enable = true;
    source = ./files/bin;
    recursive = true;
    target = "${config.home.homeDirectory}/.local/bin";
  };
}
