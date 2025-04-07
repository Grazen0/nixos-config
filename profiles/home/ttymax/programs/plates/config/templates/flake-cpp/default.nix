{
  lib,
  stdenv,
  cmake,
  ...
}:
stdenv.mkDerivation {
  pname = "{{ pname }}";
  version = "{{ version }}";

  src = lib.cleanSource ./.;

  nativeBuildInputs = [cmake];

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
  ];

  buildPhase = ''
    cmake . -B build $cmakeFlags
    cmake --build build
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp build/{{ executable }} $out/bin/
  '';

  # meta = with lib; {
  #   description = "{{ description }}";
  #   homepage = "https://github.com/<user>/<repo>";
  #   license = licenses.mit;
  # };
}
