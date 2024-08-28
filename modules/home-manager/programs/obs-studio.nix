{config, ...}: {
  programs.obs-studio.enable = true;

  # v4l2loopback module required for OBS Virtual Camera
  boot = {
    extraModulePackages = with config.boot.kernelPackages; [v4l2loopback];
    extraModprobeConfig = ''
      options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
    '';
  };
}
