{
  description = "A very basic flake";
  
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    doom-emacs = {
      url = "github:nix-community/nix-doom-emacs";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.emacs-overlay.follows = "emacs-overlay";
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs @ { self, flake-parts, nixpkgs, nur, home-manager, emacs-overlay, doom-emacs, hyprland, ... }:
    let
      user = "qm";

      #Extend lib with personal functions
      lib = nixpkgs.lib.extend
        (self: super: { ql = import ./lib { inherit pkgs inputs; lib = self; }; });

      inherit (lib.ql) mapModules mapModulesRec mapHosts mapModulesArgd;

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in flake-parts.lib.mkFlake { inherit inputs; } {
      flake  = {
        # keep lib/ functions in scope
        inherit lib;

        # Premade rice configurations
        preRolledDesktops = mapModules ./rolledDesktops import; # {homeDefaults = self.homeManagerModules.dotfiles;};

        homeManagerModules = 
          {
            dotfiles = ./home.nix;
          } // mapModulesRec ./modules/home-manager import;

        nixosModules = 
          { base = ./configuration.nix; } // mapModulesRec ./modules/nixos import;

        nixosConfigurations = 
          import ./nixos-hosts {
            inherit lib inputs user system pkgs;
          };

        homeConfigurations =
          import ./home {
            inherit lib inputs user system pkgs;
          };
      };

      systems = [ "x86_64-linux" ];

      perSystem = { config, self', inputs', pkgs, system, ... }: {
        devShells = { default = import ./shell.nix { inherit pkgs; }; };
      };
  };
}
