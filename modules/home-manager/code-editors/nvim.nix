{
  lib,
  pkgs,
  config,
  inputs,
  ...
}:

let
  cfg = config.modules.editors.neovim;

  inherit (lib) mkEnableOption mkIf;
in {
  options.modules.editors.neovim = {
    enable = mkEnableOption "neovim";
  };

  config = mkIf cfg.enable {
    
  };
}