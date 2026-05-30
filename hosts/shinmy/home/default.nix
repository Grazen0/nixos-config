{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ../../../options/common
    ../../../options/home-manager

    ../../../configs/home/programs/git

    ../../../components/home/base

    ./neovim
    ./tmux.nix

  ];

  programs.bash = {
    enable = true;
    shellAliases = {
      v = "nvim";
      vs = "nvim -S";
    };
  };

  home.packages = with pkgs; [
    nodejs
    pnpm
    ngrok
    jq
  ];

  programs.java.enable = true;

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      "*" = {
        AddKeysToAgent = "yes";
        ForwardAgent = true;
      };

      "github.com" = {
        IdentitiesOnly = true;
        IdentityFile = "~/.ssh/github_auth_id_ed25519";
      };
      "gitlab.com" = {
        IdentitiesOnly = true;
        IdentityFile = "~/.ssh/gitlab_auth_id_ed25519";
      };
      "codeberg.org" = {
        IdentitiesOnly = true;
        IdentityFile = "~/.ssh/codeberg_auth_id_ed25519";
      };
    };
  };

  services.ssh-agent.enable = true;

  programs.kitty.enable = true; # To use xterm-kitty
  programs.fastfetch.enable = true;
  programs.htop.enable = true;
  programs.lazygit.enable = true;

  programs.btop = {
    enable = true;

    settings = {
      color_theme = "TTY";
      theme_background = false;
      vim_keys = true;
    };
  };

  home.stateVersion = "24.05";
}
