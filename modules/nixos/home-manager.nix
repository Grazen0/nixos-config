{
  username,
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

    users.${username} = import ../../hosts/${host}/home-manager/home.nix;

    extraSpecialArgs = {inherit username host inputs outputs;};
  };
}
