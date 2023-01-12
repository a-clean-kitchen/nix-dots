{ pkgs, ... }:

{
  xdg.configFile."hypr/hyprland.conf" = {
    source = ./hyprland.conf;
  };

  xdg.configFile."hypr/autostart" = {
    text = ''
      #! /usr/bin/env nix-shell
      #! nix-shell -i bash

      # variables
      config=~/.config/hypr
      scripts=$config/scripts

      # notification daemon
      dunst &

      # waybar
      $scripts/launch_waybar &
      $scripts/tools/dynamic &

      # wallpaper
      $scripts/wall $config/wallpapers/cloud.png &

      # effects
      # Keeping this down until I turn rgb-rs into a flake
      $scripts/pre-built/rgb &

      # other
      /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
      dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP &
    '';
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