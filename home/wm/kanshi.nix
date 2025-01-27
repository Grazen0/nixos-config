{
  services.kanshi = {
    enable = true;

    # TODO: migrate to `settings`
    profiles = {
      dualMonitor = {
        outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
            scale = 1.0;
            position = "0,0";
            transform = "normal";
          }
          {
            criteria = "HDMI-A-1";
            status = "enable";
            scale = 1.0;
            position = "-1366,0";
            transform = "normal";
          }
        ];
      };

      singleMonitor = {
        outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
            scale = 1.0;
            position = "0,0";
            transform = "normal";
          }
        ];
      };
    };
  };
}
