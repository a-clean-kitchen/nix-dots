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

  xdg.configFile."hypr/component/waybar" = {
    source = ./component/waybar;
    recursive = true;
  };

  imports = [
    ./scripts.nix
    ./component
  ];

}