{pkgs ? import <nixpkgs> {}, ...}: {
  handle-monitor-connect = pkgs.callPackage ./handle-monitor-connect {};
}
