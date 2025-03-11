{
  pkgs,
  customPkgs,
  ...
}: {
  home.packages = with pkgs; [
    customPkgs.exe2png
    customPkgs.make-writable
    file
    fcp
    lsof
    cmatrix
    nitch
    rmtrash
    trash-cli
    man-pages
    man-pages-posix
  ];
}
