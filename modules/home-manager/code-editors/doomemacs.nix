{
  lib,
  pkgs,
  config,
  inputs,
  ...
}:
# Gonna put this guy on hold since I'm starting to think that
# emacs is a bit too much for my use case

let
  cfg = config.modules.editors.doomemacs;

  inherit (lib) mkEnableOption mkIf;
in {
  imports = [];

  options.modules.editor.doomemacs = {
    enable = mkEnableOption "DOOOOOOOOM emacs :)";
  };

  config = mkIf cfg.enable {
    nixpkgs.overlays = [ inputs.emacs-overlay.overlay ];

    home.packages = with pkgs; [
      ## Emacs itself
      binutils       # native-comp needs 'as', provided by this
      # 28.2 + native-comp
      ((emacsPackagesFor emacsNativeComp).emacsWithPackages
        (epkgs: [ epkgs.vterm ]))

      ## Doom dependencies
      git
      (ripgrep.override {withPCRE2 = true;})
      gnutls              # for TLS connectivity

      ## Optional dependencies
      fd                  # faster projectile indexing
      imagemagick         # for image-dired
    ];
  };
}