{
  description = "A very basic flake";
  
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { self, nixpkgs, nixpkgs-unstable, home-manager }: 
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
    in {
      nixosConfigurations = {
        qmbocks = lib.nixosSystem {
          inherit system;
          modules = [ ./hosts/qmbocks/configuration.nix ];
        };
      nixosConfigurations = {
        lapeaux = lib.nixosSystem {
          inherit system;
          modules = [ ./hosts/lapeaux/configuration.nix ];
        };
      };
  };
}
