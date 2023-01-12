{ pkgs, ... }:

{
  # xdg.configFile."hypr/autostart" = {
  #   executable = true;
  #   text = builtins.readFile ./autostart;
  # };

  xdg.configFile."hypr/scripts/tools/start_dyn" = {
    executable = true;
    text = builtins.readFile ./scripts/tools/start_dyn;
  };

  xdg.configFile."hypr/scripts/tools/notif" = {
    executable = true;
    text = builtins.readFile ./scripts/tools/notif;
  };

  xdg.configFile."hypr/scripts/tools/expand" = {
    executable = true;
    text = builtins.readFile ./scripts/tools/expand;
  };

  xdg.configFile."hypr/scripts/tools/dynamic" = {
    executable = true;
    text = builtins.readFile ./scripts/tools/dynamic;
  };

  xdg.configFile."hypr/scripts/expand_toolbar" = {
    executable = true;
    text = builtins.readFile ./scripts/expand_toolbar;
  };

  xdg.configFile."hypr/scripts/launch_waybar" = {
    executable = true;
    text = builtins.readFile ./scripts/launch_waybar;
  };

  xdg.configFile."hypr/scripts/rgb_borders" = {
    executable = true;
    text = builtins.readFile ./scripts/rgb_borders;
  };

  xdg.configFile."hypr/scripts/screenshot" = {
    executable = true;
    text = builtins.readFile ./scripts/screenshot;
  };

  xdg.configFile."hypr/scripts/workspaces" = {
    executable = true;
    text = builtins.readFile ./scripts/workspaces;
  };

  xdg.configFile."hypr/scripts/wall" = {
    executable = true;
    text = builtins.readFile ./scripts/wall;
  };

  xdg.configFile."hypr/scripts/toolbar_state" = {
    executable = true;
    text = builtins.readFile ./scripts/toolbar_state;
  };

  # NEED TO GET SWAYLOCKD WORKING ON NIX BEFORE I DO THIS
  # or just flat out replace it idk...
  #
  # xdg.configFile."hypr/scripts/lock" = {
  #   executable = true;
  #   text = builtins.readFile ./scripts/lock;
  # };
}