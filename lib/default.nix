{ pkgs, lib, inputs ? {} }:

let
  inherit (lib) nixosSystem;
  inherit (inputs.home-manager.lib) homeManagerConfiguration;
in
{
  mkNixOSSystem = { hostname, pkgs, system }:
    let 
    
    in nixosSystem { inherit pkgs; inherit inputs;};
}