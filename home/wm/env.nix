{config, ...}: {
  xdg.configFile."uwsm/env".text =
    # bash
    ''
      export XDG_SESSION_TYPE="wayland"
      export QT_GPA_PLATFORM="wayland"
      export NIXOS_OZONE_WL="1"
      export BEMOJI_PICKER_CMD="${config.mainPrograms.dmenu}"
      # idc, this is for a local server
      export OBSIDIAN_REST_API_KEY="fcaf7dede9cdedd5bbbb8e1d2889cf88974d7ed5340b1f225a01a50e8faa444e"
    '';
}
