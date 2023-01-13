{ config, system, lib, pkgs, user, ... }:
let

in
{
  imports = (import ./.config);

  home = {
    username = "${user}";
    homeDirectory = "/home/${user}";

    packages = with pkgs; [
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
      neofetch
      polkit_gnome
      papirus-icon-theme
      gnome.adwaita-icon-theme
      # Dependenccies for youtube-tui
      mpv yt-dlp ffmpeg
      
      firefox
      zathura
      networkmanager_dmenu
    ];
    sessionVariables = {
      XDH_RUNTIME_DIR = "/run/user/$UID";
    };
    stateVersion = "22.05";
  };

  programs = {
    home-manager.enable = true;
  };
}