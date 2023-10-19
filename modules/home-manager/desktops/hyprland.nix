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
    _hypdConfig = ''
      # __/\\\________________________________________________________/\\\\\\____________________________________________/\\\__        
      #  _\/\\\_______________________________________________________\////\\\___________________________________________\/\\\__       
      #   _\/\\\_____________/\\\__/\\\____/\\\\\\\\\_____________________\/\\\___________________________________________\/\\\__      
      #    _\/\\\____________\//\\\/\\\____/\\\/////\\\___/\\/\\\\\\\______\/\\\______/\\\\\\\\\______/\\/\\\\\\___________\/\\\__     
      #     _\/\\\\\\\\\\______\//\\\\\____\/\\\\\\\\\\___\/\\\/////\\\_____\/\\\_____\////////\\\____\/\\\////\\\_____/\\\\\\\\\__    
      #      _\/\\\/////\\\______\//\\\_____\/\\\//////____\/\\\___\///______\/\\\_______/\\\\\\\\\\___\/\\\__\//\\\___/\\\////\\\__   
      #       _\/\\\___\/\\\___/\\_/\\\______\/\\\__________\/\\\_____________\/\\\______/\\\/////\\\___\/\\\___\/\\\__\/\\\__\/\\\__  
      #        _\/\\\___\/\\\__\//\\\\/_______\/\\\__________\/\\\___________/\\\\\\\\\__\//\\\\\\\\/\\__\/\\\___\/\\\__\//\\\\\\\/\\_ 
      #         _\///____\///____\////_________\///___________\///___________\/////////____\////////\//___\///____\///____\///////\//__
      # Generated in https://github.com/a-clean-kitchen/nix-dots/tree/main/modules/desktops/hyprland.nix

      source=




    '';
    xdg.configFile = {
      "hypr/hyprland.conf" = {};
      "hypr/mappings.conf" = {};
    };
    
  };


}