{ pkgs, ... }:

{
  services.xserver.enable = true;

  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  programs.hyprland.enable = true;

  services.flatpak.enable = true;

  environment.gnome.excludePackages = with pkgs; [
    gnome-maps
    geary
    epiphany
    yelp
  ];
}
