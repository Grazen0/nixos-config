{config, ...}: {
  programs.cava = {
    enable = true;

    settings = {
      general.framerate = 60;

      input.method = "pulse";

      color.foreground = "'${config.theme.colors.hex.brightYellow}'";

      smoothing.noise_reduction = 64;
    };
  };
}
