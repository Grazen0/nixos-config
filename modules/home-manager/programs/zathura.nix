{
  config,
  inputs,
}: {
  programs.zathura = {
    enable = true;

    mappings = {
      "u" = "scroll half-up";
      "d" = "scroll half-down";
      "D" = "toggle_page_mode";
      "r" = "reload";
      "R" = "rotate";
      "K" = "zoom in";
      "J" = "zoom out";
      "i" = "recolor";
      "p" = "print";
      "c" = "set \"first-page-column 1:1\"";
      "C" = "set \"first-page-column 1:2\"";
    };
    options = {
      guioptions = "sv";
      window-height = 1024;
      window-width = 1000;
      adjust-open = "best-fit";
      render-loading = false;

      scroll-step = 50;
      # scroll-full-overlap = 0.01;

      selection-clipboard = "clipboard";

      recolor = true;
      recolor-keephue = true;
      recolor-reverse-video = true;

      font = "JetBrainsMonoNL Nerd Font 10";

      database = "sqlite";
    };
    extraConfig = builtins.readFile (config.scheme inputs.base16-zathura);
  };
}
