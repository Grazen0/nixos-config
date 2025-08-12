{
  programs.fastfetch = {
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
        "de"
        "wm"
        "wmtheme"
        "font"
        "cpu"
        "gpu"
        "memory"
        "disk"
        "break"
        "colors"
      ];

      # Blatantly stolen from https://github.com/Sw3d15h-F1s4/nixos/blob/main/modules/home-manager/features/fastfetch/icon.txt
      logo.source = ./icon.txt;
    };
  };
}
