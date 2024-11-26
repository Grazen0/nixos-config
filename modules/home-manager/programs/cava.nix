{theme, ...}: {
  programs.cava = {
    enable = false;

    settings = {
      general.framerate = 60;

      input.method = "pulse";

      color.foreground = "'${theme.colors.hex.brightWhite}'";

      smoothing.noise_reduction = 64;
    };
  };
}
