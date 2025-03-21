{
  imports = [
    ./fish
    ./graphical
    ./music
    ./neovim
    ./bat.nix
    ./btop.nix
    ./cava.nix
    ./direnv.nix
    ./fastfetch.nix
    ./git.nix
    ./gowall.nix
    ./nom.nix
    ./peaclock.nix
    ./r.nix
    ./tmux.nix
    ./yazi.nix
    ./zsh.nix
  ];

  programs = {
    eza.enable = true;
    fd.enable = true;
    fzf.enable = true;
    lazygit = {
      enable = true;
      settings = {
        os.editPreset = "nvim-remote";
        gui = {
          border = "single";
          nerdFontsVersion = "3";
        };
      };
    };
    ripgrep.enable = true;
  };
}
