#
#  Hyprland NixOS & Home manager configuration
#
#  flake.nix
#   ├─ ./hosts
#   │   └─ ./laptop
#   │       └─ home.nix
#   └─ ./modules
#       └─ ./desktop
#           └─ ./hyprland
#               └─ home.nix *
#

{ config, lib, pkgs, ... }:

{
  home.file = {
    ".config/hypr/hyprland.conf" = {
      source = ./hyprland.conf;
      target = ".config/hypr/hyprland.conf";
    };
    ".config/hypr/autostart" = {
      source = ./autostart;
      target = ".config/hypr/autostart";
      executable = true;
    };
    ".config/hypr/wallpapers" = {
      source = ./wallpapers;
      target = ".config/hypr/wallpapers";
      recursive = true;
    };
    ".config/hypr/scripts" = {
      source = ./scripts;
      target = ".config/hypr/scripts";
      recursive = true;
      executable = true;
    };
  };
}
