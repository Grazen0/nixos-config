{
  stdenvNoCC,
  fetchzip,
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "kotlin-lsp";
  version = "v0.253.10629";

  src = fetchzip {
    url = "https://download-cdn.jetbrains.com/kotlin-lsp/0.253.10629/kotlin-0.253.10629.zip";
    hash = "sha256-LCLGo3Q8/4TYI7z50UdXAbtPNgzFYtmUY/kzo2JCln0=";
    stripRoot = false;
  };

  installPhase = ''
    mkdir -p "$out/share"
    cp -r . "$out/share"


    mkdir -p $out/bin

    cat > $out/bin/kotlin-lsp <<EOF
    #!/bin/sh
    cd "$out/share"
    exec ./kotlin-lsp.sh "\$@"
    EOF

    chmod +x "$out/bin/kotlin-lsp"
    chmod +x "$out/share/kotlin-lsp.sh"
  '';
})
