{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
  };
  xdg.configFile."fish/completions" = {
    recursive = true;
    source = ./completions;
  };
  xdg.configFile."fish/conf.d" = {
    recursive = true;
    source = ./conf.d;
  };
  xdg.configFile."fish/functions" = {
    recursive = true;
    source = ./functions;
  };
  xdg.configFile."fish/config.fish".source = ./config.fish;
  xdg.configFile."fish/fish_variables".source = ./fish_variables;
  xdg.configFile."fish/fish_plugins".source = ./fish_plugins;
  xdg.configFile."fish/tty.sh" = {
    source = ./tty.sh;
    executable = true;
  }
}