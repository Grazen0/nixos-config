{
  programs.fastfetch = {
    enable = true;
    settings = {
      modules = [
        {
          "type" = "custom";
          "format" = "{#36}┌{$1} Hardware Information {$1}┐{#}";
        }
        {
          "type" = "host";
          "key" = "  󰌢";
        }
        {
          "type" = "cpu";
          "key" = "  󰻠";
          "format" = "{name}";
        }
        {
          "type" = "gpu";
          "key" = "  󰍛";
          "format" = "{vendor} {name}";
        }
        {
          "type" = "disk";
          "key" = "  ";
        }
        {
          "type" = "memory";
          "key" = "  󰑭";
        }
        {
          "type" = "custom";
          "format" = "{#36}├{$1} Software Information {$1}┤{#}";
        }
        {
          "type" = "title";
          "key" = "  ";
          "format" = "{1}@{2}";
        }
        {
          "type" = "os";
          "key" = "  󰣇";
        }
        {
          "type" = "kernel";
          "key" = "  ";
          "format" = "{1} {2}";
        }
        {
          "type" = "wm";
          "key" = "  ";
        }
        {
          "type" = "shell";
          "key" = "  ";
        }
        {
          "type" = "terminal";
          "key" = "  ";
        }
        {
          "type" = "packages";
          "key" = "  󰏖";
        }
        {
          "type" = "uptime";
          "key" = "  󰅐";
        }
        {
          "type" = "custom";
          "format" = "{#36}└{$1}──────────────────────{$1}┘{#}";
        }
        {
          "type" = "colors";
          "paddingLeft" = 2;
          "symbol" = "circle";
        }
      ];
      "display" = {
        "separator" = "    ";
        "constants" = [
          "──────────────"
        ];
      };
    };
  };
}
