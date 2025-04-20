{ lib, lib', ... }:
let
  inherit (lib) head splitString concatStringsSep;
in
rec {
  tagNum = n: lib'.pow 2 (n - 1);
  tagNumStr = n: toString (tagNum n);

  spawn = exec: "spawn ${lib.escapeShellArg exec}";

  withRulesLines =
    rule: actions: exec:
    let
      ruleAdds = map (action: "riverctl rule-add ${rule} ${action}") actions;
      ruleDels = map (action: "riverctl rule-del ${rule} ${head (splitString " " action)}") actions;
    in
    ruleAdds ++ [ exec ] ++ ruleDels;

  withRules =
    rule: actions: exec:
    concatStringsSep "; " (withRulesLines rule actions exec);
}
