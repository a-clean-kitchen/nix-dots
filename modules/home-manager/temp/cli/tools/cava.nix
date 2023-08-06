{
  lib,
  pkgs,
  config,
  ...
}:
# Wait until spotify is fully configured before getting this guy live
let
  cfg = config.modules.cli.tools.cava;

  tomlFormat = pkgs.formats.toml { };

  inherit (lib) mkIf mkEnableOption mkOption;
in {
  options.modules.cli.tools.cava = {
    enable = mkEnableOption "cava";

    settings = mkOption {
      type = tomlFormat.type;
      default = {};
    };
  };

  config = mkIf cfg.enable {

  };
}