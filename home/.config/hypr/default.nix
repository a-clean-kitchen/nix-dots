{ pkgs, ... }:

{
  xdg.configFile."hypr/hyprland.conf" = {
    source = ./hyprland.conf;
  };

  xdg.configFile."hypr/autostart" = {
    source = ./autostart;
    executable = true;
  };

  xdg.configFile."hypr/wallpapers" = {
    source = ./wallpapers;
    recursive = true;
  };

  imports = [
    ./scripts.nix
    ./component
  ];

}