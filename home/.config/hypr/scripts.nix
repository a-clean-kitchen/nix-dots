{ pkgs, ... }:

{
  xdg.configFile."hypr/scripts" = {
    source = ./scripts;
    recursive = true;
    executable = true;
  };
}