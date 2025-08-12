{
  services.kanshi = {
    settings = [
      {
        output = {
          criteria = "eDP-1";
          status = "enable";
          scale = 1.0;
          transform = "normal";
          position = "0,0";
        };
      }
      {
        output = {
          criteria = "HDMI-A-1";
          status = "enable";
          scale = 1.0;
          transform = "normal";
          position = "-1366,0";
        };
      }
      {
        profile = {
          name = "undocked";
          outputs = [ { criteria = "eDP-1"; } ];
        };
      }
      {
        profile = {
          name = "docked";
          outputs = [
            { criteria = "eDP-1"; }
            { criteria = "HDMI-A-1"; }
          ];
        };
      }
    ];
  };
}
