{ config, inputs, ... }:
{
  programs.zathura = {
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

    options =
      let
        inherit (config) theme;
      in
      {
        adjust-open = "best-fit";
        render-loading = false;

        scroll-step = 50;

        selection-clipboard = "clipboard";

        recolor = true;
        recolor-keephue = true;
        recolor-reverse-video = true;

        font = "${theme.font.regular} 10";

        database = "sqlite";
      };

    extraConfig = builtins.readFile (config.scheme inputs.base16-zathura);
  };
}
