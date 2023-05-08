{
  lib,
  pkgs,
  config,
  ...
}:

# This module sets up spotify and spicetify

let
  cfg = config.modules.gui-spotify-combo;

in {}