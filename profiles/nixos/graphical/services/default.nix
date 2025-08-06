{ pkgs, ... }:
{
  imports = [ ./display-manager.nix ];

  services = {
    blueman.enable = true;
    libinput.enable = true;
    gvfs.enable = true;
    tumbler.enable = true;

    # Enable autodiscovery of network printers
    printing = {
      enable = true;
      drivers = with pkgs; [ epson-escpr ];
    };

    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      jack.enable = true;

      configPackages = [
        # Credit: https://discourse.nixos.org/t/pipewire-selects-msbc-by-default/46728
        (pkgs.writeTextDir "share/wireplumber/bluetooth.lua.d/51-bluez-config.lua" ''
          bluez_monitor.properties = {
            ["bluez5.enable-sbc-xq"] = true,
            ["bluez5.enable-msbc"] = true,
            ["bluez5.enable-hw-volume"] = true,
            ["bluez5.roles"] = "[ a2dp_sink a2dp_source bap_sink bap_source hsp_hs hsp_ag hfp_hf hfp_ag ]"
          }
        '')
      ];
    };
  };
}
