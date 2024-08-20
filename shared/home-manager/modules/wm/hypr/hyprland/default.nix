{
  imports = [
    ./autostart.nix
    ./binds.nix
    ./env.nix
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
      "$terminal" = "kitty";
      "$browser" = "brave";
      "$fileManager" = "thunar";
    };

    systemd.variables = ["--all"];
  };
}
