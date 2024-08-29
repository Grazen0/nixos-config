{inputs, ...}: {
  imports = [
    inputs.base16.nixosModule
  ];

  scheme = "${inputs.tt-schemes}/base16/nord.yml";
}
