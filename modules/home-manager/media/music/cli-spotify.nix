{
  lib,
  pkgs,
  config,
  ...
}:

# This module sets up spotify-tui and spotifyd

let
  cfg = config.modules.cli-spotify-combo;

  tomlFormat = pkgs.formats.tom { };
  yamlFormat = pkgs.formats.yaml { };

  tuiConfigFile = yamlFormat.generate "config.yml" cfg.tui.settings;

  inherit (lib) mkIf mkOption mkEnableOption mkPackageOption types toString;
in {
  options.programs.cli-spotify-combo = {
    enable = mkEnableOption "Spotify CLI combo (tui and daemon)";

    tui = {
      package = mkPackageOption {
        type = types.package;
        default = pkgs.spotify-tui;
        description = "The spotify-tui package to use";
      };

      settings = mkOption {
        type = yamlFormat.type;
        default = { };
        description = "Settings to pass to spotify-tui";
      };
    };

    daemon = {
      package = mkPackageOption {
        type = types.package;
        default = pkgs.spotifyd.override {
          withPulseAudio = true;
          withKeyring = true;
        };
        description = "The spotifyd package to use";
      };

      settings = mkOption {
        type = tomlFormat.type;
        default = { };
        description = "Settings to pass to spotifyd";
      };
    };
  };

  config = mkIf cfg.enable {

    home.packages = [ cfg.tui.package cfg.daemon.package ];

    xdg.configFile."spotify-tui/config.yml".source = tuiConfigFile;

    systemd.user.services.spotifyd = {
      Install.WantedBy = [ "default.target" ];
      description = "spotifyd, a Spotify playing daemon";
      environment.SHELL = "${pkgs.bash}";
      serviceConfig = {
        ExecStart = "${cfg.daemon.package}/bin/spotifyd --no-daemon --cache-path ${config.xdg.cacheHome} --config-path ${cfg.daemon.settings}";
        Restart = "always";
        RestartSec = 12;
        CacheDirectory = "spotifyd";
      };
    };
  };
}