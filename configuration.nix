{
  lib,
  config,
  pkgs,
  ...
}:

let
  inherit (lib.ql) mapModulesRec';
in {
  import =
    [] ++ (mapModulesRec' (toString ./modules/nixos) import);
}