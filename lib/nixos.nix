# Shamelessly stolen from Henrik Lissner's dotfiles.
# They can be found at
# https://https://github.com/hlissner/dotfiles

{ inputs ? {}, lib, pkgs, ... }:

with lib;
with lib.ql;
let sys = "x86_64-linux";
in {
  mkHost = path: attrs @ { system ? sys, ... }:
    nixosSystem {
      inherit system;
      specialArgs = { inherit lib inputs system; };
      modules = [
        {
          nixpkgs.pkgs = pkgs;
          networking.hostName = mkDefault (removeSuffix ".nix" (baseNameOf path));
        }
        (filterAttrs (n: v: !elem n [ "system" ]) attrs)
        ../.   # /default.nix
        (import path)
      ];
    };

  mapHosts = dir: attrs @ { system ? system, ... }:
    mapModules dir
      (hostPath: mkHost hostPath attrs);
}