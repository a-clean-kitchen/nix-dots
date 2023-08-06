{ pkgs, config, ... }:

let
  inherit (builtins) fromJSON readFile;
  cfg = config.programs.waybar;
in
{
  programs.waybar = {
    enable = true;
    settings = fromJSON (readFile ./waybar/config);
    style = (import ./waybar/style.css);
  };
}