{ config, lib, pkgs, ... }:
let
  pkgs = import <nixpkgs> { };

  buildFirefoxXpiAddon = { pname, version, addonId, url, sha256, meta, ... }:
    pkgs.stdenv.mkDerivation {
      name = "${pname}-${version}";

      inherit meta;

      src = pkgs.fetchurl { inherit url sha256; };

      preferLocalBuild = true;
      allowSubstitutes = false;

      buildCommand = ''
        dst="$out/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}"
        mkdir -p "$dst"
        install -v -m644 "$src" "$dst/${addonId}.xpi"
      '';
    };
in
{
   tridactyl-no-new-tab = buildFirefoxXpiAddon {
    pname = "tridactyl";
    version = "1.21.1";
    addonId = "tridactyl.vim.betas.nonewtab@cmcaine.co.uk";
    url = "https://tridactyl.cmcaine.co.uk/betas/nonewtab/tridactyl_no_new_tab_beta-latest.xpi";
    sha256 = "0fsxjyv2d1j0gwvqqqh5l4zv9jcy1vqkkhxfsx08zd475sczmm0z";
    meta = with pkgs.lib; {
      homepage = "https://github.com/cmcaine/tridactyl";
      description = ''
        Vim, but in your browser. Replace Firefox's control mechanism with one
        modelled on Vim.
        This addon is very usable, but is in an early stage of development.
        We intend to implement the majority of Vimperator's features.
      '';
      license = licenses.asl20;
      platforms = platforms.all;
    };
  };
}
