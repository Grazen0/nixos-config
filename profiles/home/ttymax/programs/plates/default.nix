{
  pkgs,
  inputs,
  ...
}: {
  home.packages = [inputs.plates.packages.${pkgs.system}.default];

  xdg.configFile."plates".source = ./config;
}
