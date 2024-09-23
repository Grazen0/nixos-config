{inputs, ...}: {
  additions = final: _prev: import ../pkgs {inherit (final) pkgs;};

  modifications = final: prev: {
    rofi-calc = prev.rofi-calc.override {
      rofi-unwrapped = prev.rofi-wayland-unwrapped;
    };
  };

  stable-packages = final: _prev: {
    stable = import inputs.nixpkgs-stable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
