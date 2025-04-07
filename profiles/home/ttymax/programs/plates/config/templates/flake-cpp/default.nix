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
    runHook preInstall
    install -Dm755 "build/{{ executable }}" -t "$out/bin"
    runHook postInstall
  '';

  # meta = with lib; {
  #   description = "{{ description }}";
  #   homepage = "https://github.com/<user>/<repo>";
  #   license = licenses.mit;
  # };
}
