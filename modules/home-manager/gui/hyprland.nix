{
  lib,
  pkgs,
  config,
  ...
}:

let
  cfg = config.modules.desktop.hyprland;

  inherit (lib) mkEnableOption mkDefault mkIf;
  inherit (lib.lists) optional;
in {
  # imports = []
  #   ++ optional
  #     (config.wayland.windowManager ? hyprland)
  #     (builtins.getFlake "github:hyprland/hyprland").homeManagerModules.default;

  options.modules.desktop.hyprland = {
    enable = mkEnableOption "hyprland";


  };

  config = mkIf cfg.enable {

    xdg.configFile."hypr/hyprland.conf" = {};
  };


}