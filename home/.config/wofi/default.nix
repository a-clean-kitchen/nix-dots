{ pkgs, ... }:

{
  xdg.configFile."wofi/config".source = ./config;
  xdg.configFile."wofi/style.css".source = ./style.css;
  xdg.configFile."wofi/menu.css".source = ./menu.css;
  xdg.configFile."wofi/menu".source = ./menu;
}