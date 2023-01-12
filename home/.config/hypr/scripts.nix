{ pkgs, ... }:

let
  makeScript = name: text: xdg.configFile."hypr/scripts/${name}" // {
    text = text;
    executable = true;
  };
in {
  xdg.configFile."hypr/scripts" = {
    source = ./scripts;
    recursive = true;
    executable = true;
  };

  makeScript start_dyn ''
    #! /usr/bin/env nix-shell
    #! nix-shell -i bash

    while true
    do
        # echo ""
        out=$(cat ~/.config/hypr/store/dynamic_out.txt)
        echo "$out"  | jq --unbuffered --compact-output
        # cat ~/.config/hypr/scripts/tools/dynamic_out.txt
        sleep 0.5
    done
  '';
}