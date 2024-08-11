{config, ...}: {
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
      efi.canTouchEfiVariables = true;
    };

    # extraModulePackages = with config.boot.kernelPackages; [v4l2loopback];
    # extraModprobeConfig = ''
    #   options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
    # '';

    # initrd.verbose = false;
    # consoleLogLevel = 0;
    # kernelParams = [ "quiet" "udev.log_level=3" ];
  };
}
