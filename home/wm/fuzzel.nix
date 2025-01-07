{
  config,
  pkgs,
  ...
}: {
  # I really want to use fuzzel, but I need kitty's graphics protocol
  programs.fuzzel = {
    enable = false;

    settings = let
      inherit (config) theme;
    in {
      main = {
        font = "${theme.font.propo}:size=12";
        terminal = "${pkgs.kitty}/bin/kitty";
        use-bold = "yes";
        fields = "filename,name,generic,keywords";
        width = 60;
        inner-pad = 10;
        horizontal-pad = 16;
        vertical-pad = 12;
        line-height = 20;
      };

      border = {
        width = 4;
        radius = 10;
      };

      colors = with theme.colors.hex; {
        background = "${background}cc";
        text = "${foreground}ff";
        prompt = "${blue}ff";
        placeholder = "${brightBlack}ff";
        input = "${foreground}ff";
        match = "${foreground}ff";
        selection = "${blue}ff";
        selection-text = "${background}ff";
        selection-match = "${background}ff";
        border = "${blue}ff";
      };

      key-bindings = {
        # Don't wanna accidentally open something with <Tab>
        execute-or-next = "none";
        next-with-wrap = "Tab";
      };
    };
  };
}
