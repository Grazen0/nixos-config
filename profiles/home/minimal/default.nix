{config, ...}: {
  imports = [
    ./git.nix
  ];

  home = {
    username = config.meta.mainUser;
    homeDirectory = "/home/${config.home.username}";
  };

  meta.mainPrograms = let
    inherit (config) programs;
  in {
    editor = "${programs.neovim.finalPackage}/bin/nvim";
    fileManagerCli = "${programs.yazi.package}/bin/yazi";
  };

  programs = {
    fd.enable = true;
    ripgrep.enable = true;
  };

  xdg.configFile."nixpkgs/config.nix".source = ./nixpkgs-config.nix;
}
