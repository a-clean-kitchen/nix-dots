{ pkgs, ... }:

{
  services.dunst = {
    enable = true;
    configFile = "${config.xdg.configHome}/dunst/dunstrc";
  };
}