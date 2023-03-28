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
      flake = false;
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

    nur = {
      url = "github:nix-community/NUR";                                   # NUR Packages
    };
  };

  outputs = inputs @ { self,  nixpkgs, nur, home-manager, emacs-overlay, doom-emacs, hyprland }: 
    let
      user = "qm";
      lib = nixpkgs.lib // {};
    in {
      nixosConfigurations = (
        import ./hosts {
          inherit lib inputs user;
        }
      );

      homeConfigurations = (
        import ./home/homeConfiguration.nix {
          inherit lib inputs user;
        }
      );
  };
}
