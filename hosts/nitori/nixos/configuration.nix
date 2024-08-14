{hardware, ...}: {
  imports = [
    hardware.common-gpu-intel
    ./modules
  ];
}
