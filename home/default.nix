{ config, lib, pkgs, user, rgb, swww, ... }:
let

in
{
  imports = (import ./.config);

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";

    packages = [
      # Forbidden technique
      swww
      rgb

      pkgs.waybar
      pkgs.cava
      pkgs.kitty
      pkgs.fish
      pkgs.wofi
      pkgs.xdg-desktop-portal-wlr
      pkgs.tty-clock
      pkgs.grim
      pkgs.slurp
      pkgs.starship
      pkgs.dunst
      # swaylock
      pkgs.swaylock-effects
      pkgs.wl-clipboard
    ];

    stateVersion = "22.05";
  };

  programs = {
    home-manager.enable = true;
  };
}