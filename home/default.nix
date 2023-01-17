{ config, doom-emacs, system, lib, pkgs, user, ... }:
let
  waybar = pkgs.waybar.overrideAttrs (o: {
    mesonFlags = o.mesonFlags ++ [ "-Dexperimental=true" ];
  });
in {
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
      tty-clock
      grim
      slurp
      wlroots wlr-randr
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
      # doom-emacs
      ripgrep coreutils fd

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

 home.file.".doom.d" = {                       # Get Doom Emacs
   source = ./.doom.d;                          # Sets up symlink name ".doom.d" for file "doom.d"
   recursive = true;                           # Allow symlinking a directory
   onChange = builtins.readFile ./doom.sh;     # If an edit is detected, it will run this script. Pretty much the same as what is now in default.nix but actually stating the terminal and adding the disown flag to it won't time out
 };

 programs = {
   emacs.enable = true;                        # Get Emacs
 };

}
