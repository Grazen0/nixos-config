{pkgs, ...}: {
  services = {
    pipewire = {
      enable = true;
      alsa.enable = false;
      pulse.enable = false;
    };
    printing.enable = false;
    libinput.enable = true;
    gvfs.enable = true;
    tumbler.enable = true;

    greetd = {
      enable = true;
      settings.default_session = {
        command = ''
          ${pkgs.greetd.tuigreet}/bin/tuigreet \
            --asterisks \
            --remember \
            --time \
            --greeting "Hello there" \
            --window-padding 2 \
            --cmd "bash -l -c Hyprland"
        '';
        user = "greeter";
      };
    };
  };
}
