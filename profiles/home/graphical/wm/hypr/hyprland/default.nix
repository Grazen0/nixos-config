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
    xwayland.enable = true;
    systemd.enable = false; # Conflicts with UWSM

    settings = {
      monitor = [ ", preferred, auto, 1" ];

      env = [
        "XDG_CURRENT_DESKTOP,Hyprland"
        "XDG_SESSION_TYPE,wayland"
        "XDG_SESSION_DESKTOP,Hyprland"
        "QT_GPA_PLATFORM,wayland"
        "NIXOS_OZONE_WL,1"
        "WLR_NO_HARDWARE_CURSORS,1"
        # idc, this is for a local server
        "OBSIDIAN_REST_API_KEY,fcaf7dede9cdedd5bbbb8e1d2889cf88974d7ed5340b1f225a01a50e8faa444e"
      ];
    };

    systemd.variables = [ "--all" ];
  };
}
