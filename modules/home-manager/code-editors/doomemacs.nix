{
  lib,
  pkgs,
  config,
  inputs,
  ...
}:

let
  cfg = config.modules.editors.doomemacs;
  
  inherit (lib) mkEnableOption mkIf;
in {
  options.modules.editor.doomemacs = {
    enable = mkEnableOption "DOOOOOOOOM emacs :)";


  };

  config = mkIf cfg.enable {
    
  };
}