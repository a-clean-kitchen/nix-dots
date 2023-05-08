{ pkgs, ... }:

{
  programs.zathura = {
    enable = true;
    extraConfig = ''
      include catppuccin-macchiato
    '';
  };
}