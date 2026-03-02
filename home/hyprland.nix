{ pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
  };

  programs.waybar.enable = true;

  services.dunst.enable = true;
}
