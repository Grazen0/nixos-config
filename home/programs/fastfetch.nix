{
  programs.fastfetch = {
    enable = true;

    settings = {
      modules = [
        "title"
        "separator"
        "os"
        "host"
        "kernel"
        "uptime"
        "packages"
        "shell"
        "display"
        "de"
        "wm"
        "wmtheme"
        "font"
        "cpu"
        "gpu"
        "memory"
        "swap"
        "disk"
        "battery"
        "locale"
        "break"
        "colors"
      ];
    };
  };
}
