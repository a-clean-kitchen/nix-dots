{ pkgs, ... }:

let
  inherit (builtins) fromJSON readFile;
in
{
  programs.waybar = {
    enable = true;
    settings = fromJSON (readFile ./waybar/config);
    style = (import ./waybar/style.css);
  };
}
