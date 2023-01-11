{ config, lib, pkgs, user, rgb, swww, ... }:
let

in
{
  imports = (import ./.config);

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";

    packages = with pkgs; [
      # # They're in.
      # rgb.packages.x86_64-linux
      # swww.packages.x86_64-linux

      waybar
      cava
      kitty
      fish
      wofi
      xdg-desktop-portal-wlr
      tty-clock
      grim
      slurp
      starship
      dunst
      # swaylock
      swaylock-effects
      wl-clipboard
    ];

    packages = [
      # ???
      swww
      rgb
    ];
    stateVersion = "22.05";
  };

  programs = {
    home-manager.enable = true;
  };
}