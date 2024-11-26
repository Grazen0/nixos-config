{inputs, ...}: {
  additions = final: _prev: let
    inherit (final) pkgs;
    inherit (pkgs) system;
  in
    import ../pkgs {inherit pkgs;}
    // {
      thorium-browser = inputs.thorium-browser.defaultPackage.${system};

      zen-browser = inputs.zen-browser.packages.${system}.specific.overrideAttrs (prev: let
        version = "1.0.1-a.19";
      in {
        inherit version;
        src = builtins.fetchTarball {
          url = "https://github.com/zen-browser/desktop/releases/download/${version}/zen.linux-specific.tar.bz2";
          sha256 = "sha256:1g7nq1yfaya97m43vnkjj1nd9g570viy8hj45c523hcyr1z92rjq";
        };
      });
    };

  modifications = final: prev: {
    rofi-calc = prev.rofi-calc.override {
      rofi-unwrapped = prev.rofi-wayland-unwrapped;
    };

    vimPlugins =
      prev.vimPlugins
      // {
        multicursor-nvim = prev.vimUtils.buildVimPlugin {
          name = "multicursor-nvim";
          src = inputs.nvim-plugin-multicursor;
        };

        live-share-nvim = prev.vimUtils.buildVimPlugin {
          name = "live-share-nvim";
          src = inputs.nvim-plugin-live-share;
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
