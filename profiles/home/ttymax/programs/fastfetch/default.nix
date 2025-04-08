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

      # Blatantly stolen from https://github.com/Sw3d15h-F1s4/nixos/blob/main/modules/home-manager/features/fastfetch/icon.txt
      logo.source = ./icon.txt;
    };
  };
}
