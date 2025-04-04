{
  imports = [
    ./fish
    ./neovim
    ./plates
    ./bat.nix
    ./btop.nix
    ./cava.nix
    ./direnv.nix
    ./fastfetch.nix
    ./gowall.nix
    ./nom.nix
    ./peaclock.nix
    ./r.nix
    ./ssh.nix
    ./tmux.nix
    ./yazi.nix
    ./zsh.nix
  ];

  programs = {
    eza.enable = true;
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
  };
}
