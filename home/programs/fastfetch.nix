{
  programs.fastfetch = {
    enable = true;

    settings = {
      logo = "nix_small";

      modules = [
        {
          type = "os";
          key = "  ";
        }
        {
          type = "kernel";
          key = "  ";
          format = "{1} {2}";
        }
        {
          type = "wm";
          key = "  ";
        }
        {
          type = "shell";
          key = "  ";
        }
        {
          type = "terminal";
          key = "  ";
        }
        {
          type = "uptime";
          key = "  󰅐";
        }
        {
          type = "colors";
          paddingLeft = 2;
          symbol = "circle";
        }
      ];

      display.separator = "    ";
    };
  };
}
