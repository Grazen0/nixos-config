{
  imports = [
    ./autostart.nix
    ./binds.nix
    ./input.nix
    ./look.nix
    ./misc.nix
    ./rules.nix
    ./workspaces.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;

    xwayland.enable = true;
    systemd.enable = true;

    settings = {
      "$terminal" = "foot";
      "$browser" = "zen";
      "$fileManager" = "thunar";
      "$fileManagerAlt" = "yazi";

      monitor = [", preferred, auto, 1"];

      env = [
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "QT_GPA_PLATFORM,wayland"
        "NIXOS_OZONE_WL,1"
        "WLR_NO_HARDWARE_CURSORS,1"
      ];
    };

    systemd.variables = ["--all"];
  };
}
