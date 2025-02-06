{
  lib,
  buildGoModule,
  discord-rpc,
  src,
  ...
}:
buildGoModule {
  pname = "mopidy-discord-rpc";
  version = "main";

  inherit src;
  vendorHash = "sha256-5wqD23x6rAdCOIRMphsFms9ijUpJHq4Gc3DHamh9Wvw=";

  buildInputs = [
    discord-rpc
  ];

  meta = with lib; {
    description = "Discord RPC for Mopidy.";
    homepage = "https://github.com/very-amused/mopidy-discord-rpc";
    license = licenses.unlicense;
  };
}
