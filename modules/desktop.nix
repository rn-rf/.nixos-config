{ pkgs, ... }:

{
  services.xserver.enable = true;

  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  programs.hyprland.enable = true;

  services.flatpak.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.symbols-only
  ];

  environment.gnome.excludePackages = with pkgs; [
    gnome-maps
    geary
    epiphany
    yelp
  ];
}
