{ pkgs, ... }:

{
  xdg.configFile."hypr/hyperland.conf" = {
    source = ./hyperland.conf;
  };

  xdg.configFile."hypr/autostart" = {
    text = ''
      #!/usr/bin/bash

      # variables
      config=${xdg.configHome}/hypr
      scripts=$config/scripts

      # notification daemon
      dunst &

      # waybar
      $scripts/launch_waybar &
      $scripts/tools/dynamic &

      # wallpaper
      $scripts/wall $config/wallpapers/cloud.png &

      # effects
      $scripts/rgb &

      # other
      /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
      dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP &
    '';
    executable = true;
  };
}