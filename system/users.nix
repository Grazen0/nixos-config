{
  programs.fish.enable = true;

  users.users.jdgt = {
    isNormalUser = true;
    extraGroups = ["wheel" "audio" "networkmanager"];
  };
}
