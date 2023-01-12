{ config, system, lib, pkgs, user, ... }:
let

in
{
  imports = (import ./.config);

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";

    packages = [
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
      # pkgs.swaylock
      pkgs.swaylock-effects
      pkgs.wl-clipboard
    ];

    stateVersion = "22.05";
  };

  programs = {
    home-manager.enable = true;
  };
}