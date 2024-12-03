{pkgs, ...}: {
  programs.zsh.enable = true;

  users.users.jdgt = {
    isNormalUser = true;
    extraGroups = ["wheel" "audio" "networkmanager"];
    shell = pkgs.zsh;
  };
}
