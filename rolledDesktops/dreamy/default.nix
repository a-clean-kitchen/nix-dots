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

  modules = {
    desktop = {
      hyprland = {
        enable = true;
      };
    };
    cli ={
      bat = {
        enable = true;
        config = {
          theme = "Catpuccin-mocha";
        };
        themes = {
          Catppuccin-mocha = builtins.readFile (
            pkgs.fetchFromGitHub {
              owner = "catppuccin";
              repo = "bat";
              rev = "ba4d16880d63e656acced2b7d4e034e4a93f74b1";
              sha256 = "";
            } + "/Catppuccin-mocha.tmTheme"
          );
        };
      };
      btop = {
        enable = true;
        themePath = (pkgs.fetchFromGitHub {
            owner = "catppuccin";
            repo = "btop";
            rev = "v1.0.0";
            sha256 = "";
          } + "/themes/catppuccin_mocha.theme");
      };
    };
  };
}
