{
  imports = [
    ./hypr
    ./waybar
    ./dunst.nix
    ./rofi.nix
  ];

  services.cliphist = {
    enable = true;
    extraOptions = [
      "-max-items"
      "100"
    ];
  };
}
