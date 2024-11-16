{config, ...}: {
  programs.cava = {
    enable = true;

    settings = {
      general = {
        framerate = 60;
        sensitivity = 25;
      };

      input.method = "pulse";

      color.foreground = "'${config.theme.colors.hex.brightWhite}'";

      smoothing.noise_reduction = 64;
    };
  };
}
