{ pkgs, ... }:

{
  programs = {
    bat = {
      enable = true;
      config = {
        theme = "Catpuccin-mocha";
      };
    };
  };
  xdg.configFile."bat/themes" = {
    recursive = true;
    source = ./themes;
  };
}