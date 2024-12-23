{
  pkgs,
  inputs,
  ...
}: {
  home.packages = [
    inputs.hyprland-qtutils.packages.${pkgs.system}.default
  ];

  imports = [
    ./hyprland
    ./hypridle.nix
    ./hyprlock.nix
  ];
}
