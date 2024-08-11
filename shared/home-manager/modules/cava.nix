{
  programs.cava = {
    enable = true;

    settings = {
      general.framerate = 60;

      input.method = "pulse";

      color.foreground = "'#e6c384'";

      smoothing.noise_reduction = 64;
    };
  };
}
