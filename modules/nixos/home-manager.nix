{
  host,
  inputs,
  outputs,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    users.jdgt = import ../../hosts/${host}/home-manager/home.nix;

    extraSpecialArgs = {inherit host inputs outputs;};
  };
}
