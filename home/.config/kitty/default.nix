{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    settings = {
      window_padding_width = 15;
      font_size = 12;
    };
    extraConfig = ''
      # BEGIN_KITTY_THEME
      # Rosé Pine
      include Catppuccin.conf
      # END_KITTY_THEME 
    '';  
  };
  xdg.configFile."kitty/Catpuccin.conf".source = ./Catppuccin.conf;
}