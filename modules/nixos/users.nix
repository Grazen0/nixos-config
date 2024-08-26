{pkgs, ...}: {
  users = {
    defaultUserShell = pkgs.zsh;

    users.jdgt = {
      isNormalUser = true;
      extraGroups = ["wheel" "audio" "networkmanager"];
    };
  };
}
