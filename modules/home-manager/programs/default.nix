{config, ...}: {
  imports = [
    ./neovim
    ./vesktop
    ./bat.nix
    ./btop.nix
    ./cava.nix
    ./direnv.nix
    ./fastfetch.nix
    ./foot.nix
    ./git.nix
    ./idea.nix
    ./mpv.nix
    ./peaclock.nix
    ./spicetify.nix
    ./swayimg.nix
    ./tmux.nix
    ./yazi.nix
    ./zapzap.nix
    ./zathura.nix
  ];

  programs = {
    broot.enable = true;
    eza.enable = true;
    obs-studio.enable = true;
    lazygit.enable = true;

    # TODO: refactor everything as it should go
    swayimg = {
      enable = true;

      settings = let
        colors = config.theme.colors.hex;
      in {
        viewer = {
          window = colors.background;
          antialiasing = "yes";
        };

        gallery = {
          window = colors.background;
          antialiasing = "yes";
        };

        font = {
          name = "JetBrainsMonoNL Nerd Font";
          size = 18;
          color = colors.brightWhite;
          shadow = colors.black;
        };

        info.show = "no";

        "keys.viewer" = {
          p = "prev_file";
          n = "next_file";

          g = "first_file";
          "Shift+g" = "last_file";

          h = "step_left 10";
          j = "step_down 10";
          k = "step_up 10";
          l = "step_right 10";

          "Shift+j" = "zoom -10";
          "Shift+k" = "zoom +10";
        };

        "keys.gallery" = {
          g = "first_file";
          "Shift+g" = "last_file";

          h = "step_left";
          j = "step_down";
          k = "step_up";
          l = "step_right";

          "Shift+j" = "page_down";
          "Shift+k" = "page_up";
        };
      };
    };
  };
}
