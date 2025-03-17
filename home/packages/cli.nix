{
  pkgs,
  customPkgs,
  ...
}: {
  home.packages = with pkgs; [
    customPkgs.make-writable
    file
    fcp
    pciutils
    cryptsetup
    lsof
    cmatrix
    nitch
    rmtrash
    trash-cli
    man-pages
    man-pages-posix
  ];
}
