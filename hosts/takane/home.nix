{ config, lib, ... }:
let
  inherit (lib) mkForce;
in
{
  imports = [
    ../../options/common
    ../../options/home-manager
    ../../configs/home

    ../../components/common/theme
    ../../components/home/base
    ../../components/home/graphical
    ../../components/home/touhou
    ../../components/home/tty
  ];

  wayland.windowManager = {
    hyprland.settings.input = {
      kb_layout = mkForce "latam,us";
      kb_variant = mkForce "";
    };
    river.settings.keyboard-layout = mkForce "-options 'caps:swapescape' 'latam,us'";
  };

  meta.eww.outputs.primary = "BOE";

  programs = {
    foot.settings.main.font = mkForce "${config.theme.font.regular}:size=10.5";
    kitty.font.size = mkForce 10.5;
    spicetify.enable = mkForce false;
  };

  home.stateVersion = "24.05";
}
