{pkgs, ...}: {
  programs.librewolf = {
    enable = true;
    package = pkgs.librewolf-wayland;
    settings = {
      "identity.fxaccounts.enabled" = true;
    };
  };
}
