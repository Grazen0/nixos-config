{ config, lib, ... }:
rec {
  home.sessionVariables = {
    XDG_SESSION_TYPE = "wayland";
    QT_GPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    NIXOS_OZONE_WL = "1";
    BEMOJI_PICKER_CMD = config.meta.mainPrograms.dmenu;
    # idc, this is for a local server
    OBSIDIAN_REST_API_KEY = "fcaf7dede9cdedd5bbbb8e1d2889cf88974d7ed5340b1f225a01a50e8faa444e";
  };

  # Export home.sessionVariables from .config/uwsm/env
  xdg.configFile."uwsm/env".text =
    let
      inherit (lib) mapAttrsToList escapeShellArg concatStringsSep;

      lines = mapAttrsToList (key: value: "export ${key}=${escapeShellArg value}") home.sessionVariables;
    in
    concatStringsSep "\n" lines;
}
