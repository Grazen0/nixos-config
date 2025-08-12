{ pkgs, ... }:
{
  hardware.bluetooth.enable = true;

  programs.dconf.enable = true;
  programs.hyprland.enable = true;
  programs.thunar.enable = true;

  services.pipewire.enable = true;
  services.blueman.enable = true;
  services.libinput.enable = true;
  services.gvfs.enable = true;
  services.tumbler.enable = true;
  services.printing.enable = true;
  services.avahi.enable = true;
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;

  fonts.packages = with pkgs; [
    comic-neue
    liberation_ttf
    nerd-fonts.comic-shanns-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
  ];
}
