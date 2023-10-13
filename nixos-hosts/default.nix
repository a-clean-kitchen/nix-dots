{ lib
, inputs
, user
, system
, pkgs
, preRolledDesktops
}:

let
  system = "x86_64-linux";

  pkgs = import nixpkgs {
    inherit system;
    config.allowUnfree = true;
  };

  inherit (inputs) nixpkgs home-manager doom-emacs hyprland;

in {
  xbocks = lib.nixosSystem {
    inherit system;
    specialArgs = {
     inherit inputs user;
     host = {
       hostName = "xbocks";
     };
    };
    modules = [
      hyprland.nixosModules.default
      ./xbocks/configuration.nix
      ./configuration.nix

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {
          inherit user doom-emacs system ;
          inherit pkgs;
          host = {
            hostName = "xbocks";
          };
        };
        home-manager.users.${user} = {
          imports = [(import ../home)] ;
        };
      }
    ];
  };
  lapeaux = lib.nixosSystem {
    inherit system;
    specialArgs = {
     inherit inputs user;
     host = {
       hostName = "lapeaux";
     };
    };
    modules = [
      hyprland.nixosModules.default
      ./lapeaux/configuration.nix
      ./configuration.nix

      home-manager.nixosModules.home-manager {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.extraSpecialArgs = {
          inherit user doom-emacs system ;
          host = {
            hostName = "lapaeux";
          };
        };
        home-manager.users.${user} = {
          imports = [(import ../home)] ;
        };
      }
    ];
  };

#   lapeaux = lib.nixosSystem {
#     inherit system;
#     specialArgs = {
#      inherit inputs user;
#      host = {
#        hostName = "lapeaux";
#      };
#     };
#     modules = [
#       hyprland.nixosModules.default
#       ./lapeaux
#       ./configuration.nix

#       home-manager.nixosModules.home-manager {
#         home-manager.useGlobalPkgs = true;
#         home-manager.useUserPackages = true;
#         home-manager.extraSpecialArgs = {
#           inherit user doom-emacs;
#           host = {
#             hostName = "lapeaux";
#           };
#         };
#         home-manager.users.${user} = {
#           imports = [(import ../home)] ++ [(import ./lapeaux/home.nix)];
#         };
#       }
#     ];
#   };
}

