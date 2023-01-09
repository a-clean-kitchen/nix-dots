{ pkgs, ... }:

{
  xdg.configFile."hypr/components/waybar" = {
    source = ./waybar;
    recursive = true;
  };
}
