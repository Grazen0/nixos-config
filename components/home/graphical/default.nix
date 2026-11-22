{
  config,
  lib,
  pkgs,
  customPkgs,
  inputs,
  ...
}:
{
  imports = [
    ./vesktop
    ./eww
  ];

  programs.mpv.enable = true;
  programs.foot.enable = true;
  programs.zathura.enable = true;
  programs.swayimg.enable = true;
  programs.obs-studio.enable = true;

  programs.fuzzel.enable = true;
  programs.waybar.enable = true;
  programs.swaylock.enable = true;
  # programs.spicetify.enable = true;

  services.cliphist.enable = true;
  services.wob.enable = true;
  services.dunst.enable = true;
  services.hypridle.enable = true;

  wayland.windowManager.hyprland.enable = true;

  xdg.portal.enable = true;
  xdg.mimeApps.enable = true;

  gtk.enable = true;
  qt.enable = true;

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      font-name = "${config.theme.font.propo} 11";
      color-scheme = "prefer-dark";
    };
  };

  # Thunar is already enabled in the system configuration,
  # though it'd be cool if it could be enable per-user
  xdg.configFile."xfce4/helpers.rc".text = ''
    TerminalEmulator=${config.meta.mainPrograms.terminal}
  '';

  home.sessionVariables = {
    XDG_SESSION_TYPE = "wayland";
    QT_GPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    NIXOS_OZONE_WL = "1";
    BEMOJI_PICKER_CMD = config.meta.mainPrograms.dmenu;
    EDITOR = config.meta.mainPrograms.editor;
  };

  meta.mainPrograms = {
    terminal = "foot";
    browser = "firefox";
    fileManager = "thunar";
    appLauncher = "fuzzel";
    dmenu = "fuzzel --dmenu";
  };

  home.packages = with pkgs; [
    cryptsetup
    rmtrash
    trash-cli
    opencode

    # Desktop utilities
    file-roller
    onlyoffice-desktopeditors
    pavucontrol

    firefox
    inputs.thorium-browser.defaultPackage.${pkgs.stdenv.hostPlatform.system}
    mattermost-desktop
    pinta
    xournalpp
    zoom-us

    # Basic gaming
    wineWow64Packages.stable
    wl-clipboard
  ];

  theme.home = {
    wallpaper = {
      enable = true;
      source = ./wallpaper.png;
    };

    cursor = {
      enable = true;
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };
  };
}
