{
  pkgs,
  customPkgs,
  ...
}: {
  home.packages = with pkgs; [
    customPkgs.exe2png
    customPkgs.make-writable
    file
    cmatrix
    nitch
    rmtrash
    trash-cli
  ];
}
