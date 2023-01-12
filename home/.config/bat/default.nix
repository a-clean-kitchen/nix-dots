{ pkgs, ... }:

{
  programs = {
    bat = {
      enable = true;
      config = {
        theme = builtins.readFile ./themes/Catppuccin-mocha.tmTheme;
      };
    };
  };
  xdg.configFile."bat/themes" = {
    recursive = true;
    source = ./themes;
  };
}