{inputs, ...}: {
  additions = final: _prev: import ../pkgs {inherit (final) pkgs;};

  modifications = final: prev: {
    rofi-calc = prev.rofi-calc.override {
      rofi-unwrapped = prev.rofi-wayland-unwrapped;
    };

    vimPlugins =
      prev.vimPlugins
      // {
        multicursor-nvim = prev.vimUtils.buildVimPlugin {
          name = "multicursor-nvim";
          src = inputs.plugin-multicursor-nvim;
        };

        live-share-nvim = prev.vimUtils.buildVimPlugin {
          name = "live-share-nvim";
          src = inputs.plugin-live-share-nvim;
        };
      };
  };

  stable-packages = final: _prev: {
    stable = import inputs.nixpkgs-stable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
