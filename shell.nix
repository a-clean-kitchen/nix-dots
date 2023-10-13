{ pkgs ? import <nixpkgs> {}, nixd }:

with pkgs;
let nixBin =
      writeShellScriptBin "nix" ''
        ${nixFlakes}/bin/nix --option experimental-features "nix-command flakes" "$@"
      '';
in mkShell {
  buildInputs = [
    git
    nixos-rebuild
    home-manager
  ];
  shellHook = ''
    export FLAKE="$(pwd)"
    export PATH="$FLAKE/bin:${nixBin}/bin:$PATH"
  '';
}
