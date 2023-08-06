{
  lib,
  pkgs,
  config,
  ...
}:
# okay so this is just pulling bat into scope for my personal modules.
# for all intents and purposes, this module file is NOT necessary.
let
  cfg = config.modules.cli.tools.bat;

  inherit (lib) mkEnableOption mkOption mkIf types;
in {
  options.modules.cli.tools.bat = {
    enable = mkEnableOption "bat";

    config = mkOption {
      type = with types; attrsOf (either str (listOf str));
      default = { };
      description = ''
        Bat configuration.
      '';
    };

    extraPackages = mkOption {
      type = types.listOf types.package;
      default = [ ];
      description = ''
        Additional bat packages to install.
      '';
    };


    themes = mkOption {
      type = types.attrsOf types.lines;
      default = { };
      description = ''
        Additional themes to provide.
      '';
    };
  };

  config = mkIf cfg.enable {
    programs.bat = {
      enable = cfg.enable;
      config = cfg.config;
      extraPackages = cfg.extraPackages;
      themes = cfg.themes;
    };
  };
}