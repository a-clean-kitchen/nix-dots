{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gnome.adwaita-icon-theme
    papirus-icon-theme
  ];

  services.dunst = {
    enable = true;
  };

  xdg.configFile."dunst/dunstrc".source = ./dunstrc;
}