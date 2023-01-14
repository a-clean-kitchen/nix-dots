{ pkgs, ... }:

{
  programs = {
    bat = {
      enable = true;
      config = {
        theme = "Catppuccin-mocha";
      };
    };
  };
  xdg.configFile."bat/themes" = {
    recursive = true;
    source = ./themes;
  };
}