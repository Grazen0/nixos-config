{config, ...}: {
  programs.cava = {
    settings = {
      general.framerate = 60;

      input.method = "pulse";

      color.foreground = "'${config.theme.colors.hexWithHashtag.brightWhite}'";

      smoothing.noise_reduction = 64;
    };
  };
}
