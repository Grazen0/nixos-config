{ config, ... }:
{
  programs.fuzzel = {
    enable = true;

    settings = {
      main = {
        launch-prefix = "uwsm app -- ";
        font = "${config.theme.font.propo}:size=12";
        inherit (config.meta.mainPrograms) terminal;
        use-bold = "yes";
        fields = "filename,name,generic,keywords";
        width = 60;
        inner-pad = 10;
        horizontal-pad = 16;
        vertical-pad = 12;
        line-height = 20;
      };

      border = {
        width = 2;
        radius = 0;
      };

      colors = with config.scheme; {
        background = "${base00}ff";
        text = "${base05}ff";
        prompt = "${blue}ff";
        placeholder = "${base04}ff";
        input = "${base05}ff";
        match = "${base05}ff";
        selection = "${blue}ff";
        selection-text = "${base00}ff";
        selection-match = "${base00}ff";
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
