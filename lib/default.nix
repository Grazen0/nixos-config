{
  lib,
  inputs,
  ...
} @ moduleArgs: let
  lib' = let
    fullArgs = moduleArgs // {inherit lib';};
    math = import ./math.nix fullArgs;
    strings = import ./strings.nix fullArgs;
    river = import ./river.nix fullArgs;
    builders = import ./builders.nix fullArgs;
  in
    math
    // strings
    // builders
    // {inherit math strings river builders;};
in
  lib'
