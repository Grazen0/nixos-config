{
  writeShellApplication,
  bc,
  ...
}:
writeShellApplication {
  name = "roundn";
  runtimeInputs = [bc];
  text = ''
    snap="$1"
    value="$2"
    echo "$(( snap * $( printf '%.f' "$( bc -l <<< "$value / $snap" )" ) ))"
  '';
}
