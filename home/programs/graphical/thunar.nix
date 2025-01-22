{config, ...}: {
  # Thunar is already enabled in the system configuration,
  # though it'd be cool if it could be enable per-user

  xdg.configFile."xfce4/helpers.rc".text =
    # toml
    ''
      TerminalEmulator=${config.programs.kitty.package}/bin/kitty
    '';
}
