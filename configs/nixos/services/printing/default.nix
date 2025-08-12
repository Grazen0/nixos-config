{ pkgs, ... }:
{
  services.printing = {
    drivers = with pkgs; [ epson-escpr ];
  };
}
