{ pkgs, ... }:

{
  home.packages = with pkgs; [
    wlroots
    wlr-randr
    wl-clipboard
    swaylock-effects
    polkit_gnome
    iwgtk
    grim slurp
    tty-clock
  ];

  xdg.configFile."hypr/hyprland.conf" = {
    source = ./hyprland.conf;
  };

  xdg.configFile."hypr/autostart" = {
    source = ./autostart;
    executable = true;
  };

  xdg.configFile."hypr/wallpapers" = {
    source = ./wallpapers;
    recursive = true;
  };

  xdg.configFile."hypr/component/waybar" = {
    source = ./component/waybar;
    recursive = true;
  };

  imports = [
    ./scripts.nix
    # ./component
  ];

}