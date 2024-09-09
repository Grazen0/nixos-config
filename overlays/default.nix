{inputs, ...}: {
  additions = final: _prev: import ../pkgs {inherit (final) pkgs;};

  modifications = final: prev: let
    overrideRofiUnwrapped = pkg:
      pkg.override {
        rofi-unwrapped = prev.rofi-wayland-unwrapped;
      };
  in {
    rofi-calc = overrideRofiUnwrapped prev.rofi-calc;
    rofi-emoji = overrideRofiUnwrapped prev.rofi-emoji;
  };

  stable-packages = final: _prev: {
    stable = import inputs.nixpkgs-stable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
