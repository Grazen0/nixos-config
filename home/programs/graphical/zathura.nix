{config, ...}: {
  programs.zathura = {
    enable = true;

    mappings = {
      u = "scroll half-up";
      d = "scroll half-down";
      D = "toggle_page_mode";
      r = "reload";
      R = "rotate";
      K = "zoom in";
      J = "zoom out";
      i = "recolor";
      p = "print";
      c = ''set "first-page-column 1:1"'';
      C = ''set "first-page-column 1:2"'';
      b = ''set "guioptions s"'';
      B = ''set "guioptions none"'';
    };

    options = let
      inherit (config) theme;
    in
      with theme.colors.hexWithHashtag; {
        adjust-open = "best-fit";
        render-loading = false;

        scroll-step = 50;

        selection-clipboard = "clipboard";

        default-fg = brightWhite;
        default-bg = black;
        inputbar-bg = black;
        completion-bg = black;
        statusbar-bg = black;
        statusbar-fg = brightWhite;
        inputbar-fg = brightWhite;
        completion-group-bg = black;
        completion-highlight-bg = blue;
        notification-warning-bg = yellow;
        notification-warning-fg = black;
        notification-error-bg = red;
        notification-error-fg = brightWhite;

        recolor = true;
        recolor-keephue = true;
        recolor-reverse-video = true;
        recolor-lightcolor = background;
        recolor-darkcolor = brightWhite;

        font = "${theme.font.regular} 10";

        database = "sqlite";
      };
  };
}
