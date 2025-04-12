{config, ...}: {
  programs.cava = {
    settings = {
      general.framerate = 60;

      input.method = "pulse";

      color.foreground = "'${config.scheme.withHashtag.base05}'";

      smoothing.noise_reduction = 64;
    };
  };
}
