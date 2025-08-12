{ pkgs, ... }:
{
  services.greetd = {
    settings.default_session = {
      command = ''
        ${pkgs.greetd.tuigreet}/bin/tuigreet \
          -r -t --asterisks --remember-user-session \
          -g "Hello there"
      '';
      user = "greeter";
    };
  };
}
