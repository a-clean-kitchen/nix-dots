{ pkgs, ... }:

{
  programs = {
    bat = {
      enable = true;
    };
  };
  xdg.configFile."bat/themes" = {
    recursive = true;
    source = ./themes;
  };
}