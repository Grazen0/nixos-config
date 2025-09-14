{ lib, lib', ... }:
rec {
  tagNum = n: lib'.pow 2 (n - 1);
  tagNumStr = n: toString (tagNum n);

  spawn = exec: "spawn ${lib.escapeShellArg exec}";
}
