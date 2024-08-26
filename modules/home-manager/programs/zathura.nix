{
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

      default-fg = "#dcd7ba";
      default-bg = "#16161d";
      inputbar-bg = "#16161d";
      completion-bg = "#16161d";
      statusbar-bg = "#16161d";
      statusbar-fg = "#dcd7ba";
      inputbar-fg = "#dcd7ba";
      completion-group-bg = "#16161d";
      completion-highlight-bg = "#7fb4ca";
      notification-warning-bg = "#c0a36e";
      notification-warning-fg = "#16161d";
      notification-error-bg = "#c34043";
      notification-error-fg = "#dcd7ba";

      recolor = true;
      recolor-keephue = true;
      recolor-reverse-video = true;
      recolor-lightcolor = "#1f1f28";
      recolor-darkcolor = "#dcd7ba";

      font = "JetBrainsMonoNL Nerd Font 10";

      database = "sqlite";
    };
  };
}