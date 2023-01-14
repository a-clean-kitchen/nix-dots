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

      tab_bar_min_tabs            1
      tab_bar_edge                bottom
      tab_bar_style               powerline
      tab_powerline_style         slanted
      tab_title_template          {title}{' :{}:'.format(num_windows) if num_windows > 1 else ' '}
    '';  
  };
  xdg.configFile."kitty/Catppuccin.conf".source = ./Catppuccin.conf;
}