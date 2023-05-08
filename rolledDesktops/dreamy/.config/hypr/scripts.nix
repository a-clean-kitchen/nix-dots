{ pkgs, ... }:

{
  # xdg.configFile."hypr/autostart" = {
  #   executable = true;
  #   source = ./autostart;
  # };

  xdg.configFile."hypr/scripts/tools/start_dyn" = {
    executable = true;
    source = ./scripts/tools/start_dyn;
  };

  xdg.configFile."hypr/scripts/tools/notif" = {
    executable = true;
    source = ./scripts/tools/notif;
  };

  xdg.configFile."hypr/scripts/tools/expand" = {
    executable = true;
    source = ./scripts/tools/expand;
  };

  xdg.configFile."hypr/scripts/tools/dynamic" = {
    executable = true;
    source = ./scripts/tools/dynamic;
  };

  xdg.configFile."hypr/scripts/expand_toolbar" = {
    executable = true;
    source = ./scripts/expand_toolbar;
  };

  xdg.configFile."hypr/scripts/launch_waybar" = {
    executable = true;
    source = ./scripts/launch_waybar;
  };

  xdg.configFile."hypr/scripts/rgb_borders" = {
    executable = true;
    source = ./scripts/rgb_borders;
  };

  xdg.configFile."hypr/scripts/screenshot" = {
    executable = true;
    source = ./scripts/screenshot;
  };

  xdg.configFile."hypr/scripts/workspaces" = {
    executable = true;
    source = ./scripts/workspaces;
  };

  xdg.configFile."hypr/scripts/wall" = {
    executable = true;
    source = ./scripts/wall;
  };

  xdg.configFile."hypr/scripts/lock" = {
    executable = true;
    source = ./scripts/lock;
  };

  xdg.configFile."hypr/scripts/toolbar_state" = {
    executable = true;
    source = ./scripts/toolbar_state;
  };

  xdg.configFile."hypr/scripts/pre-built/rgb" = {
    executable = true;
    source = ./scripts/pre-built/rgb;
  };

  xdg.configFile."hypr/scripts/pre-built/swww" = {
    executable = true;
    source = ./scripts/pre-built/swww;
  };
  # NEED TO GET SWAYLOCKD WORKING ON NIX BEFORE I DO THIS
  # or just flat out replace it idk...
  #
  # xdg.configFile."hypr/scripts/lock" = {
  #   executable = true;
  #   source = ./scripts/lock;
  # };
}