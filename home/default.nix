{ config, system, lib, pkgs, user, ... }:
let
  waybar = pkgs.waybar.overrideAttrs (o: {
    buildPhase = ''
    ${pkgs.tree}/bin/tree
      sed -i 's/zext_workspace_handle_v1_activate(workspace_handle_);/const std::string command = "hyprctl dispatch workspace " + name_;\n\tsystem(command.c_str());/g' src/modules/wlr/workspace_manager.cpp
      meson --prefix=/usr \
            --buildtype=debug \
            --auto-features=enabled \
            --wrap-mode=nodownload 
      meson configure -Dexperimental=true 
      ninja -C build
    '';
  });
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
      wofi dmenu
      xdg-desktop-portal-wlr
      tty-clock
      grim
      slurp
      
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
      iwgtk
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