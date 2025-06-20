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

  home.sessionVariables = {
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    systemd.enable = false; # Conflicts with UWSM

    settings = {
      monitor = [ ", preferred, auto, 1" ];

      ecosystem = {
        no_update_news = true;
        no_donation_nag = true;
      };
    };

    systemd.variables = [ "--all" ];
  };
}
