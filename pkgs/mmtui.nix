{
  lib,
  rustPlatform,
  linuxHeaders,
  libclang,
  src,
}:
rustPlatform.buildRustPackage {
  pname = "mmtui";
  version = "master";

  inherit src;

  cargoHash = "sha256-9F1YMepkWksTQRrkziNhLxVJnhoDH17lSKef5kOjp3Y=";
  useFetchCargoVendor = true;

  # Needed to compile loopdev
  C_INCLUDE_PATH = "${linuxHeaders}/include";
  LIBCLANG_PATH = "${libclang.lib}/lib";

  meta = with lib; {
    description = "TUI disk mount manager for TUI file managers";
    homepage = "https://github.com/SL-RU/mmtui";
    license = licenses.mit;
  };
}
