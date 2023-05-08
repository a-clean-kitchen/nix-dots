# Shamelessly stolen from Henrik Lissner's dotfiles.
# They can be found at
# https://https://github.com/hlissner/dotfiles

{ lib, ... }:

let
  inherit (lib) mkOption types;
in
rec {
  mkOpt  = type: default:
    mkOption { inherit type default; };

  mkOpt' = type: default: description:
    mkOption { inherit type default description; };

  mkBoolOpt = default: mkOption {
    inherit default;
    type = types.bool;
    example = true;
  };
}
