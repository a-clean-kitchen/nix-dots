{
  self,
  lib,
  pkgs,
  config,
  ...
}:

let
  inherit (lib) mapAttrsToList;
  inherit (lib.ql) mapModulesRec';
in {
  imports = [] ++ (mapModulesRec'
    (toString ../../modules/home-manager)
    import
  );

  modules.desktop.hyprland = {
    enable = true;
  };
}