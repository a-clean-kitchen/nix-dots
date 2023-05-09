{ self, config, lib, pkgs, ... }:

let
  inherit (lib) mapModulesRec';
in
{
  import = 
    [] ++ (mapModulesRec' (toString ./modules/home-manager) import);

  fonts.fontconfig.enable = true;

  programs = {
    direnv = {
      enable = true;
      enableFlakes = true;
    };
  };
}