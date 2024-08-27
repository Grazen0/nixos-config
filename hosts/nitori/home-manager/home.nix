{outputs, ...}: {
  imports = [
    outputs.homeManagerModules
    ./modules
  ];
}
