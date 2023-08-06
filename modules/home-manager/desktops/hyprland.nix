{
  lib,
  pkgs,
  config,
  inputs,
  ...
}:

let
  cfg = config.modules.desktop.hyprland;

  inherit (lib) mkEnableOption mkDefault mkIf;
  inherit (lib.lists) optional;
in {
  imports = [ inputs.hyprland.homeManagerModules.default ];
  #   ++ optional
  #     (config.wayland.windowManager ? hyprland)
  #     (builtins.getFlake "github:hyprland/hyprland").homeManagerModules.default;

  options.modules.desktop.hyprland = {
    enable = mkEnableOption "hyprland";

    styling = {
      
    };
    #
  };

  config = mkIf cfg.enable {

    xdg.configFile."hypr/hyprland.conf" = {};
  };


}