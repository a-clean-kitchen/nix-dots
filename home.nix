{ self, config, lib, pkgs, ... }:

let
  inherit (lib) mapModulesRec';
in
{
  import = 
    [] ++ (mapModulesRec' (toString ./modules/home-manager) import);

}