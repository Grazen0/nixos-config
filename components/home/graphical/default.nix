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
    ./equibop
    ./eww
  ];

  programs.jetbrains.enable = true;
  programs.mpv.enable = true;
  programs.foot.enable = true;
  programs.zathura.enable = true;
  programs.swayimg.enable = true;
  programs.obs-studio.enable = true;

  programs.fuzzel.enable = true;
  programs.waybar.enable = true;
  programs.swaylock.enable = true;
  programs.spicetify.enable = true;

  services.cliphist.enable = true;
  services.wob.enable = true;
  services.dunst.enable = true;
  services.hypridle.enable = true;

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
    # idc, this is for a local server
    OBSIDIAN_REST_API_KEY = "fcaf7dede9cdedd5bbbb8e1d2889cf88974d7ed5340b1f225a01a50e8faa444e";
    EDITOR = config.meta.mainPrograms.editor;
  };

  # Export home.sessionVariables from .config/uwsm/env
  xdg.configFile."uwsm/env".text =
    let
      inherit (lib) mapAttrsToList escapeShellArg concatStringsSep;

      lines = mapAttrsToList (
        key: value: "export ${key}=${escapeShellArg value}"
      ) config.home.sessionVariables;
    in
    concatStringsSep "\n" lines;

  meta.mainPrograms = {
    terminal = "foot";
    browser = "zen";
    fileManager = "thunar";
    appLauncher = "fuzzel";
    dmenu = "fuzzel --dmenu";
  };

  home.packages = with pkgs; [
    customPkgs.make-writable
    cryptsetup
    rmtrash
    trash-cli

    networkmanagerapplet

    # Desktop utilities
    file-roller
    gimp
    onlyoffice-desktopeditors
    pavucontrol

    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.twilight
    inputs.thorium-browser.defaultPackage.${pkgs.stdenv.hostPlatform.system}
    inkscape
    obsidian
    xournalpp
    zoom-us

    # Basic gaming
    wine
    winetricks
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
