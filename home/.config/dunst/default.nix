{ pkgs, ... }:

{
  services.dunst = {
    enable = true;
    configFile = "${xdg.configHome}/dunst/dunstrc";
  };
}