{ pkgs, stablePkgs, ... }:
{
  programs.fastfetch.enable = true;
  programs.fish.enable = true;
  programs.neovim.enable = true;
  programs.bat.enable = true;
  programs.btop.enable = true;
  programs.eza.enable = true;
  programs.fzf.enable = true;
  programs.lazygit.enable = true;
  programs.java.enable = true;
  programs.direnv.enable = true;
  programs.ssh.enable = true;
  programs.tmux.enable = true;
  programs.yazi.enable = true;
  programs.zoxide.enable = true;

  xdg.userDirs.enable = true;

  home.packages = with pkgs; [
    stablePkgs.gtkwave
    cargo
    clippy
    cmake
    meson
    ninja
    gcc
    gdb
    (haskellPackages.ghcWithPackages (ps: with ps; [ cabal-install ]))
    gnumake
    nodejs
    pnpm
    (python3.withPackages (
      ps: with ps; [
        numpy
        matplotlib
        locust
      ]
    ))
    rustc

    cloc
    github-cli
    lazydocker
    nitch
    pciutils
    qrencode
    valgrind
    xxd
  ];

  meta.mainPrograms = {
    editor = "nvim";
    fileManagerCli = "yazi";
  };
}
