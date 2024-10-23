{pkgs, ...}: {
  services = {
    pipewire = {
      enable = true;
      alsa.enable = false;
      pulse.enable = false;
    };
    printing.enable = false;
    libinput.enable = true;
    blueman.enable = true;
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
            --cmd "zsh --login -c Hyprland"
        '';
        user = "greeter";
      };
    };
  };
}
