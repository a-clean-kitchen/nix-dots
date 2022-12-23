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
      url = "github:vaxerski/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";                                   # NUR Packages
    };
  };

  outputs = inputs @ { self, nixpkgs, nur, home-manager, emacs-overlay, doom-emacs, hyprland }: 
    let
      user = "qm";
    in {
      nixosConfigurations = {
        import ./hosts {
          inherit (nixpkgs) lib;
          inherit inputs;
          inherit (inputs) home-manager nixpkgs nur home-manager doom-emacs hyprland;
          inherit user;
        };
      };
  };
}
