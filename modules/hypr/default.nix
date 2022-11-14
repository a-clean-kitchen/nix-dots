
{ config, lib, pkgs, ... }:

{
  imports = [ ../waybar ];

  hardware.opengl.enable = true;

  environment = {
    loginShellInit = ''
      if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
        exec Hyprland
      fi
    '';                                   # Will automatically open Hyprland when logged into tty1
    systemPackages = with pkgs; [
      xdg-desktop-portal-wlr
      polkit_gnome
    ];
  };

  programs = {
    hyprland.enable = true;
  };

  xdg.portal = {                                  # Required for flatpak with windowmanagers
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
}
