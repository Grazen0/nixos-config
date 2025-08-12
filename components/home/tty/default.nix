{ pkgs, inputs, ... }:
{
  wayland.windowManager.hyprland.enable = true;

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

  xdg.userDirs.enable = true;

  xdg.configFile."plates".source = ./plates-config;

  home.packages = with pkgs; [
    cargo
    cmake
    gcc
    gnumake
    nodejs
    pnpm
    python3
    rustc

    inputs.plates.packages.${pkgs.system}.default
    cloc
    github-cli
    lazydocker
    nitch
    pciutils
  ];

  meta.mainPrograms = {
    editor = "nvim";
    fileManagerCli = "yazi";
  };
}
