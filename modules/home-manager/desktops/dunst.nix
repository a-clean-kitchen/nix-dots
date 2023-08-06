{
  lib,
  pkgs,
  config,
  ...
}:

let
  cfg = config.modules.desktop.dunst;

  eitherStrBoolIntList = with lib.types;
    either str (either bool (either int (listOf str)));

  inherit (lib) mkEnableOption;
in {

}