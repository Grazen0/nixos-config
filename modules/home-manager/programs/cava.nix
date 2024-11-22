{config, ...}: {
  programs.cava = {
    enable = false;

    settings = {
      general.framerate = 60;

      input.method = "pulse";

      color.foreground = "'${config.theme.colors.hex.brightWhite}'";

      smoothing.noise_reduction = 64;
    };
  };
}
