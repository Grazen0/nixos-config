{...}: rec {
  sum = builtins.foldl' builtins.add 0;

  pow = base: exp:
    if exp == 0
    then 1
    else if exp < 0
    then 1 / pow base (-exp)
    else base * (pow base (exp - 1));

  base16To10 = exponent: scalar: scalar * pow 16 exponent;
}
