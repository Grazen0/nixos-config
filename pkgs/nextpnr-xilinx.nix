{
  src,
  stdenv,

  cmake,
  boost,
  python3,
  eigen,
}:

stdenv.mkDerivation {
  pname = "nextpnr-xilinx";
  version = "xilinx-upstream";

  inherit src;

  nativeBuildInputs = [
    cmake
    python3
    boost
    eigen
  ];

  cmakeFlags = [
    "-DARCH=xilinx"
  ];
}
