{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    prismlauncher # Minecraft
    osu-lazer

    socat
  ];
}
